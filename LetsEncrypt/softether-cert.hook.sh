#!/bin/bash

DOMAIN="yourdomain.com"
CERT_DIR="/etc/letsencrypt/live/$DOMAIN"
SOFTETHER_DIR="/usr/local/vpnserver"
CRT_TARGET="$SOFTETHER_DIR/vpn_server.crt"
KEY_TARGET="$SOFTETHER_DIR/vpn_server.key"

echo "[INFO] SoftEther用証明書を更新中..."

# 証明書と秘密鍵をコピー
cp "$CERT_DIR/fullchain.pem" "$CRT_TARGET"
cp "$CERT_DIR/privkey.pem" "$KEY_TARGET"
chmod 600 "$CRT_TARGET" "$KEY_TARGET"

# SoftEther VPN Server 再起動
systemctl restart softether-vpnserver

echo "[INFO] SoftEther VPN Server を再起動しました"