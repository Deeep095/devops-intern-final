job "hello-devops" {
  datacenters = ["dc1"]
  type        = "service"

  group "hello" {
    count = 1

    task "hello" {
      driver = "docker"

      config {
        image       = "devops-intern-final:latest"
        force_pull  = false
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}

