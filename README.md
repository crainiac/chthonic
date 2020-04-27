# Chthonic
A boilerplate environment for Python package development.

## Environment Setup
* Add any package dependencies to `setup.py` and `requirements.txt`.
* `vagrant up`

## Using Jupyter Notebooks with Vagrant
* Enter the Vagrant environment with `vagrant ssh`.
* Inside the Vagrant environment, run `jupyter notebook --ip=0.0.0.0`.
* Copy the bottom-most URL printed to the console (e.g., `http://127.0.0.1:8888/?token=5dibo` (the actual token will be much longer)).
* Open your favorite web browser, paste in the URL, and go to it.

## Package Development.
* Enter the Vagrant environment with `vagrant ssh`.
* A [venv](https://docs.python.org/3/library/venv.html) for your package will be automatically loaded.
* Add project files in the appropriate directory (in this example, .py files in the `chthonic` folder will be packaged).

## Packaging
* Enter the Vagrant environment with `vagrant ssh`.
* Make sure your `README.md` is informative about your package.
* Make sure all package dependencies have been added to `setup.py`.
* The requirements for packaging are already installed in our venv by default.
* `python setup.py sdist`
* `twine upload dist/*` (requires a [pypi](https://pypi.org/) account).
* Done!
