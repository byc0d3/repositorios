## Repositorios

### Linux

-   [Repos](#repos)
-   [MobaXterm](#mobaxterm)
-   [Firewalld](#firewalld)
-   [LAMP](#lamp)
-   [httpd](#httpd)
-   [php](#php)
-   [MariaDB](#mariadb)
-   [CI4](#ci4)

## Repos

1- Para descargar todos los repositorios ejecute el siguiente comando:

```
wget -qO- https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/clone_repos.sh | bash
```

## MobaXterm

1- Para generar una licencia descargue el script:

```
wget https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/MobaXterm-Keygen.py
```

2- Ejecute el siguiente comando y reemplase los datos:

```
python3 MobaXterm-Keygen.py usuario version
```

## Firewalld

1- Para desabilitar firewalld ejecute el siguiente comando:

```
wget -qO- https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/remove-firewalld.sh | bash
```

## Lamp

1- Para instalar server LAMP ejecute el siguiente comando:

```
wget -qO- https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/instalar-server-lapm.sh | bash
```

## HTTPD

1- Para instalar httpd ejecute el siguiente comando:

```
wget -qO- https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/install-httpd.sh | bash
```

2- Para crear virtualhost descargue el siguiente scritp y ejecutelo:

```
wget https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/crear-virtualhost.sh
```

## PHP

1- Para instalar php 8.4 ejecute el siguiente comando:

```
wget -qO- https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/install-php84.sh | bash
```

2- Para instalar composer ejecute el siguiente comando:

```
wget -qO- https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/install-composer.sh | bash
```

## MariaDB

1- Para instalar MariaDB ejecute el siguiente comando:

```
wget -qO- https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/install-mariadb.sh | bash
```

## CI4

1- Para restaurar la base de datos de CI4 a su estado original descargue y ejecute este script:

```
wget https://raw.githubusercontent.com/byc0d3/repositorios/refs/heads/main/drop-database-ci4.sh
```
