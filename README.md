# 🚀 Roboshop Deployment Shell Scripts

![Bash](https://img.shields.io/badge/Language-Bash-blue)
![Linux](https://img.shields.io/badge/OS-Linux-orange)
![Automation](https://img.shields.io/badge/Automation-Yes-green)

This repository contains **bash automation scripts** to deploy and configure the **Roboshop microservices application stack**, including NodeJS, Java, Python apps, databases, message brokers, and Nginx.  

---

## ✨ Key Features

- Centralized **common functions** in `common.sh` for:
  - ✅ Root user check (`check_root`)
  - 📝 Logging with timestamps
  - ⚠️ Success/failure validation (`VALIDATE`)
  - ⏱ Measuring total execution time (`print_total_time`)
- Scripts **source `common.sh`** to reuse functions (DRY principle)
- Automated setup for:
  - 🟢 Microservices: NodeJS, Java, Python
  - 🟡 Databases: MongoDB, MySQL
  - 🔵 Message brokers: Redis, RabbitMQ
  - 🌐 Frontend: Nginx

---

## 📌 How `source ./common.sh` Works

- `common.sh` contains shared functions and variables used by all scripts.  
- Each service script starts with:

```bash
source ./common.sh
```

This allows the script to access all functions and variables from common.sh without duplicating code.

**Example usage:**

```bash
source ./common.sh   # Load shared functions
check_root           # Ensure script is run as root
app_setup            # Deploy application code
nodejs_setup         # Install NodeJS dependencies
systemd_setup        # Setup systemd service
app_restart          # Restart service
print_total_time     # Print total execution time

```

📂 **Repository Structure**
| Script         | Description                                                                            |
| -------------- | -------------------------------------------------------------------------------------- |
| `common.sh`    | Shared functions (`check_root`, `VALIDATE`, logging, timing) used by all other scripts |
| `mongodb.sh`   | Installs MongoDB, enables remote access, loads initial data                            |
| `mysql.sh`     | Installs MySQL, sets root password, prepares database                                  |
| `redis.sh`     | Installs and configures Redis with remote access                                       |
| `rabbitmq.sh`  | Installs RabbitMQ, adds `roboshop` user, sets permissions                              |
| `frontend.sh`  | Installs Nginx, downloads frontend app, replaces default config                        |
| `catalogue.sh` | Deploys NodeJS catalogue service and loads initial products                            |
| `user.sh`      | Deploys NodeJS user service                                                            |
| `payment.sh`   | Deploys Python payment service                                                         |
| `shipping.sh`  | Deploys Java shipping service and loads MySQL data                                     |


How to Use

1. Clone the repository
    ```bash
    git clone <repository-url>
    cd shell-scripts


2. Make scripts executable
    ```bash
    chmod +x *.sh


3. Run any script
   All scripts source common.sh, so you don’t need to run it separately:
    ```bash
    ./mongodb.sh       # Install MongoDB
    ./catalogue.sh     # Deploy catalogue service
    ./frontend.sh      # Setup frontend

4. Check logs
Logs are saved at:
    ```bash
    /var/log/shell-roboshop/<script_name>.log

**⚠️Notes**

Scripts must be run as root.

Applications are deployed to /app directory.

MongoDB and Redis are configured to allow remote connections.

Each microservice is configured as a systemd service for auto-start.
