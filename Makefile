name:
	@echo "vagrantfile-template"

version:
	@echo "v1.0.0"

test:
	@echo "running test..."
	@rm -rf test
	@mkdir test
	@cp Vagrantfile provision_reboot.rb test/
	@cd test ; vagrant up
	@cd test ; vagrant destroy -f
	@echo "\n\n"
	@cd test ; NOUPDATE=true vagrant up
	@cd test ; vagrant destroy -f
	@echo "\n\n"
	@cd test ; NOUPDATE=true PROVISION=nodejs vagrant up

clean:
	@echo "clean test..."
	@cd test ; vagrant destroy ; cd .. ; rm -rf test

run:
	@echo "running vagrant $(cmd)..."
	@[ -d test ] && cd test ; vagrant $(cmd)

.PHONY: name version test clean run
