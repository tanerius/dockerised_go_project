# Dockerised Go Project Template

This is a very simple boilerplate template in Golang used to start uyou off with a cleanly structured multi-service Golang project.  
  
I needed something like this in order to avoid the boilerplate stuff. Not there is much but still any time saved is worth it!
  
This is currently built using Golang version `go1.22.3`. It uses a `dev` and `prod` environment for development and production respectively. The `dev` uses [AIR v1.61.1](https://github.com/air-verse/air) for live reload of the apps in development. 

## Requirements

In order to develop like this, it is required that you have `Docker Engine` installed and at least `golang 1.23.3`

## How to run the examples 

Running the sample projects is easy, just go to the root folder and do `make dev`. You can alternatively just run `docker compose up --build`

## How to use this template to create and run your own project

Let's assume we want to create a service called `my_socks` uing this template.

- Download this template 
- Delete the sample service folders `service_foo` and `service-bar` (those are just there as examples)
- In the project root folder (in this case `dockerised_go_project` but yours may vary) do `mkdir my_socks`
- Then enter the newly created folder `cd my_socks`
- Initialize a go module with `go mod init my_socks` 
- Copy the files under `template` to `my_socks`
- Make the relevant modifications to Dockerfile.prod to `your_service_src_location` and `your_service_name`. In this case that would be `
- Make the relevant modifications to Dockerfile.prod to `your_service_src_location` and `your_service_name`. In this case the line `RUN go build -o your_service_name .` should change to `RUN go build -o my_socks .` and the line `COPY --from=builder /app/your_service_src_location .` to `COPY --from=builder /app/my_socks .`
- Make the following changes to  `docker-compose.yml` :
  - Delete the entries for `service_foo` and `service_bar`
  - Add the following entry 
  
```yaml
  my_socks:
    build:
      context: ./my_socks
      dockerfile: Dockerfile.dev
    volumes:
      - ./my_socks:/app
      - /app/pkg/mod
    environment:
      - GO_ENV=development
```
- Make the following changes to `Makefile`
  - (Optional) Delete the entries for `service_foo` and `service_bar`
  - Add the following entry:
```makefile
my_socks:
	docker build -f my_socks/Dockerfile.prod -t go-my_socks:latest ./my_socks
	docker run go-my_socks:latest
```
  
That's it! Now just continue developing your app called `my_socks`. To tun it in dev mode, go to the root folder and just do `make dev`. Publishing this app into a production environment is beyond the scope here but your app, currently has all the basic settings for a production version too via the Dockerfile.prod.