# Swissbib Metafacture Extensions: Examples

This directory comprises a set of examples using the Metafacture commands we developed in the context of the project [linked-swissbib](https://data.swissbib.ch). For an extended description what the single commands do see the [README](https://github.com/linked-swissbib/swissbib-metafacture-commands/blob/master/README.md) of the plugin repository.

## Installation
In order to run the examples you have to install the
[swissbib-metafacture-commands](https://github.com/linked-swissbib/swissbib-metafacture-commands) plugin. The underlying metafacture-core has still version 3.3.2, so you might have some problems if using the plugin with a newer metafacture-runner.

1. Clone the repository: `git clone https://github.com/linked-swissbib/swissbib-metafacture-commands`
2. Compile it: `mvn clean package shade:shade -Dmaven.test.skip=true`
3. Move the fat jar in the `target/` folder (`swissbibMF-plugins-1.0.jar`) to the `plugins/` folder of your metafacture-runner instance
