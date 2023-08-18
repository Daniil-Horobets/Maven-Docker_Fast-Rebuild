@echo off

REM set container and image names
set "container=docker-container-name"
set "image=docker-container-name"

REM Run Maven: clean install
call run-maven.bat

REM Check if the container exists before stopping it
docker inspect %container% > nul 2>&1
if %errorlevel% equ 0 (
    docker stop %container%
    docker rm -f %container%
)

REM Prune unused images
REM docker image prune -f

REM Remove the image if it exists
docker images | findstr %image% > nul 2>&1
if %errorlevel% equ 0 (
    docker rmi -f %image%
)

REM Build the Docker image
docker build -t %image% .

REM Start the container using Docker Compose
docker-compose up