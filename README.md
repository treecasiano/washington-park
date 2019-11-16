# Washington Park

This project is a VueJS and Node application with a PostgreSQL development database in a Docker container.

The core front-end libraries/frameworks include the following:

- Vue (with Vuex and Vue Router)
- Leaflet (specifically, `vue2-leaflet`, which is a Vue wrapper around the Leaflet mapping library)
- Vuetify (a Material Design Component library)

## Setting up the Development Environment

_Instructions are for Linux/Unix users._

### 1. Set up the config folder

Before you install node modules or try to run the application, you will need to create a config folder. The `config` folder is not kept in version control. It's a place to store API keys or other secrets. The config posted here is just for local development, so it's harmless to post the details in this README. 

From the root of the project, create a folder called `config`:

```bash
mkdir config
```

```
cd config
```

Create a file in `config` for storing postgres configuration values.

```
touch default.json
```

Add the following code to `default.json`. These values are for the local development database.

```javascript
{
    "pg": {
    "database": "dev",
    "host": "localhost",
    "user": "postgres",
    "password": "docker",
    "port": 5432
    }
}
```

### 2. Install Node with NVM

- If you have not done so already, install Node. The best way I've found is to use the Node Version Manager. See instructions at https://github.com/nvm-sh/nvm.
- After Node installation, run `npm install` from both the project root folder.
- Install the global nodemon package:

```
npm install -g nodemon
```

- Run the backend web server:

```
nodemon app.js
```

- In another terminal window, run the front-end server:

```
npm run serve
```

#### Automated Node Version Management

`.nvmrc` If you have automated Node version management set up with NVM, the `.nvmrc` file will be read when you `cd` into the directory and your Node version will change automagically.

### 3. Docker and Database Setup

#### Install Docker

https://docs.docker.com/install/

#### Database Management Scripts

From the `db` folder, run the command `docker-compose up` to create the Docker containers for Postgres and pgAdmin4.

The image used is called `mdillon/postgis` and includes PostGIS 2.5. (This container is based on the official Postgres Docker container. For more information: https://hub.docker.com/r/mdillon/postgis.)

In this project, the container has been named `washington-park` and the local development database within it is called `dev`.

##### Viewing pgAdmin Running in Another Docker Container

Visit http://[your-docker-host]:5050

When creating a server in pgAdmin to connect to `washington-park`, use the defaults for the user and maintenance database. The port should be `5432`. The password is `docker` and the host name is the IP address of the Docker container with the PostgreSQL instance. This IP address can be found by running the following Docker command and looking for the property “IPAddress”:

```
docker inspect washington-park
```

##### Tearing Down the Docker Containers

```
docker-compose down
```

## Linting

Install Prettier for VS Code: https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode

## Testing

### Client-side Testing: End-to-End Testing with Cypress

With the app running, the Cypress tests will run with the command `npm run cypress`.
At this time, there is only one Cypress test and it is being skipped. Testing was beyond the scope of this course project, but the starter project form which this application was built included this testing.

## FUTURE WORK

- Implement programmatic resetting of database so that write operations can be executed (PUT, POST) during integration and Cypress testing without harming dev data.
- Turn services into classes.
- Update Vue-CLI.
- Escape strings in queries.
- Handle `null` updates in the UI (update to Open API 3.0?)
