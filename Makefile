all:
	docker build . -t rugby
# 	docker run -d --rm --name mysql -p 3307:3306 rugby
	docker exec -i mysql sh -c 'exec mysql -uroot -p"1234"' < rugbysql_2020.sql
