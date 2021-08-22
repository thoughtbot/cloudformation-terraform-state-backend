.PHONY: default clean

default: .lint .nag

.lint: backend.template
	cfn-lint backend.template
	touch .lint

.nag: backend.template
	cfn_nag --fail-on-warnings --blacklist-path ignorelist.yaml backend.template
	touch .nag

clean:
	rm .lint .nag
