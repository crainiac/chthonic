# Replaces the dummy package name with the desired package name,
# deletes chthonic version control information, and deletes itself.
set -e
if [ ! -z "$1" ]
then
    mv chthonic $1
    sed -i'.bak' -e s/chthonic/$1/g Vagrantfile setup.py
    rm Vagrantfile.bak setup.py.bak
    rm -rf .git
    rm replace_chthonic.sh
else
    echo 'Usage: sh replace_chthonic.sh <your-package-name>'
fi
