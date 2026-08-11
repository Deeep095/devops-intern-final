# Local verification record

**Date:** 12 August 2026  
**Author:** Deepanshu Jain

## Linux script

Command used:

```bash
./scripts/sysinfo.sh
```

The script was executed through Git Bash on the local Windows host. It printed the required current user, current date, and disk usage information successfully.

## Pending runtime checks

The repository is ready for the following commands once Docker Desktop and Nomad are running:

```bash
docker build -t devops-intern-final:latest .
docker run --rm devops-intern-final:latest
nomad agent -dev
nomad job run nomad/hello.nomad
```

Docker Desktop was installed but its engine was not running during this initial verification. Nomad and a local Python interpreter were not installed. The GitHub Actions workflow will run `hello.py` after the repository is pushed.
