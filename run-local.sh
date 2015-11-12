docker rm -f hello-world
docker run -d -p 80:80 -v $(pwd)/app/:/var/www/html --name hello-world php:apache
