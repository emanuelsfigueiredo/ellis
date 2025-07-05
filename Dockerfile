FROM python:3.13.5-alpine3.21

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# Fazer isso antes de copiar o resto do código aproveita o cache do Docker.
COPY requirements.txt .

# Instala as dependências do projeto
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação vai rodar
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn.
# O host 0.0.0.0 permite que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload", "--workers", "4"]
