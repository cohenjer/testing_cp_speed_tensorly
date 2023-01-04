# Create new virtualenv
curdir=$(pwd)
echo $curdir
cd ~/.venvs/
python3.8 -m venv testing_cp_tensorly
source testing_cp_tensorly/bin/activate
cd $curdir
echo Tensorly path you provided is $1
# ask tensorly path

# Installing dependencies
pip install numpy==1.23
pip install ipython

# Manually doing the current dev version
# must be tweaked manually depending on local tensorly path
#cd ~/Online/notime/tensorly/tensorly
cd $1
pip install -e .
cd $curdir
echo Running latest tensorly version >> results.txt
python cp_runner.py

# Define list of tensorly versions to test
versions='0.7.0 0.6.0 0.5.1 0.5.0 0.4.5 0.4.4 0.4.3 0.4.2 0.4.0 0.3.0'

# Running a pip install and python script to compute and time CP in bash loop
for version in $versions
do 
    echo Running tensorly version $version >> results.txt
    pip install tensorly==$version
    python cp_runner.py
done

# remove virtualenv
#cd ~/.venvs/
#rm -r -f testing_cp_tensorly