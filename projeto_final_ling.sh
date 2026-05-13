#!/bin/bash
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 51f2ee7acf2db38d64a9b673f33296d7e4b2c630
set -o pipefail

# ---------------- VALIDAÇÃO ----------------
if [ $# -lt 1 ]; then
    echo "Uso: ./analyzer.sh <ficheiro> [user=USER] [action=TIPO]"
<<<<<<< HEAD
=======
=======

if [ $# -lt 1 ]; then
    echo "Uso: ./analyze_logs.sh <arquivo_de_log>"
>>>>>>> 55261279736b9d92a3b146397125f050b320a23b
>>>>>>> 51f2ee7acf2db38d64a9b673f33296d7e4b2c630
    exit 1
fi

file="$1"
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 51f2ee7acf2db38d64a9b673f33296d7e4b2c630
user_filter=""
action_filter=""

# ---------------- ARGUMENTOS EXTRA ----------------
for arg in "$@"; do
    case $arg in
        user=*)
            user_filter="${arg#*=}"
            ;;
        action=*)
            action_filter="${arg#*=}"
            ;;
    esac
done

# ---------------- VERIFICAR FICHEIRO ----------------
<<<<<<< HEAD
=======
=======

>>>>>>> 55261279736b9d92a3b146397125f050b320a23b
>>>>>>> 51f2ee7acf2db38d64a9b673f33296d7e4b2c630
if [ ! -f "$file" ]; then
    echo "Ficheiro não existe"
    exit 1
fi

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 51f2ee7acf2db38d64a9b673f33296d7e4b2c630
# ---------------- FILTRAR DADOS ----------------
filter_data() {
    awk -v user_filter="$user_filter" -v action_filter="$action_filter" '
    {
        user=$1
        ip=$2
        action=$3

        if (user_filter != "" && user != user_filter) next;
        if (action_filter != "" && toupper(action) != toupper(action_filter)) next;

        print
    }' "$file"
}

DATA="$(filter_data)"

if [ -z "$DATA" ]; then
    echo "⚠️ Nenhum resultado encontrado com os filtros aplicados"
    exit 0
fi

# ---------------- FUNÇÕES ----------------
total_linhas() {
    echo "$DATA" | wc -l
}

total_erros() {
    echo "$DATA" | grep -i "error" | wc -l
}

uploads() {
    echo "$DATA" | grep -i "upload" | wc -l
}

erros_500() {
    echo "$DATA" | grep "500" | wc -l
}

ips_unicos() {
    echo "$DATA" | awk '{print $2}' | sort | uniq | wc -l
}

top_ip() {
    local result
    result=$(echo "$DATA" | awk '{print $2}' | sort | uniq -c | sort -nr | head -1)

    [ -z "$result" ] && { echo "Sem dados"; return; }

    echo "$result" | awk '{print $2}'
}

top5_ips() {
    echo "$DATA" | awk '{print $2}' | sort | uniq -c | sort -nr | head -5 \
    | awk '{print $2 " -> " $1 " acessos"}'
}

utilizador_mais_ativo() {
    echo "$DATA" | awk '{print $1}' | sort | uniq -c | sort -nr | head -1 \
    | awk '{print $2 " (" $1 " ações)"}'
}

recurso_mais_acedido() {
    echo "$DATA" | awk '{print $3}' | sort | uniq -c | sort -nr | head -1 \
    | awk '{print $2 " (" $1 " acessos)"}'
}

downloads() {
    echo "$DATA" | grep -i "download" | wc -l
}

# ---------------- RELATÓRIO ----------------
mostrar_relatorio() {
    echo "================================="
    echo "        RELATÓRIO FINAL"
    echo "================================="
    echo "Total linhas: $(total_linhas)"
    echo "Erros: $(total_erros)"
    echo "Uploads: $(uploads)"
    echo "Erros 500: $(erros_500)"
    echo "IPs únicos: $(ips_unicos)"
    echo "Top IP: $(top_ip)"
    echo "Downloads: $(downloads)"
    echo "Utilizador mais ativo: $(utilizador_mais_ativo)"
    echo "Recurso mais acedido: $(recurso_mais_acedido)"
    echo "Top 5 IPs:"
    top5_ips
}

# ---------------- GUARDAR RELATÓRIO ----------------
guardar_relatorio() {
    data=$(date +"%Y-%m-%d_%H-%M-%S")
    ficheiro_saida="relatorio_$data.txt"

    {
        echo "RELATÓRIO"
        echo "Data: $data"
        echo "Total linhas: $(total_linhas)"
        echo "Erros: $(total_erros)"
        echo "Uploads: $(uploads)"
        echo "Erros 500: $(erros_500)"
        echo "IPs únicos: $(ips_unicos)"
        echo "Top IP: $(top_ip)"
        echo "Downloads: $(downloads)"
        echo "Utilizador mais ativo: $(utilizador_mais_ativo)"
        echo "Recurso mais acedido: $(recurso_mais_acedido)"
        echo "Top 5 IPs:"
        top5_ips
    } > "$ficheiro_saida"

    echo "Relatório guardado em $ficheiro_saida"
}

# ---------------- EXECUÇÃO ----------------
mostrar_relatorio

# ---------------- MENU ----------------
while true; do
    echo ""
    echo "MENU"
    echo "1 - Total linhas"
    echo "2 - Erros"
    echo "3 - IPs únicos"
    echo "4 - Top IP"
    echo "5 - Downloads"
    echo "6 - Sair"
    echo "7 - Guardar relatório"

    read -p "Opção: " option

    case $option in
        1) total_linhas ;;
        2) total_erros ;;
        3) ips_unicos ;;
        4) top_ip ;;
        5) downloads ;;
        6) exit 0 ;;
        7) guardar_relatorio ;;
        *) echo "Opção inválida" ;;
    esac
done
<<<<<<< HEAD





=======
=======
total_linhas() {
    wc -l < "$file"
}

total_erros() {
    grep -i "error" "$file" | wc -l
}

ips_unicos() {
    awk '{print $2}' "$file" | sort | uniq | wc -l
}

top_ip() {
    awk '{print $2}' "$file" | sort | uniq -c | sort -nr | head -1 | awk '{print $2}'
}

downloads() {
    grep -i "download" "$file" | wc -l
}

contar_erros_loop() {
    errors=0
    while IFS= read -r line
    do
        case "$line" in
     *ERROR*) ((errors++)) ;;
        esac
    done < "$file"

    echo "$errors"
}

mostrar_relatorio() {
    echo "RELATÓRIO"
    echo "Total linhas: $(total_linhas)"
    echo "Total erros: $(total_erros)"
    echo "IPs únicos: $(ips_unicos)"
    echo "Top IP: $(top_ip)"
    echo "Downloads: $(downloads)"
    echo "Erros (loop): $(contar_erros_loop)"
}

guardar_relatorio() {
    {
        echo "RELATÓRIO"
        echo "Total linhas: $(total_linhas)"
        echo "Total erros: $(total_erros)"
        echo "IPs únicos: $(ips_unicos)"
        echo "Top IP: $(top_ip)"
        echo "Downloads: $(downloads)"
    } > relatorio.txt

    echo "Relatório criado: relatorio.txt"
}

mostrar_relatorio

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
     total_linhas
     ;;
   2)
     total_erros
     ;;
   3)
     ips_unicos
     ;;
   4) 
     top_ip
     ;;
   5)
     downloads
     ;;
   6)
     exit 0
     ;;
   7)
     echo "Gerando relatório..."
     guardar_relatorio
     ;;
   *)
     echo "Opção inválida"
     ;;
  esac
done
>>>>>>> 55261279736b9d92a3b146397125f050b320a23b
>>>>>>> 51f2ee7acf2db38d64a9b673f33296d7e4b2c630
