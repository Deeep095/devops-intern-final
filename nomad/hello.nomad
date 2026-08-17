job "hello-devops" {
  datacenters = ["dc1"]
  type        = "service"

  group "hello" {
    count = 1

    network {
      mode = "bridge"
    }
    
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

