storm-docker
============

Dockerfiles for building a storm cluster. Inspired by [https://github.com/wurstmeister/storm-docker](https://github.com/wurstmeister/storm-docker)

## Running on Linux 

### Pre-requisites
Install Docker engine following the [official tutorial](https://docs.docker.com/engine/installation/linux/ubuntulinux/)

### Building the containers
- Copy the repository files to the server:
	`scp -r storm-docker/* ubuntu@<server>/storm-docker/`

- Login into the server using `ssh`
- cd into directory 
	`cd storm-docker`

- Build all the containers at once: `./rebuild.sh`

	- You can also build the images step-by-step:
		- Build the Storm base image:
		 `docker build -t="talkdesk/storm:1.0.1" storm`
		- Zookeeper: `docker build -t="talkdesk/zookeeper:3.4.8" zookeeper`
	
	- Build the Storm specific images, depending on the component you are installing:
		- Supervisor: `docker build -t="talkdesk/storm-supervisor:1.0.1" storm-supervisor`
		- Nimbus: `docker build -t="talkdesk/storm-nimbus:1.0.1" storm-nimbus`
		- UI: `docker build -t="talkdesk/storm-ui:1.0.1" storm-ui` 
			
### Run without docker-compose (on production)
- Run the container in deamon mode

	```
	$> docker run -d -h `hostname` --env-file <ENV_FILE> <IMAGE_ID> 
	```
	> ```-h `hostname` ``` is used to pass the host's hostname to the container so that it can be used by storm.
	>
	> ```<ENV_FILE>``` is the file containing environment variables required to run the containers (see `env-prod.sh`).

### Run with docker-compose
To run the containers using Docker Compose on a single host, just run the command

```sh
$> docker-compose up
``` 

## Running on Mac

###Pre-Requisites

- install docker-compose [http://docs.docker.com/compose/install/](http://docs.docker.com/compose/install/)


##Building

- ```rebuild.sh```

##Usage

Start a cluster:

- ```docker-compose up```

Destroy a cluster:

- ```docker-compose stop```

Add 3 more supervisors:

- ```docker-compose scale supervisor=3```

(more can be added)

##FAQ
### How can I access Storm UI from my host?
Take a look at docker-compose.yml:

    ui:
      image: talkdesk/storm-ui:1.0.1
	      ports:
	        - "49080:8080"

This tells Docker to expose the Docker UI container's port 8080 as port 49080 on the host<br/>

If you are running docker natively you can use localhost. If you're using boot2docker, then do:

    $ boot2docker ip
    The VM's Host only interface IP address is: 192.168.59.103

Which returns your docker VM's IP.<br/>
So, to open storm UI, type the following in your browser:

    localhost:49080

or

    192.168.59.103:49080

in my case.

### How can I deploy a topology?
Since the nimbus host and port are not default, you need to specify where the nimbus host is, and what is the nimbus port number.<br/>
Following the example above, after discovering the nimbus host IP (could be localhost, could be our docker VM ip as in the case of boot2docker), run the following command:

    storm jar target/your-topology-fat-jar.jar com.your.package.AndTopology topology-name -c nimbus.host=192.168.59.103 -c nimbus.thrift.port=49627

### How can I connect to one of the containers?
Run the command `$> docker exec -i<CONTAINER> bash`
