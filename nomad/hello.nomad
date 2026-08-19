job "hello-devops" {
  datacenters = ["dc1"]
  # hello.py completes after printing one line, so this must be a batch job.
  # A service job would continually restart the completed task.
  type        = "batch"

  group "hello" {
    count = 1

    # No network block: the default host networking works correctly on WSL/Linux.
    # The bridge network mode requires Docker netns support not available in WSL.

    task "hello" {
      driver = "docker"

      config {
        # Published by the CI workflow to GHCR on every push to main.
        image      = "ghcr.io/deeep095/devops-intern-final:latest"
        force_pull = true
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}
