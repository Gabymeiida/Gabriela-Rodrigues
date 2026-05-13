🔍📄 Log Analyzer (Bash Script)

📌 Descrição do Projeto
O Log Analyzer é um script em Bash desenvolvido para analisar ficheiros de log de forma rápida, automática e flexível.
Permite aplicar filtros, gerar estatísticas úteis e criar relatórios completos, tudo através da linha de comandos.

Este projeto foi desenvolvido no âmbito do módulo de Scripting, aplicando também conhecimentos de linha de comandos e controlo de versões com Git.

🚀 Funcionalidades Principais
Filtragem avançada por:

user=USERNAME

action=UPLOAD|DOWNLOAD|ERROR|...

Análise completa dos logs, incluindo:

Total de linhas

Total de erros

Total de uploads

Total de downloads

Erros 500

IPs únicos

Top IP

Top 5 IPs

Utilizador mais ativo

Recurso mais acedido

Menu interativo

Geração automática de relatório com timestamp

Código modular e organizado

📂 Estrutura do Script
O script está dividido em várias secções:

Validação de argumentos

Leitura de filtros

Verificação do ficheiro

Filtragem com AWK

Funções de análise

Relatório final

Menu interativo

🧠 Como Funciona a Filtragem
A filtragem é feita com AWK:

$1 → utilizador

$2 → IP

$3 → ação

O script só mantém linhas que correspondem aos filtros fornecidos.

## 🖥️ Como Executar

1️⃣ **Tornar o script executável**
```bash
chmod +x analyzer.sh

2️⃣ Executar com um ficheiro de log
bash
./analyzer.sh logs.txt
3️⃣ Executar com filtros
bash
./analyzer.sh logs.txt user=joao
./analyzer.sh logs.txt action=UPLOAD
./analyzer.sh logs.txt user=ana action=download
📊 Exemplo de Saída
Código
=================================
        RELATÓRIO FINAL
=================================
Total linhas: 1200
Erros: 45
Uploads: 18
Erros 500: 3
IPs únicos: 27
Top IP: 192.168.1.10
Downloads: 22
Utilizador mais ativo: joao (54 ações)
Recurso mais acedido: DOWNLOAD (80 acessos)
Top 5 IPs:
192.168.1.10 -> 54 acessos
...
📁 Geração de Relatório
O script cria automaticamente um ficheiro como:

Código
relatorio_2026-05-12_20-15-33.txt
Com todas as métricas incluídas.

🧭 Menu Interativo
Após o relatório inicial, o utilizador pode navegar por opções como:

Total de linhas

Total de erros

IPs únicos

Top IP

Downloads

Guardar relatório

Sair

🛠️ Tecnologias Utilizadas
Bash

AWK

Grep

Sort / Uniq

Git para versionamento

🎯 Objetivo do Projeto
Criar uma ferramenta prática e automatizada para análise de logs, consolidando conhecimentos de:

Git

Linha de comandos

Scripting em Bash

👩‍💻 Autora
Gabriela  
Projeto desenvolvido no âmbito do módulo de Linguagens de scripting e linhas de comando.
