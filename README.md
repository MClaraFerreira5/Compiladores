# Compiladores
Repositório para as atividades realizadas durante a disciplina de Compiladores

# AT1 - Atividade Prática de Analisadores Léxicos com Flex

Este repositório contém a resolução da **Atividade Prática 1 (AT1)** da disciplina de **Compiladores**, cobrindo a especificação e implementação de analisadores léxicos utilizando a ferramenta **Flex** e a linguagem **C** em ambiente Linux (WSL/Ubuntu).

---

## 📁 Estrutura do Repositório

```text
.
├── AT1/
│   ├── q1/
│   │   ├── q1.l          # Código-fonte Flex
│   │   ├── entrada.txt   # Casos de teste de entrada
│   │   └── saida.txt     # Saída gerada pela execução
│   ├── q2/
│   │   ├── q2.l          # Calculadora de tokens
│   │   ├── entrada.txt   # Casos de teste de entrada
│   │   └── saida.txt     # Saída gerada pela execução
│   ├── q3/
│   │   ├── q3.l          # Analisador para mini-linguagem
│   │   ├── entrada.txt   # Código de teste de entrada
│   │   └── saida.txt     # Saída gerada pela execução
│   └── q4/
│       ├── q4.l          # Analisador com suporte a arquivo via argumento
│       ├── entrada.txt   # Código de teste de entrada
│       └── saida.txt     # Saída gerada pela execução
├── .gitignore            # Arquivos ignorados pelo Git (executáveis e builds)
└── README.md             # Documentação do projeto
```

---

## 🛠️ Requisitos e Dependências

Para compilar e executar os projetos, certifique-se de ter os seguintes pacotes instalados no ambiente WSL/Linux:

* GCC (`build-essential`)
* Flex (`flex`)

Para instalar as dependências no Ubuntu/Debian:

```bash
sudo apt update
sudo apt install build-essential flex -y
```

---

## 🚀 Como Compilar e Executar

### 📌 Questões 1, 2 e 3 (Redirecionamento de Entrada)

Acesse a pasta da questão desejada e siga o fluxo padrão de compilação:

```bash
# Exemplo para a Questão 2 (substitua q2 por q1 ou q3 conforme necessário)
cd AT1/q2

# 1. Gerar o arquivo C a partir da especificação Flex
flex q2.l

# 2. Compilar o código C gerado
gcc lex.yy.c -o q2

# 3. Executar redirecionando a entrada
./q2 
```

### 📌 Questão 4 (Leitura de Arquivo via Argumento)

A Questão 4 recebe o nome do arquivo de entrada diretamente pela linha de comando (`argv[1]`):

```bash
cd AT1/q4

# 1. Gerar e compilar
flex q4.l
gcc lex.yy.c -o q4

# 2. Executar passando o arquivo como parâmetro
./q4 entrada.txt
```

---

## ⚙️ Limpeza dos Artefatos de Build

Este repositório está configurado com um `.gitignore` para garantir que arquivos temporários e executáveis gerados na compilação (`lex.yy.c`, executáveis `q1`, `q2`, `q3`, `q4`) não sejam versionados, mantendo uma estrutura limpa.