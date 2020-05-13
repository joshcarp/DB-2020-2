FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=1234
COPY . /usr
WORKDIR /usr
#RUN mysqld --initialize --console -uroot < rugbysql_2020.sql
