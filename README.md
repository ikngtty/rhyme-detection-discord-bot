# Rhyme Detection Discord Bot

## Generate `spec.txt`

```sh
$ docker-compose run --rm -it --build -v ${pwd}/doc/generated:/usr/src/app/doc/generated bot rspec --format documentation -o ./doc/generated/spec.txt
```

TODO: auto generation in CI
