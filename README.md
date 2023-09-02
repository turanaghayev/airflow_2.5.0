# airflow_2.5.0
# Create the airflow directory 

```bash
mkdir airflow
```

# Create directories into airflow directory

```bash
cd airflow
mkdir -p ./dags ./logs ./plugins
```

# Create .env file with AIRFLOW_UUID parameter

```bash
echo -e "AIRFLOW_UID=$(id -u)" > .env
```

# Download plugins

https://www.oracle.com/tw/database/technologies/instant-client/linux-x86-64-downloads.html

# Build docker image

```bash
docker build -t rabita-airflow:2.5.0 .
```

# Init database

```bash
sudo docker-compose up airflow-init
```

# Run Apache Airflow with docker-compose

```bash
sudo docker-compose up -d
```
