#!/bin/bash

# Copyright (c) 2016, Jan Wielemaker, Franco Masotti.
# See LICENSE file for details.

# Set some hard limits
ulimit -Hd 4000000
ulimit -Ht 300
ulimit -Hf 20000

exec /usr/bin/R CMD Rserve --no-save --RS-conf Rserv.conf
