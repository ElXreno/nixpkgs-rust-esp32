{ lib
, rustPlatform
, fetchCrate
, pkg-config
, udev
, stdenv
, darwin
, openssl
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-espflash";
  version = "2.0.0-rc.3";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-c2wgdPh70xPnW0KCIPQ6snQNdLPeF6J7VQNoxSYojE8=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isLinux [
    udev
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  OPENSSL_NO_VENDOR = 1;

  cargoSha256 = "sha256-AHgXZMYm9syD3k+PwXeawSLrGELTgWjrZWVXBRXBwKw=";

  meta = with lib; {
    description = "Cargo subcommand for flashing Espressif devices over serial";
    homepage = "https://github.com/esp-rs/espflash";
    license = licenses.mit;
    maintainers = [ maintainers.alekseysidorov ];
  };
}
