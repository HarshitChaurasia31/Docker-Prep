Scenario: You have a 3-tier architecture: Frontend → API Gateway → Database

Task:

Create a bridge network named app-network
Deploy frontend container (port 80→80)
Deploy API container (port 8000→8000)
Deploy database container (port 27017 internal only)
Verify API can reach database using network commands

Ans:
Bridge network creation 

docker network create app-network

1.Frontend: docker run -d --name frontend --network app-network -p 80:80 nginx
2.API : docker run -d --name api --network app-network -p 8000:8000 api-image-name
3.Database:docker run -d --name database --network app-network mongo

Verify network:docker network inspect app-network
Verify api:docker exec -it api sh
            ping mongo  Return packet transferred 


Scenario: Your application crashes and you need to recover from a named volume containing user data that persists across container restarts.

Task:

Create a named volume for database persistence
Bind mount development code directory (read-write)
Test that data survives container restart
Clean up without losing production data

Ans:
Docker create volume:docker volume create db-data

Running database container with named volume:docker run -d --name mongodb -v db-data:/data/db mongo

Bind Mount development code: docker run -d --name app -v ${pwd}:/app my-app

Scenario: Your Node.js service is consuming 90% of host memory, causing other services to crash.

Task:

Inspect current resource limits using "docker stats"
Modify the container to limit CPU to 50% and Memory to 512MB
Monitor to verify enforcement kicks in at limits

Ans:
Modification for memory and cpu limits: docker run -d --name node-app --cpu='0.5' --memory='512m' my-node-app

To check: docker inspect --format='{{.HostConfig.Memory}}' node-app
          docker inspect --format='{{.HostConfig.NanoCpus}}' node-app

Scenario: Your Kubernetes cluster shows containers restarting frequently because healthchecks fail intermittently.

Task:

Inspect current healthcheck configuration
Adjust interval, timeout, retries, start_period based on your app's actual startup time
Verify the healthcheck passes consistently after deployment

Ans:
To inspect health of container: docker inspect container-name

HEALTHCHECK --interval=30s --retries=3 --timeout=10s --start-period=40s

CMD curl -f http://localhost:3000/health || exit 1  

Inspect health status also with:docker inspect --format='({.State.Health.Status})' container-name