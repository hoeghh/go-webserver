# MakeIT prototype
#
# run 'make list' to get a list of targets to run: 
# $ make list
# - Cloning plan https://github.com/hoeghh/go-plan.git
# Location Target               Description
# -------- -------------------- ---------------------------------------------------
# plan     scan                 This target security scan the go app
# plan     build                This target builds the go app
# plan     build-container      This target builds a container image with the go app
#
# Valid params : 
# 	SKIP_PULL=true  # MakeIT wont pull or update the plan
#	DEBUG=true      # Output debug information
#
# Using Image tag for build and scan:
#   export IMGTAG=1.2
#   make build-container
#   make scan
# or
#   make scan IMGTAG=1.2

PLAN     := "$(shell bash -c 'yq -r ".plan" bura.yaml')"
BURAFILE := "$(shell bash -c 'realpath bura.yaml')"

.clone_plan:
ifneq ("$(SKIP_PULL)","true")
	@echo "- Cloning plan $(PLAN)"
	@rm -rf .plan && git clone $(PLAN) .plan --quiet >&2
else
	@echo "- Skipping plan clone"
endif

%: .clone_plan
	@export PLAN=$(PLAN) && \
	export BURAFILE=$(BURAFILE) && \
	export DEBUG=$(DEBUG) && \
	$(MAKE) --silent -f .plan/Makefile $@