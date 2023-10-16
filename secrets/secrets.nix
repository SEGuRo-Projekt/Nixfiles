let
  inherit (builtins) attrValues concatLists;

  # Add your personal public keys here.
  userKeys = {
    pjungkamp = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK5ypxwGHqA1bHjzNNv4aaYT1P8Bq1s4HRIXIWN27FWz pjungkamp@yoga9"
    ];
    svogel = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA8xvUHFUCPxrcZNiP5W/+VG3Aalsdwo8i6Q+oKaGEGz stv0g@cam.0l.de"
    ];
  };

  # Add the unique public key for a machine here.
  systemKey = {
    remote-builder = "age1klat8yl3arxx3jrtgrs75652uc834yua8zed3rjeue33zjxgzyeq4cje9h";
    remote-store = "age1vr4vewtnn6ne2nak74rlg6w9z4dg9m9r6mhj8katwx7uayy7uy4sxr6q5g";
  };

  allUserKeys = concatLists (attrValues userKeys);
  allSystemKeys = attrValues systemKey;
in {
  "password-pjungkamp.age".publicKeys = allSystemKeys ++ userKeys.pjungkamp;
  "password-svogel.age".publicKeys = allSystemKeys ++ userKeys.svogel;
}
