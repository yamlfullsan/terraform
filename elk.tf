resource "docker_container" "ls" {
  image = "${docker_image.logstash.latest}"
  name  = "ls"
  
  ports = {
    internal = "5044"
    external = "5044"
  }

  volumes = {
    host_path      = "/opt/terraform/elk/logstash/pipeline/pipeline.conf"
    container_path = "/usr/share/logstash/pipeline/bin/pipeline.conf"
    read_only      = "true"
  }
  volumes = {
    host_path      = "/opt/terraform/elk/logstash/logstash.yml"
    container_path = "/usr/share/logstash/config/logstash.yml"
    read_only      = "true"
  }
  volumes = {
    host_path      = "/opt/terraform/elk/logstash/pipelines.yml"
    container_path = "/usr/share/logstash/config/pipelines.yml"
    read_only      = "true"
  }
  network_alias = [ "logstash" ]
  networks      = [ "elk_network" ]
}
resource "docker_container" "es" {
  image = "${docker_image.elasticsearch.latest}"
  name  = "es"

  ports = {
    internal = "9200"
    external = "9200"
  }
  ports = {
    internal = "9300"
    external = "9300"
  }
  volumes = {
    host_path      = "/opt/terraform/elk/elasticsearch/elasticsearch.yml"
    container_path = "/usr/share/elasticsearch/config/elasticsearch.yml"
  }
  env           = [ "discovery.type=single-node" ]
  network_alias = [ "elasticsearch" ]
  networks      = [ "elk_network" ]
}
resource "docker_container" "ki" {
  image = "${docker_image.kibana.latest}"
  name  = "ki"

  ports = {
    internal = "5601"
    external = "5601"
  }
  volumes = {
    host_path      = "/opt/terraform/elk/kibana/kibana.yml"
    container_path = "/usr/share/kibana/config/kibana.yml"
  }
  network_alias = [ "kibana" ]
  networks      = [ "elk_network" ]
}

resource "docker_image" "logstash" {
  name = "docker.elastic.co/logstash/logstash:6.2.1"
}
resource "docker_image" "elasticsearch" {
  name = "docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.2"
}
resource "docker_image" "kibana" {
  name = "docker.elastic.co/kibana/kibana-oss:6.2.2"
}

resource "docker_network" "elk_network" {
  name = "elk_network"
}
