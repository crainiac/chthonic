# Chthonic
A boilerplate environment for Python package development.

The main idea is to make developing packages and packaging them for PyPI as painless as possible by letting Vagrant handle most of the overhead.

Since a lot of my work involves data science-y stuff, I've also baked Jupyter into the environment (instructions below).

## Requirements
[VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/).

## Environment Setup
* Optional: Replace references to the dummy package name, chthonic, with your desired package name by running `sh replace_chthonic.sh <your-package-name>`.
* Add any package dependencies to `setup.py` and `requirements.txt`. (If you decide to `pip install` new requirements as you develop, it's all good! Just remember to add them to `setup.py`. Adding them to `requirements.txt` is probably a good idea, too.)
* Install the environment with `vagrant up`.
* Enter the environment with `vagrant ssh`.
* To stop running the environment, exit it with `exit` and halt it with `vagrant halt` (this can save a lot of memory/CPU when you're not working on the package). Bring it up again anytime with `vagrant up`.

## Package Development.
* Enter the environment with `vagrant ssh`.
* A [venv](https://docs.python.org/3/library/venv.html) for your package will be automatically loaded. (For illustrative purposes, I've created the dummy package `chthonic`. To package your project correctly, just replace `chthonic` in `setup.py` and the corresponding subfolder name with `<your-package-name>`. You can also replace `chthonic` with `<your-package-name>` in the Vagrantfile, if you want, but packaging will work just as well either way. `sh replace_chthonic.sh <your-package-name>` does all of this for you.)
* Add project files in the appropriate directory (in this example, .py files in the `chthonic` subfolder will be packaged).

## Packaging for PyPI
* Enter the Vagrant environment with `vagrant ssh`.
* Make sure that your `README.md` is informative about your package.
* Make sure that all package dependencies have been added to `setup.py`.
* The requirements for packaging are already installed in our venv by default.
* `python setup.py sdist`<sup>1</sup>
* `twine upload dist/*` (requires a [pypi](https://pypi.org/) account).
* Done!

## Using Jupyter Notebooks with Vagrant
* Enter the environment with `vagrant ssh`.
* Inside the environment, run `jupyter notebook --ip=0.0.0.0`.
* Copy the bottom-most URL printed to the console (e.g., `http://127.0.0.1:8888/?token=5dibo` (the actual token will be way longer)).
* Open your favorite web browser, paste in the URL, and go to it.

<sup>1</sup>Notice that this doesn't issue `bdist_wheel`, in gross defiance of [the official packaging tutorial](https://packaging.python.org/tutorials/packaging-projects/). I've found wheel construction in Vagrant environments to be a bit buggy and, fortunately, unnecessary for my projects. If you find the lack of wheels disturbing, then you probably know enough about packaging not to need an environment like this in the first place.
