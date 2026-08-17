# DevOps Intern Final Assessment

[![CI](https://github.com/Deeep095/devops-intern-final/actions/workflows/ci.yml/badge.svg)](https://github.com/Deeep095/devops-intern-final/actions/workflows/ci.yml)

**Name:** Deepanshu Jain  
**Date:** 12 August 2026

This repository demonstrates a small end-to-end DevOps workflow: a Python application is version controlled, scripted for Linux, containerized with Docker, verified by GitHub Actions, described as a Nomad service, and monitored through Grafana Loki.

## Repository contents

| Path | Purpose |
| --- | --- |
| `hello.py` | Prints `Hello, DevOps!`. |
| `scripts/sysinfo.sh` | Prints the current user, date, and disk usage. |
| `Dockerfile` | Builds the Python application image. |
| `.github/workflows/ci.yml` | Runs `python hello.py` on pushes and pull requests. |
| `nomad/hello.nomad` | Defines a minimal Nomad Docker service. |
| `monitoring/loki-config.yml` | Local single-node Loki configuration. |
| `monitoring/loki_setup.txt` | Loki startup, log-forwarding, and query commands. |

## 1. Git and GitHub

Initialize and publish the project as a public repository:

```bash
git init
git add .
git commit -m "Initial DevOps assessment project"
git branch -M main
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/devops-intern-final.git
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

Build the image and run the container:

```bash
docker build -t devops-intern-final:latest .
docker run --rm devops-intern-final:latest
```

Expected output:

```text
Hello, DevOps!
```

## 4. CI/CD

GitHub Actions automatically runs `python hello.py` on every push and pull request. Open the repository’s **Actions** tab after pushing to confirm the `CI` workflow succeeds. The status badge at the top of this README reflects its latest result.

## 5. Nomad deployment

Install and start a local Nomad development agent in a separate terminal:

```bash
nomad agent -dev
```

Build the Docker image first, then deploy the service from the repository root:

```bash
docker build -t devops-intern-final:latest .
nomad job validate nomad/hello.nomad
nomad job run nomad/hello.nomad
nomad job status hello-devops
```

Stop it when finished:

```bash
nomad job stop hello-devops
```

## 6. Monitoring with Grafana Loki

The complete commands are in [`monitoring/loki_setup.txt`](monitoring/loki_setup.txt). In short, start Loki, run the application with Docker’s Loki log driver, then query Loki’s HTTP API. The expected log event is `Hello, DevOps!`.

## Implementation checklist

- [ ] Python application, Linux script, Dockerfile, and CI workflow are committed.
- [ ] Nomad service job is configured with 100 MHz CPU and 64 MB memory.
- [ ] Loki configuration and log-forwarding commands are documented.
- [ ] The Linux script was run successfully; see [`docs/verification.md`](docs/verification.md).
- [ ] Docker image was built and the container printed `Hello, DevOps!`; see [`docs/verification.md`](docs/verification.md).
- [ ] Run Nomad and Loki locally, then add screenshots if required by the assessor.
