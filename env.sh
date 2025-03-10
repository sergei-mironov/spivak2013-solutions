CWD=`pwd`
export PROJECT_SOURCE="$CWD"
export PROJECT_ROOT="$PROJECT_SOURCE"
export VIM_PLUGINS="/home/grwlf/proj/vim-sm-terminal-images/vim,$CWD/modules/vim-terminal-images,$CWD/vim"
export TUPIMAGE_UPLOADING_METHOD=file

update_pathvar() {
    case "$(eval echo \"\$$1\")" in
        *$2:*) ;;
        *)
            echo "Adding into $1 value $2"
            eval "export $1=$2:\$$1";;
    esac
}

update_pathvar "PATH" "$CWD/sh"
update_pathvar "PATH" "$CWD/modules/vim-terminal-images/tupimage"

# export LITREPL_WORKDIR="$PROJECT_SOURCE"
# export LITREPL_AI_AUXDIR="$PROJECT_SOURCE/_litrepl/ai"
# export LITREPL_PYTHON_AUXDIR="$PROJECT_SOURCE/_litrepl/python"
