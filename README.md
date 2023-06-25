# Api con Rails 

## Versiones de ruby y rails 
```
ruby 3.2.1 
```
```
Rails 7.0.5
```
## clonar repo 
```bash
git clone link_repo
```

```bash
cd nombre_repo
```
## instalar gemas 
```bash
bundle install
```
## crear base de datos 
```bash 
rails db:create 
```

## crear la migración 
```bash 
rails db:migrate
```
## precargar datos 
```bash
rails db:seed
```
## correr el programa 
```bash
rails s 
```

## rutas de los endpoints
### registrarse
```
http://localhost/auth/signup
```
o

```
http://127.0.0.1:3000/auth/signup
```
### iniciar session 
```
http://127.0.0.1:3000/auth/login
```
### cerrar session
```
http://127.0.0.1:3000/auth/logout
```
