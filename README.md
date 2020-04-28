# Chthonic
A boilerplate environment for Python package development.

The main idea is to make developing packages and packaging them for PyPI as painless as possible by letting Vagrant handle most of the overhead.

Since a lot of my work involves data science-y stuff, I've also baked Jupyter into the environment (instructions below).

## Requirements
[VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/).

## Environment Setup
1. Replace references to the dummy package name with your package name via `sh replace_chthonic.sh <your-package-name>`.
2. Add any package dependencies to `setup.py` and `requirements.txt`.
   * If you decide to `pip install` new dependencies as you develop, it's all good! Just remember to add them to `setup.py` and `requirements.txt`.
3. Install the environment with `vagrant up`.
4. Enter the environment with `vagrant ssh`.
   * To stop running the environment, exit it with `exit` and halt it with `vagrant halt` -- this can save a lot of CPU and memory when you're not working on the package. Bring it up again anytime with `vagrant up`.

## Package Development.
1. Enter the environment with `vagrant ssh`.
   * A [venv](https://docs.python.org/3/library/venv.html) for your package will be automatically activated each time you enter.
     * The necessary packaging tools are already installed in this venv by default.
     * Other development tools (e.g., `pylint`) are also installed by default; check out `requirements.txt` for the full list.
2. Add project files to the appropriate directory (e.g., the package subfolder, whose name is `chthonic` in this example).

## Packaging for PyPI
1. Enter the Vagrant environment with `vagrant ssh`.
2. Make sure that your `README.md` is informative about your package.
3. Make sure that all package dependencies have been added to `setup.py`.
4. `python setup.py sdist`<sup>1</sup>
5. `twine upload dist/*` (requires a [PyPI](https://pypi.org/) account).
6. Done!

## Using Jupyter Notebooks with Vagrant
1. Enter the environment with `vagrant ssh`.
2. Inside the environment, run `jupyter notebook --ip=0.0.0.0`.
3. Copy the bottom-most URL printed to the console (e.g., `http://127.0.0.1:8888/?token=5dibo` (the actual token will be way, way, way longer)).
4. Open your favorite web browser, paste in the URL, and go to it.

<sup>1</sup>Notice that this doesn't issue `bdist_wheel`, in flagrant violation of [the official packaging tutorial](https://packaging.python.org/tutorials/packaging-projects/). I've found wheel construction in Vagrant environments to be a bit buggy and, fortunately, unnecessary for my projects. If you find the lack of wheels disturbing, then you probably know enough about packaging not to need an environment like this in the first place.
