{
  name = "alberth";
  # Must match the pre-existing macOS account's uid (`id -u alberth`), or
  # nix-darwin's declarative user management (users.knownUsers) skips it.
  uid = 501;
  fullName = "Alberth Matos";
  passwordSecret = "alberth-password";
}
