# INCEPTION

> Inception is a 42 project that aims to deepen your knowledge of system administration through Docker containerization. You are required to virtualize several services, each running in its own Docker container, and orchestrated with Docker Compose.

## 🛠️ About the Project

This project sets up a classic web architecture using a __LEMP Stack__, and automates the deployment of a WordPress website using Docker containers. It includes:

- **Nginx**: A web server used as a reverse proxy and the single entrypoint to the infrastructure.
- **MariaDB**: A MySQL-compatible database engine storing the WordPress data.
- **WordPress**: A PHP-based CMS for managing dynamic web content.

Each service is containerized and configured manually from scratch (no pre-built images except Alpine/Debian bases), according to the subject constraints.

### 💡 Expected Architecture Diagram

![inception_diag](diag.png)

### ⚠️ Recommendations

- You **must use a Virtual Machine** (VM) to run this project.
- It's recommended to name your VM using your login (`antauber`) to simplify volume and path management.

## 🚧 Prerequisites

To run the project, ensure you have:
- Installed [Docker](https://docs.docker.com/get-started/get-docker/)
- Installed [Docker Compose](https://docs.docker.com/compose/install/)
- Make sure our user has root privileges and be in the docker groupe:
```bash
sudo usermod -aG docker $USER
```
- Updated `/etc/hosts` with your domain(s):
```bash
127.0.0.1 antauber.42.fr
127.0.0.1 adminer.antauber.42.fr	# BONUS Adminer
127.0.0.1 gimme.antauber.42.fr		# BONUS Static Page
```
- Created:
  - a `.env` file under `srcs/`
  - a `secrets/` folder with credentials (ignored in git)

> ⚠️ For security reasons, **never push `.env` or secrets** to any public repo — they’re only included locally for demonstration.

## 📦 Makefile

The `Makefile` manages the Docker Compose lifecycle:

| Command         | Description                                          |
|----------------|------------------------------------------------------|
| `make all`      | Builds and starts all services (`make build` + `make up`) |
| `make re`       | Rebuilds everything (⚠️ deletes volumes and images!) |
| `make fclean`   | Stops and removes all containers/images/volumes     |
| `make status`   | Shows current status, containers, volumes, and IPs  |
| `make connectivity` | Pings between services to check network connectivity |
| `make monitor`  | Shortcut to launch the ctop tool inside its container |

> ⚠️ **MariaDB Healthcheck**: Sometimes MariaDB may crash on init. A `make re` usually resolves it, but it resets the environment completely. Sorry for this...

## 🔐 Mandatory Part Overview

### Docker


### Nginx


### MariaDB


### Wordpress


## 💎 Bonus Part

### 🧠 Redis Cache

Adds caching to WordPress via Redis, reducing redundant SQL queries and improving performance.
We can monitor it directly in our admin wordpress page.

### 📁 FTP Server

Passive-mode FTP server to upload/download WordPress files. Connect with:
```bash
ftp localhost 21
USER ftp_user
PASS 1234
```

### 🧮 Adminer

Single PHP file to manage the database from a browser.
Accessible at: `http://adminer.antauber.42.fr`

### 📊 Ctop (bonus of our choice)
A CLI tool to view container resource usage. Installed as a bonus service and accessed via:
```bash
docker exec -it ctop /usr/local/bin/ctop
```
> I first try to use [Glances](https://glances.readthedocs.io/en/latest/docker.html) for monitor the containers but I wasn't able to look at only the containers (it was show me the all htop computer).

### 🌐 Static Page

A minimal static HTML site (bonus) served on: `http://gimme.antauber.42.fr`

## 🗂️ Architecture Overview
```
.
├── Makefile
├── secrets/
│   ├── ftp_user_password.txt
│   ├── mysql_password.txt
│   ├── mysql_root_password.txt
│   ├── wp_admin_password.txt
│   └── wp_user_password.txt
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── bonus/
        │   ├── adminer/
        │   ├── ctop/
        │   ├── ftp/
        │   ├── redis/
        │   └── static_page/
        ├── mariadb/
        ├── nginx/
        └── wordpress/
```

## 📚 Sources

- [Ctop Documentation](https://www.tecmint.com/ctop-monitor-docker-containers/)

## Credits
Made by **antauber** `[42 Angouleme - July 25]`