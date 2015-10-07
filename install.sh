#! /bin/bash
PREFIX="INSTALL"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${DIR}/install/functions.sh"

while [ "$1" != "" ]; do
  case $1 in
    -u|--update)
      UPDATE=true
      ;;
    -l|--license)
      LICENSE=true
      ;;
    -h|--help)
      usage
      exit
      ;;
    *)
      echo "ERROR: unknown parameter: ${1}"
      usage
      exit 1
      ;;
  esac
  shift
done


#
# default action: install environment
#
if [[ -z "$1" ]]; then
  log "Linking dotfiles"

  ensure_secret_dir_exists
  agree_to_xcode_license $LICENSE
  update_packages $UPDATE
  install_required_packages
  log_into_lastpass

  source $DIR/install/modules.sh


#
# header: install a bash header
#
elif [[ "$1" == "header" ]]; then
  HEADDIR="$DIR/bash/header"
  if [[ -z "$2" ]]; then
    echo 'Install which header?'
  else
    if [[ -f "${HEADDIR}/${2}" ]]; then
      echo "Installing header: ${HEADDIR}/${2}"
      rm ~/.bash_header 2>/dev/null
      ln -s $HEADDIR/$2 ~/.bash_header
    else
      echo "${HEADDIR}/${2} doesnt exist..."
    fi
  fi


else
  echo "Dont know what ${1} means"
fi
