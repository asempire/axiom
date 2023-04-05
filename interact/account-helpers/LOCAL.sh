#!/bin/bash

$AXIOM_PATH="~/.axiom"
echo "Beginning self hosting setup"

cd AXIOM_PATH

echo "installing required installation scripts"
git clone https://github.com/asempire/axiom-local.git

cd AXIOM_PATH/axiom-local

echo -e "Do you have a .csv with the appropriate configs? (y/N):"
echo -n ">"
read choice

if [[ $choice == "y" || $choice == "Y"]];
then
	echo -n "please provide the path of that file: "
	read FILE_PATH
	if [[ ! -f $FILE_PATH ]];
	then
		echo "path provided doesn't exist and the csv creator file will be launched"
		FILE_PATH="file_$(date +%s).csv"
    python3 create_csv_file.py $FILE_PATH
	fi
else
    echo "creating csv file"
    FILE_PATH="file_$(date +%s).csv"
    python3 create_csv_file.py $FILE_PATH
fi

echo "The deployment process might take some time depending on the power of the machines and the internet connection so please be patient"
bash -c "deploy.sh -f $FILE_PATH" #change this line when testing
echo "You can check the progress of the installation by running ~/.axiom/axiom-local/progress.sh"
echo "you may need to restart the shell"
