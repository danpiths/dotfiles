# danpiths' dotfiles ❄️

a macos configuration managed with **nix-darwin** and **home manager**.

## 👾 setup

1.  **install nix**:

    ```bash
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    ```

2.  **clone the repository**:

    ```bash
    git clone --recurse-submodules https://github.com/danpiths/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

    _if you already cloned the repository without its submodules, run:_

    ```bash
    git submodule update --init --recursive
    ```

3.  **apply configuration**:

    ```bash
    nix run nix-darwin -- switch --flake .
    ```

    _on subsequent updates, you can just run:_

    ```bash
    nh darwin switch path:$HOME/dotfiles
    ```

## 📄 license

this project is licensed under the [mit license](./LICENSE).
