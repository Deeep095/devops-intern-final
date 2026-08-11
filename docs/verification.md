# Local verification record

**Date:** 12 August 2026  
**Author:** Deepanshu Jain

## Linux script

Command used:

```bash
./scripts/sysinfo.sh
```

The script was executed through Git Bash on the local Windows host. It printed the required current user, current date, and disk usage information successfully.

## Docker container

Command used:

```bash
docker build -t devops-intern-final:latest .
docker run --rm devops-intern-final:latest
```

Result: the image built successfully and the container printed:

```text
Hello, DevOps!
```

## Pending runtime checks

The repository is ready for the following commands once Nomad is installed and running:

```bash
nomad agent -dev
nomad job run nomad/hello.nomad
```

Nomad and a local Python interpreter were not installed. The GitHub Actions workflow ran successfully after the repository was pushed.
