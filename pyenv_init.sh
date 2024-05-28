
activate_venv() {
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

    VENV_DIR="$SCRIPT_DIR/venv"

    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || -n "$WINDIR" ]]; then
        source "$VENV_DIR/Scripts/activate"
    else
        source "$VENV_DIR/bin/activate"
    fi
}

create_folder_and_venv() {
    read -p "Entrez le nom du dossier : " FOLDER_NAME

    if [[ ! "$FOLDER_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        echo "Le nom du dossier ne peut contenir que des lettres, des chiffres, des tirets (-) ou des traits de soulignement (_). Exécution terminée :-("
        exit 1
    fi

    FOLDER_DIR=$PWD/$FOLDER_NAME

    mkdir -p $FOLDER_DIR
    cd $FOLDER_DIR

    if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
        python3 -m venv venv
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || -n "$WINDIR" ]]; then
        python -m venv venv
    else
        echo "Le système d'exploitation '$OSTYPE' n'est pas pris en charge :-("
        exit 1
    fi

    if [ -d "venv" ]; then
        activate_venv
    else
        echo "Erreur lors de la création de l'environnement virtuel. Exécution terminée :-("
        exit 1
    fi
}

create_folder_and_venv

echo "Happy coding ✨"

code .