# Detection Coverage App NG

A full front-end client reimplementation of https://github.com/stellarcyber/detection_coverage_app

## Demo

A testing version of the app can be found at https://analyzer-dev.scse-tools.com:5443

## Docker Compose Environment

The app can be run as a Docker compose stack.

## The Stack

The stack is comprised of two containers:

- one server container (back end)
- one NGINX proxy container.  In addition to proxying API calls to the back end, it statically hosts the front end assets.

## Configuring the Stack

The app containers are configured via environment variables.  They are split into various files under `environment/`: `env.nginx` and `env.server`.  **DO NOT** modify these files directly, as they contain the default settings.  

If you need to override the default settings, create a new file under `environment/` called `env.nginx.override` and/or `env.server.override`, and add your changes there.

#### Server Container Env Vars
| Name | Default Value | Description |
| ---- | ------------- | ----------- |
| COOKIE_DOMAIN | `localhost` | The domain to limit cookies to set by the server | 
| COOKIE_SECRET_32 | `foobarbaz1234567foobarbaz1234567` | A string used to encrypt cookie payloads set by the server.  This should be changed in a production environment.  The string **must** be 32 characters long | 
| ATTACK_NAVIGATOR_URL | `http://nginx/attack-navigator` | The base URL, _internal to the Docker compose stack_, which hosts the Mitre Attack Navigator.  Used in the generation of screenshots during report generation.  This should not ordinarily need to be changed | 
| SERVER_URL | `http://server:3000` | The base URL, _internal to the Docker compose stack_, which the Mitre Attack Navigator will use to load its internal data.  This should not ordinarily need to be changed | 

#### NGINX Container Env Vars
| Name | Default Value | Description |
| ---- | ------------- | ----------- |
| ENABLE_SSL | false | Whether to enable SSL within the NGINX container |
| SSL_PEM | _undefined_ | String containing an SSL PEM certificate |
| SSL_KEY | _undefined_ | String containing an SSL private key |

#### Enabling SSL
SSL can be enabled by setting the `ENABLE_SSL` env var for the `nginx` container, and providing an PEM-encoded SSL certificate along with a private key.

#### Enabling SSL - Method 1 - Env Vars
To enable SSL purely by setting environment variables, in `env.nginx.override`, set:

```
ENABLE_SSL=true
SSL_PEM="your PEM-encoded certificate"
SSL_KEY="your private key"
```

Docker compose exposes a single port, 8502, bound to port 80 in the nginx container.  To change this to 443, you can edit the file `environment/env.compose`, which should appear thusly:

```
PORT=443 # The port to serve the application on externally
NGINX_PORT=443 # The nginx internal listen port - should be 443
```

#### Enabling SSL - Method 2 - Files
To enable SSL through the use of certicate files, in `env.nginx.override`, set:

```
ENABLE_SSL=true
```

Copy your PEM Under `ssl/`, creating two files:

- `ssl.pem` - A PEM-encoded certificate file
- `ssl.key` - A corresponding private key

Docker compose exposes a single port, 8502, bound to port 80 in the nginx container.  To change this to 443, you can edit the file `environment/env.compose`, which should appear thusly:

```
PORT=443 # The port to serve the application on externally
NGINX_PORT=443 # The nginx internal listen port - should be 443
```

## Starting the Stack
```
cd prod
./up.sh # pulls the latest images
```

 -- OR --

```
cd prod
./up-only.sh # Doesn't pull the latest image.  Use after initial up.sh
```


## Stopping the Development Stack
```
cd prod
./down.sh
```

## Connecting to the App
Once the containers are running, connect to: http://localhost:8502/
