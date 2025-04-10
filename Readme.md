# O que é?

Este projeto implementa uma plataforma de pagamentos com arquitetura **CQRS** (Command Query Responsibility Segregation), utilizando **Laravel**, **Docker** e **RabbitMQ**.

---

## 🚀 Funcionalidades

- Cadastro de usuários comuns e lojistas
- Depósitos em carteira
- Transferências entre usuários (exceto lojistas enviando)
- Consulta de saldo e transações
- Envio de notificações via serviço externo
- Sincronização entre serviços via RabbitMQ
- Separação de Command (escrita) e Query (leitura)

---

## 🧱 Estrutura do Projeto


apps/ #

    ├── command-service/ # Serviço de escrita (Laravel) #

    ├── query-service/ # Serviço de leitura (Laravel) #

├── docker-compose.yml # Orquestração Docker #

├── .DockerFile #

├── README.md # Este arquivo


---

## ⚙️ Pré-requisitos

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Git](https://git-scm.com/)

---

## 🧪 Instalação

```bash
# Clone o repositório principal
cd apps/
git clone git@github.com:NandoSantana/query-service.git
git clone git@github.com:NandoSantana/command-service.git


# Construa e suba os containers
docker compose up -d --build

# Dentro do container query-service 
/bin/bash
cd query-service 
php artisan migrate

# Dentro do container command-service 
/bin/bash
cd command-service 
php artisan migrate

# Dentro da pasta command-service do container que recebe os dados de command-service 
── php artisan test 

# Dentro da pasta query-service do container que recebe os dados de command-service 
── php artisan consume:transactions


# Rotas 
[POST] http://localhost/api/command/deposit -> Body:JSON {"user_id":1, "amount":700} # 1 ou 2
[POST] http://localhost/api/command/transfer -> Body:JSON {"payer_id":1, "payee_id":2, "amount":50}

# Rotas de consulta
[GET] http://localhost:81/api/wallet/1/balance # usuario 1 ou 2 
[GET] http://localhost:81/api/wallet/1/transactions #usuário 1 ou 2



