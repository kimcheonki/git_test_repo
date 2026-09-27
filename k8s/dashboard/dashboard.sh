nohup kubectl proxy --port=8001 --address=192.168.233.173 --accept-hosts='^*$' >/dev/null 2>&1 &
echo "http://192.168.233.173:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
