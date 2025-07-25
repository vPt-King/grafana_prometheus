docker run -d --name alertmanager \
  -p 9093:9093 \
  -v alertmanager.yml:/etc/alertmanager/alertmanager.yml \
  -v ./data:/alertmanager \
  prom/alertmanager:v0.26.0 \
  --config.file=/etc/alertmanager/alertmanager.yml \
  --cluster.listen-address=0.0.0.0:9094 \
  --cluster.advertise-address=192.168.1.10:9094 \
  --cluster.peer=192.168.1.11:9094