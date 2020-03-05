#!/bin/bash

# Print all commands executed if DEBUG mode enabled
[ -n "${DEBUG:-""}" ] && set -x

lotus_path="${LOTUS_PATH:-/root/.lotus}"
config_path="${lotus_path}/config.toml"

lotus_storage_path="${LOTUS_STORAGE_PATH:-/root/.lotusstorage}"

mkdir -p $lotus_path $lotus_storage_path

# Add provisioning header
echo "# Managed by 0xO1.IO" >> $config_path

if env | grep -i CONFIG_; then
  for VAR in `env | sort -h`
  do
    if [[ "$VAR" =~ ^CONFIG_ ]]; then
      property_section=`echo "$VAR" | sed -r "s/CONFIG_(.*)_.*=.*/\1/g" | tr _ .`
      if !(grep "\[${property_section}\]" $config_path); then
        echo >> $config_path
        echo "[${property_section}]" >> $config_path
      fi
      property_key=`echo "$VAR" | sed -r "s/CONFIG_.*_(.*)=.*/\1/g" | tr _ .`
      # if section name contains a '.', obtain value from full ENV rather than parse
      if [[ $property_section == *.* ]] ; then
        echo "$property_key = $(echo $VAR | cut -d'=' -f2)" >> $config_path
      else
        property_value=`echo "CONFIG_${property_section}_${property_key}"`
        echo "$property_key = ${!property_value}" >> $config_path
      fi
    fi
  done
fi
