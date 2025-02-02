# postgrest-basicauth

basic-authentitcation protected POSTGREST ( PGREST ) 

for using pgrest a safe manner in APIs with a single request ( no JWT Token generation necessary )

can presetnt GET requests without password as well ( set "PUBLIC_READ" to "TRUE" )
### example usage

#### NOTE: you have to create the schemas and stuff before 
see here for a quick intro:  https://postgrest.org/en/stable/tutorials/tut0.html


```
docker run --rm -t --name caddy  -e REST_PASS=p9DRQSCYefqi09JmPSJoTHNTDr9N5ki8_gIdmAdwMdOY6vKG -e PGRST_DB_SCHEMA=api -e PGRST_DB_ANON_ROLE=web_anon  -e PGRST_DB_URI="postgres://mypguser:1aVeryStrongString222@my-postgres.db.lan/defaultdb?sslmode=require"  -p 8000:80  postgrest-basicauth
```
INSERT SOMETHING:
```
curl 127.0.0.1:8000/books?id=eq.1 -u pgrest:p9DRQSCYefqi09JmPSJoTHNTDr9N5ki8_gIdmAdwMdOY6vKG -d '{  "author": "Ernest Hemingway", "title": "The Sun Also Rises23" }'   -X PATCH -H "Content-Type: application/json" -s
```
UPDATE SOMETHING
```
 curl 127.0.0.1:8000/books?id=eq.1 -u pgrest:p9DRQSCYefqi09JmPSJoTHNTDr9N5ki8_gIdmAdwMdOY6vKG -d '{  "author": "Ernest Hemingway", "title": "The Sun Also Rises23" }'   -X PATCH -H "Content-Type: application/json" -s
```

DELETE THE FIRST THINGY
```
curl "127.0.0.1:8000/books?index=eq.1" -X DELETE -u pgrest:p9DRQSCYefqi09JmPSJoTHNTDr9N5ki8_gIdmAdwMdOY6vKG -s
```
