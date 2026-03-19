#!/bin/bash

ARQUIVO="access.log"

if [ ! -f "$ARQUIVO" ]; then
    echo "Arquivo $ARQUIVO não encontrado!"
    exit 1
fi

total_linhas=$(wc -l < "$ARQUIVO")
total_erros=$(grep -i "error" "$ARQUIVO" | wc -l)
ips_unicos=$(awk '{print $1}' "$ARQUIVO" | sort | uniq | wc -l)
ip_top=$(awk '{print $1}' "$ARQUIVO" | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
downloads=$(grep -i "download" "$ARQUIVO" | wc -l)

echo "RELATÓRIO"
echo "Total linhas: $total_linhas"
echo "Total erros: $total_erros"
echo "IPs únicos: $ips_unicos"
echo "Top IP: $ip_top"
echo "Downloads: $downloads"
