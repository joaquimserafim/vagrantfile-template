name:
	@echo "vagrantfile-template"
version:
	@echo "v1.0.0"
test:
	@echo "running test..."
	@rm -rf test
	@mkdir test
	@cp Vagrantfile provision_reboot.rb test/
	@cd test
	@vagrant up

.PHONY: name version test
