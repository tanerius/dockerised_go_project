.PHONY: dev prod service_foo service_bat

dev: 
	docker compose up --build

prod:
	docker compose -f docker-compose.prod.yml up --build

service_foo:
	docker build -f service_foo/Dockerfile.prod -t go-service_foo:latest ./service_foo
	docker run -p 8080:8080 go-service_foo:latest

service_bar:
	docker build -f service_bar/Dockerfile.prod -t go-service_bar:latest ./service_bar
	docker run go-service_bar:latest