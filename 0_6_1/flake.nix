{
  description = ''A better regular expression library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nre-0_6_1.flake = false;
  inputs.src-nre-0_6_1.owner = "flaviut";
  inputs.src-nre-0_6_1.ref   = "refs/tags/0.6.1";
  inputs.src-nre-0_6_1.repo  = "nre";
  inputs.src-nre-0_6_1.type  = "github";
  
  inputs."optional_t".dir   = "nimpkgs/o/optional_t";
  inputs."optional_t".owner = "riinr";
  inputs."optional_t".ref   = "flake-pinning";
  inputs."optional_t".repo  = "flake-nimble";
  inputs."optional_t".type  = "github";
  inputs."optional_t".inputs.nixpkgs.follows = "nixpkgs";
  inputs."optional_t".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nre-0_6_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nre-0_6_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}