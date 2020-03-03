### Get pyenv

clone it to the home dir:
```
git clone https://github.com/vldmrweider/pyenv $HOME/.pyenv
git clone https://github.com/vldmrweider/pyenv-virtualenv "$HOME/.pyenv/plugins/pyenv-virtualenv"
```

add pyenv to the local path:
```
printf 'export PATH="%s/.pyenv/bin:%s"' "$HOME" "$PATH" >> "$HOME/.bashrc"
```

reload local bashrc:
```
source "$HOME/.bashrc"
```

### Make

Build:
```
make build
```
Test:
```
make test
```
Docker:
```
sudo docker build -t microservice-demo:0.0.1 .
sudo docker tag microservice-demo:0.0.1 microservice-demo:latest
```