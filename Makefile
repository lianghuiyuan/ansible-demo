USE_DOCKER=0
ENV = pre
WORK_PATH = $(shell echo $(shell pwd))
CPU_ARCH := $(shell uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')
PLAYBOOKS = [kibana, elasticsearch]

ifeq ($(USE_DOCKER),1)
	PLAYBOOK=docker run --rm -it -v $(WORK_PATH):/work -e ANSIBLE_HOST_KEY_CHECKING=False --network host -w /work registry.xxx.net/library/ansible:10.4.0-$(CPU_ARCH) ansible-playbook
else
	PLAYBOOK=ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook
endif

# elasticsearch
.PHONY: pull_es_images
pull_es_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t pull_images

.PHONY: load_es_images
load_es_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t load_images 

.PHONY: prepare_es
prepare_es: load_es_images

.PHONY: install_es
install_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t install

.PHONY: uninstall_es
uninstall_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t uninstall

.PHONY: destory_es
destory_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t destory

.PHONY: start_es
start_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t start

.PHONY: stop_es
stop_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t stop

.PHONY: restart_es
restart_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t restart

.PHONY: update_es
update_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t update

.PHONY: recreate_es
recreate_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t recreate


# kibana
.PHONY: pull_kibana_images
pull_kibana_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t pull_images

.PHONY: load_kibana_images
load_kibana_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t load_images

.PHONY: prepare_kibana
prepare_kibana: load_kibana_images

.PHONY: install_kibana
install_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t install

.PHONY: uninstall_kibana
uninstall_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t uninstall

.PHONY: destory_kibana
destory_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t destory

.PHONY: start_kibana
start_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t start

.PHONY: stop_kibana
stop_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t stop

.PHONY: restart_kibana
restart_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t restart

.PHONY: update_kibana
update_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t update

.PHONY: recreate_kibana
recreate_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t recreate
