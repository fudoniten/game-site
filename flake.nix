{
  description = "Jasper's videogame site — a static site built with Astro";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.buildNpmPackage {
          pname = "jasper-games-site";
          version = "0.1.0";

          src = ./.;

          # Generated from package-lock.json. If this ever goes stale (e.g.
          # after `npm install`ing a new dependency), `nix build` will fail
          # and print the correct hash to paste in here.
          npmDepsHash = "sha256-3CVkV+QieYh5VvVNTx4pZpqzX/dTTWC8LrrckeS/yaI=";

          # `astro check` needs the dev server's TypeScript project to
          # resolve; the plain build is enough for a package output and
          # keeps this fully offline/sandboxed.
          buildPhase = ''
            runHook preBuild
            npx astro build
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            cp -r dist $out
            runHook postInstall
          '';

          doDist = false;
        };

        devShells.default = pkgs.mkShell { buildInputs = [ pkgs.nodejs_22 ]; };
      });
}
