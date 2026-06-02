\# ELT Datos TEP

Este proyecto recrea el proceso de preprocesamientos de datos visto en los scripts ETL de Pandas para el entrenamiento de modelos de machine learning con el objetivo de clasificar instancias de TEP. 

A diferencia del anterior en el que se utiliza Pandas para construir el etl, ahora usamos \*\*DBT\*\* un software ELT que utiliza \*SQL\* y \*YAML\* para la transformación de datos. 

El proyecto sigue el mismo flujo que en la versión de Pandas, salvo que se retiró el reemplazo de datos atipícos.



\## Stack tecnológico

\- `dbt`

\- `docker compose`





\## Ejecución

1\. Cree un archivo `.env` siguiendo como ejemplo la plantilla `.env.example`.

2\. Inicie los contenedores utilizando el archivo `docker-compose.yml`

```sh

docker compose up -d

```

2\. Una vez creados, compile los modelos a sus respectivas versiones SQL en el contenedor `dbt`

```sh

docker compose exec dbt dbt compile

```

3\. Ejecute el ELT con el comando `dbt build`

```sh

docker compose exec dbt dbt build

```



\## Resultado

Datos listos para ser utilizados en el entrenamiento de modelos de machine learning. Estos pueden ser revisados en el esquema `default_gold` de la base de datos, más especificamente, la tabla `gold\_ml\_discretized`.

