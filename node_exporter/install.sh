#!/bin/bash

# Thoát ngay nếu có lỗi xảy ra
set -e

# Tạo thư mục cài đặt
mkdir -p /node_exporter
cd /node_exporter

# Tạo user không đăng nhập
useradd -rs /bin/false nodeusr || true

# Tải Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0-rc.0/node_exporter-1.4.0-rc.0.linux-amd64.tar.gz

# Giải nén
tar -xzvf node_exporter-1.4.0-rc.0.linux-amd64.tar.gz

# Di chuyển binary vào /usr/local/bin
mv node_exporter-1.4.0-rc.0.linux-amd64/node_exporter /usr/local/bin/

# Tạo file service cho systemd
cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=nodeusr
Group=nodeusr
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Khởi động và enable service
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter

# Hiển thị trạng thái
systemctl status node_exporter
