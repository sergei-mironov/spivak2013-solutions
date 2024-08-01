{ pkgs
, litrepl
, aicli
, revision ? null
} :
let
  local = rec {

    inherit (pkgs) python3 zathura evince;
    inherit (litrepl) litrepl-release;
    inherit (aicli) python-aicli;

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
          natbib biblatex-apa comment fancyvrb tikz-cd;
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
      ];

      shellHook = with pkgs; ''
        if test -f ./env.sh ; then
          . ./env.sh
        fi
      '';
    };

    shell = shell-nixos;

    collection = rec {
      inherit shell ;
    };
  };

in
  local.collection

