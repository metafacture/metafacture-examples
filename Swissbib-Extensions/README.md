# Swissbib Metafacture Extensions: Examples

See the
[README](https://github.com/linked-swissbib/swissbib-metafacture-commands/blob/master/README.md) of the plugin repository for an overview of the available commands.

## Installation
In order to run the examples you have to install the
[swissbib-metafacture-commands](https://github.com/linked-swissbib/swissbib-metafacture-commands) plugin.

1. Clone the repository: `git clone https://github.com/linked-swissbib/swissbib-metafacture-commands`
2. Compile it: `mvn clean package shade:shade -Dmaven.test.skip=true`
3. Move the fat jar in the `target/` folder (`swissbibMF-plugins-1.0.jar`) to the `plugins/` folder of your metafacture-runner instance
