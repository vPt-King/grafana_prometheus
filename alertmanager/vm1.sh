docker run -d --name alertmanager \
  -p 9093:9093 \
  -v $(pwd)/alertmanager.yml:/etc/alertmanager/alertmanager.yml \
  prom/alertmanager:v0.26.0 \
  --config.file=/etc/alertmanager/alertmanager.yml \
  --cluster.listen-address=0.0.0.0:9094 \
  --cluster.advertise-address=10.0.139.116:9094 \
  --cluster.peer=10.0.139.117:9094
