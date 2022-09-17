build:
	pipenv install

test:
	pipenv run molecule create
	pipenv run molecule converge
	pipenv run molecule verify
