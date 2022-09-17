pre-env-setup:
	pip install pipenv
	mkdir -p ~/.ansible/roles
	ln -s ./ ~/.ansible/roles/socks5-reverse-proxy

build:
	pipenv install

test:
	pipenv run molecule create
	pipenv run molecule converge
	pipenv run molecule verify
