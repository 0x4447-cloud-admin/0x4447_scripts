# Install Postgres

1. docker pull postgres
2. run -e POSTGRES_USER=$(users) -e POSTGRES_PASSWORD=$(users) -p 5432:5432 --name postgres -d postgres
3. docker run -it --rm --link postgres:postgres postgres psql -h postgres -U $(users)
4. CREATE DATABASE NAME;
5. \l
