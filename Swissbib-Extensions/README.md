== Examples for the Swissbib Metafacture Extensions ==

In order to run the examples you have to install the
[swissbib-metafacture-commands](https://github.com/linked-swissbib/swissbib-metafacture-commands) plugin.

1. Clone the repository
	
	git clone
https://github.com/linked-swissbib/swissbib-metafacture-commands

2. Compile it

	mvn clean package shade:shade -Dmaven.test.skip=true

3. Move the fat jar application to the `plugins/` of your metafacture-runner
   instance

4. And you're set!
