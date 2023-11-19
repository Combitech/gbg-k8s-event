# PostgreSQL

Miscellaneous notes on how to install/configure a common and shared instance of PostgreSQL (in the `common` namespace).

## Install

```shell
helm -n common install postgresql oci://registry-1.docker.io/bitnamicharts/postgresql
```

## Access as admin

According to Helm notes:

```shell
export POSTGRES_PASSWORD=$(kubectl get secret --namespace common postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
```

```shell
kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace common --image docker.io/bitnami/postgresql:16.1.0-debian-11-r6 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host postgresql -U postgres -d postgres -p 5432
```

## Create users and databases

```console
 :
postgres=# CREATE DATABASE floskl02;
CREATE DATABASE
postgres=# CREATE USER user02 WITH ENCRYPTED PASSWORD '<... password ...>';
CREATE ROLE
postgres=# GRANT ALL PRIVILEGES ON DATABASE floskl02 TO user02;
GRANT
postgres=# \c floskl02
You are now connected to database "floskl02" as user "postgres".
floskl02=# GRANT USAGE, CREATE ON SCHEMA public TO user02;
GRANT
 :
```


## Debug (insufficient DB permissions)

Connect to specific db as corresponding user

```console
$ kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace common --image docker.io/bitnami/postgresql:16.1.0-debian-11-r6 --env PGPASSWORD=password01 --command -- psql --host postgresql -U user01  -d floskl01 -p 5432
If you don't see a command prompt, try pressing enter.

floskl01=> \conninfo
You are connected to database "floskl01" as user "user01" on host "postgresql" (address "10.105.254.234") at port "5432".

floskl01=> create table users (id SERIAL PRIMARY KEY, username TEXT UNIQUE NOT NULL, password TEXT NOT NULL);
ERROR:  permission denied for schema public
LINE 1: create table users (id SERIAL PRIMARY KEY, username TEXT UNI...
```

> In this case the `GRANT USAGE, CREATE ON SCHEMA public TO user01;` had not been executed.