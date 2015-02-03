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
provision:
	@echo "running provision..."
	@cd test/
	@vagrant provision
halt:
	@echo "running halt..."
	@cd test/
	@vagrant halt
up:
	@echo "running up..."
	@cd test/
	@vagrant up
reload:
	@echo "running reload..."
	@cd test/
	@vagrant reload
destroy:
	@echo "running destroy..."
	@cd test/
	@vagrant destroy
ssh:
	@echo "running ssh..."
	@cd test/
	@vagrant ssh

.PHONY: name version test provision halt up reload destroy ssh
