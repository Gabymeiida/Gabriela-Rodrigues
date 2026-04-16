#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Uso: ./analyze_logs.sh <arquivo_de_log>"
    exit 1
fi

LOG_FILE="$1"

total_linhas=$(wc -l < "$LOG_FILE")
total_erros=$(grep -i "error" "$LOG_FILE" | wc -l)
ips=$(awk '{print $1}' "$LOG_FILE")
ips_unicos=$(echo "$ips" | sort | uniq | wc -l)
top_ip=$(echo "$ips" | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')
downloads=$(grep -E "GET|POST" "$LOG_FILE" | wc -l)

echo "RELATÓRIO"
echo "Total linhas: $total_linhas"
echo "Total erros: $total_erros"
echo "IPs únicos: $ips_unicos"
echo "Top IP: $top_ip"
