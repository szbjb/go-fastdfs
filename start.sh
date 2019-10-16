sleep 1
timeout 2 ./fileserver
port_01=8080
MY_POD_NAME=$(echo  $MY_POD_NAME  |awk  -F  '-' '{print $1,$2,$3,$4,$5}'|sed  's/ /-/g')
IP=$(hostname -i |xargs -n 1   | grep  $(ip route |head  -n 1 | awk    '{print  $3}'  |  awk  -F  '.'  '{print  $1"."$2"."$3}'))
id_01=$( grep  peer_id data/conf/cfg.json | awk    '{print $2}'|awk  -F '"'  '{print $2}')
id_02=$PeerID
#cp  -r  /opt/data/  /usr/local/go-fastdfs/
sed   "s/$port_01/$port_01/g"   /usr/local/go-fastdfs/data/conf/cfg.json  -i
sed   "s/$IP/$MY_POD_NAME.default.svc.cluster.local/g"   /usr/local/go-fastdfs/data/conf/cfg.json  -i
sed  "s/download_domain\": \"\"/download_domain\": \"$MY_MASTER_IP:37000\"/g"  /usr/local/go-fastdfs/data/conf/cfg.json   -i
sed   "s/peer_id\": \"$id_01\"/peer_id\": \"$id_02\"/g"   /usr/local/go-fastdfs/data/conf/cfg.json  -i
sleep 1
./fileserver
