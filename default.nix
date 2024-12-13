{ pkgs
# , litrepl
, aicli
, revision ? null
} :
let
  local = rec {

    inherit (pkgs) python3 zathura evince inotify-tools tabbed;
    # inherit (litrepl) litrepl-release;
    inherit (aicli) python-aicli;


    tabbed_ = tabbed.override {
      customConfig = builtins.readFile ./c/tabbed.config.h;
      patches = [ ./c/tabbed.patch ];
    };

    xterminal = pkgs.writeShellScriptBin "xterminal.sh" ''
      unset TMUX
      set -x
      ${tabbed_}/bin/tabbed -d >/tmp/tabbed.xid
      WID=$(</tmp/tabbed.xid)
      zathura  -e $WID  tex/main.pdf &
      sleep 0.3
      CMD=$@
      if test -z "$CMD" ; then
        CMD=$SHELL
      fi
      st -w $WID -e env WINDOWID=$WID $CMD
      xkill -id $WID
    '';

    python = python3;

    python-dev = python.withPackages (
      pp: let
        pylsp = pp.python-lsp-server;
        pylsp-mypy = pp.pylsp-mypy.override { python-lsp-server=pylsp; };
      in with pp; [
        pylsp
        pylsp-mypy
        setuptools
        setuptools_scm
        ipython
        hypothesis
        pytest
        pytest-mypy
        wheel
        twine
        sympy
        tqdm
        matplotlib
        numpy
        bpython
        psutil
        pygments
        lark
        (aicli.aicli pp)
      ]
    );

    texlive-dev =
      (let
        texlive = pkgs.texlive.override { python3=python-dev; };
      in
        texlive.combine {
          scheme-medium = texlive.scheme-medium;
          inherit (texlive) fvextra upquote xstring pgfopts currfile collection-langcyrillic makecell
          ftnxtra minted catchfile framed pdflscape environ trimspaces mdframed zref needspace import
          beamerposter qcircuit xypic standalone preview amsmath thmtools tocloft tocbibind varwidth
          beamer tabulary ifoddpage relsize svg transparent stix fontspec overpic eepic appendix
          raleway fontawesome lipsum enumitem ly1 biblatex tcolorbox csquotes listingsutf8 biber
          natbib biblatex-apa comment fancyvrb tikz-cd luatex tikzsymbols;
        }
      );

    shell-nixos = pkgs.mkShell {
      name = "shell-nixos";
      buildInputs = [
        # litrepl-release
        python-aicli
        pkgs.gitFull
        texlive-dev
        zathura
        evince
        python-dev
        inotify-tools
        tabbed_
        xterminal
      ];

      shellHook = with pkgs; ''
        if test -f ./env.sh ; then
          . ./env.sh
        fi
      '';
    };

    shell = shell-nixos;

    collection = rec {
      inherit tabbed_ shell xterminal;
    };
  };

in
  local.collection

