# Dev-setup of pgAdmin

This directory holds configuration for a simple deployment of pgAdmin on your local machine, assuming you have [`docker-compose`](https://docs.docker.com/compose/) installed.

## Step 1. Prerequisites

This setup is intended for a use-case where you want to connect to a PostgreSQL instance running in a cluster. Because of this you have to create a `port-forward` tunnel to it, which is accessible to the pgAdmin container. This is achieved by forwarding to the (docker bridge) network instead of the default localhost.

Define a network to use for this setup (you can change this address if you want):

```shell
export PGADMIN_PORT_FWD_IP=172.100.1.1
```

When starting pgAdmin (see below), this network address will be made available on your machine.

## Step 2. Start pgAdmin

```shell
docker-compose up -d
```

## Step 3. Start port-forward tunnel

```shell
kubectl -n common port-forward svc/postgresql --address=${PGADMIN_PORT_FWD_IP:?} 5432
```

> This assumes that PostgreSQL runs on its default port (5432)

### Step 4. Login to pgAdmin

Based on step 2 above, you should now be able to access the locally hosted app at `http://localhost:5050`.

Login credentials:

* Username: `admin@admin.com`
* Password: `admin`

> ❗These are ***not*** the admin credentials to the PostgreSQL instance in the cluster!


## Step 5.  Configure pgAdmin (connect to the PostgreSQL instance)

1. Either select "Add New Server" from the "Quick Links" or right-click on "Servers" in the Browser and choose "Register" -> "Server".
2. Name your connection to whatever you want, e.g. "postgresql" (really doesn't matter)
3. In the "Connection" tab enter:
   * "Host name/address": "tunnel-host"
   * Other fields according to your PostgreSQL deployment, typically only have to change "Username" and "Password".
   * Enable "Save password" to make things easier for you but don't forget to remove the docker volume when you're done (see further down)

## Afterwards; Stop pgAdmin

### Temporary stop (keep container)

```shell
docker-compose down
```

### Stop and clean containers/images - but retain volume (settings and files)

```shell
docker-compose down --rmi all
```

> ❗If you have entered secret credentials while using pgAdmin, these may remain in your lingering volume.
>
> Good or bad? - Your call.

### Stop and remove everything

```shell
docker-compose down --rmi all --volumes
```

> The stored credentials are now gone.

## Bonus; Access saved files

If you use the pgAdmin GUI to save files, e.g. backup dumps, then these files are probably stored (inside the container) at `/var/lib/pgadmin/storage/admin_admin.com/`. So you could for example copy a file to your host machine using this command:

```shell
docker cp pgadmin4_container:/var/lib/pgadmin/storage/admin_admin.com/my-db.dump ./
```

## Running the `pg-` tools from a CLI

The pgAdmin GUI can be used for backup/restore but that is just a wrapper around the common `pg_dump` and `pg_restore` tools. If you prefer to use those while not having to install them on your machine you can `exec` into the container like this:

```console
$ docker exec -it pgadmin4_container sh
/pgadmin4 $ ./usr/local/pgsql-14/pg_dump --version
pg_dump (PostgreSQL) 14.5
/pgadmin4 $ ./usr/local/pgsql-14/pg_restore --version
pg_restore (PostgreSQL) 14.5
```

> Note that there are other versions of the tools available in the same container, e.g. `/usr/local/pgsql-12/` or `/usr/local/pgsql-13/`.

Remember that every directory under `/var/lib/pgadmin/` is mapped to a volume and can be used to store files that shall survive a container restart.
