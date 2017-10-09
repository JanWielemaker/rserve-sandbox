#!/bin/bash

ldata=4000000
ltime=300
lfile=20000

usage()
{ echo "Usage: docker run [docker options] rserve [rserve options]"
  echo "rserve options:"
  echo
  echo "  --bash		 Run bash"
  echo "  --limit-data		 Limit data (K-bytes, default 4000000)"
  echo "  --limit-time		 Limit time (Seconds, default 300)"
  echo "  --limit-file		 Limit file size (K-bytes, default 20000)"
}

while [ ! -z "$1" ]; do
  case "$1" in
    --bash)		/bin/bash
			exit 0
			;;
    --limit-data=*)	ldata="$(echo $1 | sed 's/[^=]*=//')"
			shift
			;;
    --limit-time=*)	ltime="$(echo $1 | sed 's/[^=]*=//')"
			shift
			;;
    --limit-file=*)	lfile="$(echo $1 | sed 's/[^=]*=//')"
			shift
			;;
    --help)		usage
			exit 0
			;;
    *)			usage
			exit 1
  esac
done

# Set some hard limits
ulimit -d $ldata
ulimit -t $ltime
ulimit -f $lfile

mkuser()
{ f="$1"
  u="$2"

  groupadd "$(ls -nd "$f" | awk '{printf "-g %s\n",$4 }')" -o $u
  useradd  "$(ls -nd "$f" | awk '{printf "-u %s\n",$3 }')" -g $u -o $u
}

setuser()
{ f="$1"
  ls -nd "$f" | awk '{printf "uid %s\ngid %s\n",$3,$4 }' >> Rserv.conf
}

noroot()
{ f="$1"
  if [ "$(ls -nd "$f" | awk '{printf "%s",$3 }')" = 0 -o \
       "$(ls -nd "$f" | awk '{printf "%s",$4 }')" = 0 ]; then
    useradd -U ruser
    chown ruser.ruser $f
  else
    mkuser $1 ruser
  fi
}

noroot /rserve
setuser /rserve
chown ruser.ruser .

cat Rserv.conf

exec /usr/bin/R CMD Rserve --no-save --RS-conf Rserv.conf
