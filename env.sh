CWD=`pwd`
export PROJECT_SOURCE="$CWD"
export VIM_PLUGINS="$CWD/vim"

update_pathvar() {
    case "$(eval echo \"\$$1\")" in
        *$2:*) ;;
        *)
            echo "Adding into $1 value $2"
            eval "export $1=$2:\$$1";;
    esac
}

update_pathvar "PATH" "$CWD/sh"

