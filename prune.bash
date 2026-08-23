current=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | grep current | awk '{print $1}')

mapfile -t to_delete < <(sudo nix-env --list-generations -p /nix/var/nix/profiles/system |
  awk '{print $1}' |
  grep -v -E "^(1|$current)$")

echo "Will delete: ${to_delete[*]}"
sudo nix-env --delete-generations "${to_delete[@]}" -p /nix/var/nix/profiles/system
