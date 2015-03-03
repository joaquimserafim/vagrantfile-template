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
clean:
	@echo "running clean test..."
	@cd test
	@vagrant destroy
	@cd ..
	@rm -rf test
provision:
	@echo "running provision..."
	@vagrant provision
halt:
	@echo "running halt..."
	@vagrant halt
up:
	@echo "running up..."
	@vagrant up
reload:
	@echo "running reload..."
	@vagrant reload
destroy:
	@echo "running destroy..."
	@vagrant destroy
ssh:
	@echo "running ssh..."
	@vagrant ssh

.PHONY: name version test clean provision halt up reload destroy ssh
