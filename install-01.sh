#!/bin/sh
#   echo "https://github.com/WpTestLabs/NginxDkrCtrlLib-01/install-01.sh"

  install -pm 740 -o root -g root -t $SrvLib  cfNgxDkrLib.sh
  ln -srf $SrvBin/cfKnCli.sh $SrvBin/ngx
