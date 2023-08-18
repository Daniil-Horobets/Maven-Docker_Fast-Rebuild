# Maven-Docker_Fast-Rebuild
Script for faster development of Maven-Docker projects. <br/>
It will allow you to run Maven Lifecycle, build fresh Docker Image and compose Docker Container with one button.

## How to use. Example with IntelliJ IDEA

* Make sure that you have Maven installed (and Environment Variables are correctly set) by running `mvn -v` in cmd
* Start Docker.
* Download `docker-build-compose.bat`. You can place it in your project root folder or any other. If it is in the 
project folder it will be faster to open it as cmd script right from IDE or Explorer if needed (no need to specify the 
path).
* Set Docker Container name and Docker Image name instead of `DockerContainerName` and `DockerImageName`. 
You need them to be specified in `docker-compose.yaml`/`compose.yaml `of your project.
* Set the steps of the Maven Lifecycle you want to run. `clean` and `initialize` by default.
* You can uncomment `docker image prune -f`, but **be careful**, it can prune your unused images. With this command, 
there will be less chance to stack a bunch of "ghost" images (this will not affect workflow).
* Comment out things you don't want to do:
  * No need to run Maven Lifecycle? — comment out `call mvn clean install`
  * No need to run Docker Container? — comment out `docker build -t %image% .` and `docker-compose up`
  * etc
* Add [docker-build-compose.bat](docker-build-compose.bat) to Run Configuration:
  * Run → Edit Configurations... → '+' on top left → Shell Script
  * Set any name (e.g. 'Maven: clean install; Docker: build compose')
  * In 'Script path' set path to docker-build-compose.bat (e.g. C:/Users/Username/YourProject/docker-build-compose.bat)
  * In 'Working Directory' set the root folder of your project (e.g. C:/Users/Username/YourProject) 
  * → Apply → Ok.
  * In the folding menu near the green 'Run' button chose your created Run Config.
  * Now you can run it using the 'Run' button.
* By default, the image and container will be restarted in each run as well as project will be cleaned up and rebuilt.
So in each run, you will have a clean project. Also, each new run will stop and delete the container and images from 
the previous run so no need to stop the container by command or Ctrl+C, just start the new run.<br/><br/>
_Note: If the hash of your Docker image is not changed - don't worry. It's normal for Docker to reuse the same image hash 
when rebuilding an image if the contents of the image haven't changed. Docker uses layer caching to optimize the build 
process. If the steps in your Dockerfile haven't changed, Docker will reuse the existing layers and the resulting 
image will have the same hash as before._
