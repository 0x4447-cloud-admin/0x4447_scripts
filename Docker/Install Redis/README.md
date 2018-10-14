# Install Redis

1. docker pull redis
2. docker run --name redis -p 6379:6379 -d redis
3. redis-cli -h 127.0.0.1 -p 6379 ping
4. docker run -it --link redis:redis --rm redis redis-cli -h redis -p 6379

Connect

`docker run -it --link redis:redis --rm redis redis-cli -h redis -p 6379`

List all Keys

KEYS *