#!/bin/bash

# Verifica argumento
if [ $# -lt 1 ]; then
    echo "Uso: ./analyze_logs.sh <arquivo_de_log>"
    exit 1
fi

file="$1"

# Verifica se existe
if [ ! -f "$file" ]; then
    echo "Ficheiro não existe"
    exit 1
fi

# Contador de erros com loop
errors=0
while IFS= read -r line
do
    case "$line" in
        *ERROR*) ((errors++)) ;;
    esac
done < "$file"

# Relatório inicial
total_linhas=$(wc -l < "$file")
total_erros=$(grep -i "error" "$file" | wc -l)
ips_unicos=$(awk '{print $2}' "$file" | sort | uniq | wc -l)
ip_top=$(awk '{print $2}' "$file" | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
downloads=$(grep -i "download" "$file" | wc -l)

echo "RELATÓRIO"
echo "Total linhas: $total_linhas"
echo "Total erros: $total_erros"
echo "IPs únicos: $ips_unicos"
echo "Top IP: $ip_top"
echo "Downloads: $downloads"
echo "2- Total de erros (loop): $errors"

# MENU
while true
do
  echo ""
  echo "MENU"
  echo "1 - Total linhas"
  echo "2 - Total erros"
  echo "3 - IPs únicos"
  echo "4 - Top IP"
  echo "5 - Downloads"
  echo "6 - Sair"
  echo "7 - Gerar relatório para ficheiro"

  read option

  case $option in
   1)
     wc -l "$file"
     ;;
   2)
     grep ERROR "$file" | wc -l
     ;;
   3)
     cut -d " " -f2 "$file" | sort | uniq | wc -l
     ;;
   4) 
     cut -d " " -f2 "$file" | sort | uniq -c | sort -nr | head -n1
     ;;
   5)
     grep DOWNLOAD "$file" | wc -l
     ;;
   6)
     exit 0
     ;;
   7)
     echo "Gerando relatório..."

     total_linhas=$(wc -l < "$file")
     total_erros=$(grep ERROR "$file" | wc -l)
     ips_unicos=$(cut -d " " -f2 "$file" | sort | uniq | wc -l)
     top_ip=$(cut -d " " -f2 "$file" | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')
     downloads=$(grep DOWNLOAD "$file" | wc -l)

     {
       echo "RELATÓRIO"
       echo "Total linhas: $total_linhas"
       echo "Total erros: $total_erros"
       echo "IPs únicos: $ips_unicos"
       echo "Top IP: $top_ip"
       echo "Downloads: $downloads"
     } > relatorio.txt

     echo "Relatório criado: relatorio.txt"
     ;;
   *)
     echo "Opção inválida"
     ;;
  esac
done
