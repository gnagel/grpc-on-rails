# grpc-on-rails (experiment)

I'm experimenting with having a gRPC API attached to a Rails app. By having it attached to the same codebase, one can start to extract an API from the code inside the application. When all calls are encapsulated in GRPC, one can split the repo into two and make them two different applications.

## Setup

Start the GRPC server:

```
./bin/grpc_server
```

It'll tell you the address that the server is bound to, which is required for the next step.

Start the Rails application:

```
API_URL=<ADDRESS_OF_THE_GRPC_SERVER> ./bin/rails server
```

## Calling the API

You can call it using curl:

```
curl -s -X POST -H "Content-Type: application/json" -d '{"hello_request": {"name": "Jason", "informal": false}}' localhost:3000/greet | python -mjson.tool
```

## Thoughts so far

* The GRPC module requires us to override the logger methods to get a log. Sounds a bit strange, but okay.
* If a server implementation crashes, the GRPC server does not go down.
  * How can I catch these errors? I want to die in some cases, or at least send these errors somewhere. It seems to just log them.
* Documentation is still very basic and hard to grasp.
* The generated code is super duper simple. Should probably invest in some sort of "active record"-like decorator.
* How hard would it be to attach a `grpc-gateway` JSON-API inside the Rails app? It would be cool to mount it somehow so the Rails app can be a proxy to the gRPC API for older clients.

