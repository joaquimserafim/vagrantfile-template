name:
	@echo "vagrantfile-template"

version:
	@echo "v1.0.0"

test:
	@echo "running test..."
	@rm -rf test
	@mkdir test
	@cp Vagrantfile provision_reboot.rb test/ ; cd test ; vagrant up

clean:
	@echo "clean test..."
	@cd test ; vagrant destroy ; cd .. ; rm -rf test

.PHONY: name version test clean
