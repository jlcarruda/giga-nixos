  (final: super: {
    pythonPackagesOverlays =
      (super.pythonPackagesOverlays or [])
      ++ [
        (_: pprev: {
          # qtile = pprev.qtile.overridePythonAttrs (_: {
          #   version = ''unstable-2023-10-06''; # qtile
          #   src = super.fetchFromGitHub {
          #     owner = "qtile";
          #     repo = "qtile";
          #     rev = ''da90e98762e4f1f4e625705fe9cf01ba1e5cc651''; # qtile
          #     hash = ''sha256-Rd8m5LUStVktbm7VrjFNKQUbGQPRav8Oloq1KvMUT8k=''; # qtile
          #   };
          # });
          qtile-extras = pprev.qtile-extras.overridePythonAttrs (old: {
            version = ''unstable-2023-10-08''; # extras
            src = super.fetchFromGitHub {
              owner = "elParaguayo";
              repo = "qtile-extras";
              rev = ''ba982952257ff121879646cca00ac4e38f5e8f43''; # extras
              hash = ''sha256-IjDGrWa5lzmt9JPmG9L84DX2sZcPtqpHx7IM+nfXQ5M=''; # extras
            };
          });
        })
      ];
    python3 = let
      self = super.python3.override {
        inherit self;
        packageOverrides = super.lib.composeManyExtensions final.pythonPackagesOverlays;
      };
    in
      self;
    python3Packages = final.python3.pkgs;
  })