{
  description = "spivak2013-solutions";

  nixConfig = {
    bash-prompt = "\[ spivak2013-solutions \\w \]$ ";
  };

  inputs = {
    nixpkgs = {
      url = "github:grwlf/nixpkgs/local17";
    };

    aicli = {
      url = "github:sergei-mironov/aicli";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # litrepl = {
    #   url = "github:sergei-mironov/litrepl";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     aicli.follows = "aicli";
    #   };
    # };
  };

  outputs = { self, nixpkgs, aicli }:
    let
      defaults = (import ./default.nix) {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        # litrepl = litrepl.outputs.packages.x86_64-linux;
        aicli = aicli.outputs.packages.x86_64-linux;
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
