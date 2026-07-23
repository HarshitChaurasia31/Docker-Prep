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