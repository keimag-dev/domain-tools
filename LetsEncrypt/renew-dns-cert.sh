#!/bin/bash

DOMAIN="yourdomain.com"
CERT_DIR="/etc/letsencrypt/live/$DOMAIN"
SOFTETHER_DIR="/usr/local/vpnserver"  # SoftEtherのインストール先
CRT_TARGET="$SOFTETHER_DIR/vpn_server.crt"
KEY_TARGET="$SOFTETHER_DIR/vpn_server.key"

# 1. certbotの自動更新実行（更新されたときだけ更新処理）
certbot renew --quiet --deploy-hook "/usr/local/bin/renew_softether_cert.sh.update"