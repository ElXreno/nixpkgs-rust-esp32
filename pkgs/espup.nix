{ lib, fetchCrate, rustPlatform, darwin, stdenv, pkg-config, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "espup";
  version = "0.3.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-XEq0j/F5kNzbrRr8HFZ13cSePIvVpQqlqRCupeRN14Y=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  OPENSSL_NO_VENDOR = 1;

  cargoSha256 = "sha256-FEERJn8Lr2jBGy0egHlKColT9iQQQ6elCubMs2fCaHo=";

  # thread 'tests::test_get_export_file' panicked at 'assertion failed: get_export_file(Some(home_dir)).is_err()', src/main.rs:542:9
  doCheck = false;

  meta = with lib; {
    description = "A linker proxy tool";
    homepage = "https://github.com/esp-rs/espup";
    license = licenses.mit;
    maintainers = [ maintainers.alekseysidorov ];
  };
}
