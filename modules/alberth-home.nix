{ inputs, lib, ... }: {
  dendritic.userHomeConfigFor = [
    (u: {
      imports = lib.optional (u.name == "alberth") "${inputs.nix-home}/home.nix";
    })
  ];
}
