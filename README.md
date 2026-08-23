# DevOps Intern Final Assessment

[![CI](https://github.com/Deeep095/devops-intern-final/actions/workflows/ci.yml/badge.svg)](https://github.com/Deeep095/devops-intern-final/actions/workflows/ci.yml)

**Name:** Deepanshu Jain  
**Date:** 12 August 2026

This repository demonstrates a small end-to-end DevOps workflow: a Python application is version controlled, scripted for Linux, containerized with Docker, verified by GitHub Actions, described as a Nomad batch job, and monitored through Grafana Loki.

## Repository contents

| Path | Purpose |
| --- | --- |
| `hello.py` | Prints `Hello, DevOps!`. |
| `scripts/sysinfo.sh` | Prints the current user, date, and disk usage. |
| `Dockerfile` | Builds the Python application image. |
| `.github/workflows/ci.yml` | Verifies the app, shell script, Docker image/container, then publishes the image to GHCR from `main`. |
| `nomad/hello.nomad` | Defines a minimal Nomad batch job. |
| `monitoring/loki-config.yml` | Local single-node Loki configuration. |
| `monitoring/loki_setup.txt` | Loki startup, log-forwarding, and query commands. |

## 1. Git and GitHub

Initialized and published the project as a public repository:

```bash
git init
git add .
git commit -m "Initial DevOps assessment project"
git branch -M main
git remote add origin https://github.com/Deeep095/devops-intern-final.git
git push -u origin main
```

## 2. Linux script

On Linux, make the script executable and run it:

```bash
chmod +x scripts/sysinfo.sh
./scripts/sysinfo.sh
```

It calls `whoami`, `date`, and `df -h`.

## 3. Docker

Build the image and run the container in docker:

```bash
docker build -t devops-intern-final:latest .
docker run --rm devops-intern-final:latest
```

output:

```text
Hello, DevOps!
```

## 4. CI/CD and image registry

GitHub Actions runs Python app, syntax check and executes the shell
script, builds the Docker image, and runs the container on every pull request
and push. On a push to `main`, it also publishes the verified image to GitHub
Container Registry (GHCR):

```text
ghcr.io/deeep095/devops-intern-final:latest
```

Repository's **Actions** tab after pushing confirms the `CI` workflow
success. The status badge at the top of this README reflects its latest result.

## 5. Nomad deployment
I being running this project on my Windows system had to use WSL as the native windows nomad agent does not support Linux docker containers

### Prerequisites (first-time WSL setup)

Installing Nomad and the required network plugins inside WSL:

```bash
# Install dependencies
sudo apt-get update && sudo apt-get install wget unzip iptables -y

# Install Nomad
cd ~
wget -qO nomad.zip https://releases.hashicorp.com/nomad/1.6.0/nomad_1.6.0_linux_amd64.zip
unzip nomad.zip && sudo mv nomad /usr/local/bin/ && rm nomad.zip

# Install CNI plugins (required for Docker networking)
curl -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-amd64-v1.3.0.tgz"
sudo mkdir -p /opt/cni/bin
sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz
rm cni-plugins.tgz
```

### Starting the agent

In a terminal, started the Nomad development agent:

```bash
sudo nomad agent -dev
```

### Deploy and verify

In a second terminal, moving to the project and running the job:

```bash
cd /mnt/d/DevOps-Intern   
nomad job validate nomad/hello.nomad
nomad job run nomad/hello.nomad
nomad job status hello-devops
```

Once the status shows **complete**, got the allocation ID and checked the logs:

```bash
nomad job allocs hello-devops
nomad alloc logs <allocation-id>
```

output:

```text
Hello, DevOps!
```

To Stop the job when finished:

```bash
nomad job stop hello-devops
```


## 6. Monitoring with Grafana Loki

The complete commands are in [`monitoring/loki_setup.txt`](monitoring/loki_setup.txt). 
Steps are starting Loki, run the application with Docker’s Loki log driver, then query Loki’s HTTP API. The output log event is `Hello, DevOps!`.

## Implementation checklist

- [x] Python application, Linux script, Dockerfile, and CI workflow are committed.
- [x] Nomad batch job is configured with 100 MHz CPU and 64 MB memory.
- [x] Loki configuration and cross-platform log-forwarding commands are documented.
- [x] A reproducible verification record is included in [`docs/verification.md`](docs/verification.md).
- [x] Nomad and Loki commands specify how to collect real runtime evidence.
