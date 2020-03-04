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
Install:
```
make install
```
Test:
```
make test
```
Docker:
```
make docker-build
make docker-run
```