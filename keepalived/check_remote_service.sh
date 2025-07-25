#!/bin/bash

# Danh sách endpoint cần kiểm tra (có thể là port Prometheus, Loki, etc.)
endpoints=(
  "http://10.0.139.114:9090/-/ready"        # Prometheus node1
  "http://10.0.139.115:9090/-/ready"        # Prometheus node2
  "http://10.0.139.118:3100/ready"          # Loki node1
  "http://10.0.139.119:3100/ready"          # Loki node2
  "http://10.0.139.120:8428"                # VictoriaMetrics node1
  "http://10.0.139.121:8428"                # VictoriaMetrics node2
  "http://localhost:3000/api/health"        # Grafana local
)

for url in "${endpoints[@]}"; do
  curl -sf --max-time 2 "$url" > /dev/null
  if [ $? -ne 0 ]; then
    echo "❌ Không truy cập được: $url"
    exit 1
  fi
done

exit 0
