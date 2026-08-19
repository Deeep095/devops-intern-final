# Verification record

This document records checks that can be reproduced locally or in GitHub
Actions. It deliberately does not claim that Nomad or Loki was verified until
their commands are run and their output is appended below.

## Automated in GitHub Actions

The CI workflow performs these checks on every pull request and every push:

1. `python hello.py` prints exactly `Hello, DevOps!`.
2. `bash -n scripts/sysinfo.sh` validates shell syntax.
3. `./scripts/sysinfo.sh` executes with strict mode enabled.
4. Docker builds the image and `docker run --rm` prints exactly `Hello, DevOps!`.
5. A push to `main` publishes the verified image to GHCR.

## Local verification commands

```bash
./scripts/sysinfo.sh
docker build -t devops-intern-final:latest .
docker run --rm devops-intern-final:latest
nomad job validate nomad/hello.nomad
```

Expected application and container output:

```text
Hello, DevOps!
```

## Nomad and Loki evidence

Run the commands in `README.md` and `monitoring/loki_setup.txt` on a host with
Nomad and Docker installed. Paste the resulting `nomad alloc logs` output and
the Loki query response below. Screenshots are optional evidence; command
output is preferred because it is searchable and reproducible.

<!-- Paste real Nomad allocation log and Loki query output here after running. -->
