#!/bin/bash

if [[ "$MANAGED_SERVICES" == *"lotus-storage-miner"* ]]; then
  # Launch lotus client in background and execute miner as primary process
  mkdir -p /var/log/lotus
  lotus daemon $EXTRA_ARGS &>/var/log/lotus/daemon.log &
  sleep 3

  exec lotus-storage-miner run $EXTRA_MINER_ARGS
fi

exec lotus daemon $EXTRA_ARGS
