# danpiths' dotfiles ❄️

a macos configuration managed with **nix-darwin** and **home manager**.

## 👾 setup

1.  **install nix**:

    ```bash
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    ```

2.  **clone the repository**:

    ```bash
    git clone https://github.com/danpiths/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

3.  **apply configuration**:

    ```bash
    nix run nix-darwin -- switch --flake .
    ```

    _on subsequent updates, you can just run:_

    ```bash
    nh darwin switch ~/dotfiles
    ```

## 📄 license

this project is licensed under the [mit license](./LICENSE).
