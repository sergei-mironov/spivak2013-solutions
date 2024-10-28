{ pkgs
, litrepl
, aicli
, revision ? null
} :
let
  local = rec {

    inherit (pkgs) python3 zathura evince inotify-tools tabbed;
    inherit (litrepl) litrepl-release;
    inherit (aicli) python-aicli;


    tabbed_ = tabbed.override {
      customConfig = builtins.readFile ./c/tabbed.config.h;
      patches = [ ./c/tabbed.patch ];
    };

    runtabbed = pkgs.writeShellScriptBin "runtabbed.sh" ''
      unset TMUX
      ${tabbed_}/bin/tabbed -d >/tmp/tabbed.xid
      zathura  -e $(</tmp/tabbed.xid)  tex/main.pdf &
      sleep 0.3
      st -w $(</tmp/tabbed.xid) &
      sleep 0.3
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
        litrepl-release
        python-aicli
        pkgs.gitFull
        texlive-dev
        zathura
        evince
        python-dev
        inotify-tools
        tabbed_
        runtabbed
      ];

      shellHook = with pkgs; ''
        if test -f ./env.sh ; then
          . ./env.sh
        fi
      '';
    };

    shell = shell-nixos;

    collection = rec {
      inherit shell runtabbed;
    };
  };

in
  local.collection

