
.PHONY: name version test clean run

name:
	@echo "vagrantfile-template"

version:
	@echo "v2.0.1"

test:
	@echo "running tests..."
	@rm -rf test
	@mkdir test
	@cp Vagrantfile test/
	@echo "::Normal test"
	@cd test ; vagrant up
	@cd test ; vagrant destroy -f
	@echo "DONE\n"
	@echo "::Skip OS update"
	@cd test ; SKIP_UPDATE=true vagrant up
	@cd test ; vagrant destroy -f
	@echo "DONE\n"
	@echo "::Skip OS udpate & add one more installation to the provision"
	@cd test ; SKIP_UPDATE=true PROVISION=nodejs vagrant up
	@cd test ; vagrant destroy -f
	@echo "DONE\n"
	@echo "::Skip OS update & add 'nodejs' to the provision & use local provision scripts"
	@cd test ; SKIP_UPDATE=true PROVISION=nodejs PROVISION_SCRIPT=../../vagrant-provision/provision.sh vagrant up

clean:
	@echo "clean test..."
	@cd test ; vagrant destroy ; cd .. ; rm -rf test

run:
	@echo "running vagrant $(cmd)..."
	@[ -d test ] && cd test ; vagrant $(cmd)
