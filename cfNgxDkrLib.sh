#!/bin/bash
echo "start: $SrvLib/cfNgxDkrLib.sh"
if [[ ! -e $KnBasHP ]]; then  echo ">>>> DII: $KnRtN ($KnPkgN) at $KnBasHP"
mkdir -p  $KnBasHP/{etc/$KnPkgN/conf.d,log/$KnPkgN}  #xx $WwwDfltSwc $WwwPrfl/All
[[ -e $SrvEtcKnz/$KnN ]] || ln -srf $SrvEtcKnz/$KnN  $KnBasHP 
#xx [[ -e $SrvEtcKnz/$KnPkgN ]] || ln -sf $SrvEtcKnz/$KnN $SrvEtcKnz/$KnPkgN
[[ -e $KnBasHP/etc/$KnPkgN/nginx.conf ]] || \
			cp -rd $SrvLib/ngxCnf/v1/* $KnBasHP/etc/$KnPkgN/
[[ -e $KnBasHP/srv ]] || ln -sf ../.. $KnBasHP/srv;  # '/srv/' mimics Guest View of FSH
[[ -e $KnBasHP/etc/nginx/Prfl ]] || ln -sf ../../srv/www/Prfl $KnBasHP/etc/nginx/Prfl
[[ -e $KnBasHP/etc/nginx/conf.d/WwwPrfl.conf ]] || \
			ln -sf ../Prfl/All/all-ngx.inc $KnBasHP/etc/nginx/conf.d/WwwPrfl.conf
fi			#tt	tree -ACa  $KnBasHP;		tree -ACaL 3 $SrvWww;		exit;
.	$SrvLib/cfDkrCtrlLib.sh
aTail () { echo -e "\n\n\ntail -n100 $KnLogHP/access.log;"
	tail -n100  $KnLogHP/access.log; }
eTail () { echo -e "\n\n\ntail -n100 $KnLogHP/error.log;"
	tail -n100 $KnLogHP/error.log; }
#echo docker exec -it $FQKanRtN __Cmd-here__    @@@@ ?????????????/
ConfTst () { DkrCmd2CID "exec -it" nginx -t ; }
V () { DkrCmd2CID "exec -it" nginx -V ; }
_signal () {  docker exec -it $KnGrpN._.nginx nginx -s $1; }  # @@ ==> CID ?????????
Quit ()   { _signal quit; }
Reload () { _signal reload; }  # also add: nginx -t?? to test conf
Reopen () { _signal reopen; }
Stop ()   { _signal stop; }
LogRotate () {
	local ts=`date +%Y%m%d-%H%M-%Z`;    			echo "  LogRotate - Time Stamp: $ts";
		echo -e "\nLogRotate - Start - ls $KnLogHP";   	ls -al $KnLogHP
	mv $KnLogHP/access.log $KnLogHP/access-bu$ts.log
	mv $KnLogHP/error.log $KnLogHP/error-bu$ts.log 
	echo -e "\n\nLogRotate - after rename - ls $KnLogHP";   ls -al $KnLogHP
	Reopen
	echo -e "\n\nLogRotate - after reopen - ls $KnLogHP";   ls -al $KnLogHP
} #---- 
doCli $@  # <<<<<<<
