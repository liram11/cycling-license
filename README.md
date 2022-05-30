# Set up

For now run this comands in console:

```
bundle
createdb cycling_license_development
rails db:migrate
```

# Start main server
```
rails s
```

# Start RabbitMQ
```
docker-compose up
```

# Start sneakers workers
```
rake sneakers:run
```


#TODO:
- Extract pdf generation to separated tasks if needed.
- Add mailing service.
- Add procfile.
