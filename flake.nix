{
  description = "spivak2013-solutions";

  nixConfig = {
    bash-prompt = "\[ spivak2013-solutions \\w \]$ ";
  };

  inputs = {
    nixpkgs = {
      url = "github:grwlf/nixpkgs/local17";
    };

    litrepl = {
      url = "github:sergei-mironov/litrepl";
    };
  };

  outputs = { self, nixpkgs, litrepl }:
    let
      defaults = (import ./default.nix) {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        litrepl = litrepl.outputs.packages.x86_64-linux;
        revision = if self ? rev then self.rev else null;
      };
    in {
      packages = {
        x86_64-linux = defaults;
      };
      devShells = {
        x86_64-linux = {
          default = defaults.shell;
        };
      };
    };
}
