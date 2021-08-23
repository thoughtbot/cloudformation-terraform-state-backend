.PHONY: default clean

default: .lint .nag

.lint: terraform-state-backend.template
	cfn-lint terraform-state-backend.template
	touch .lint

.nag: terraform-state-backend.template
	cfn_nag --fail-on-warnings --blacklist-path ignorelist.yaml terraform-state-backend.template
	touch .nag

clean:
	rm .lint .nag
