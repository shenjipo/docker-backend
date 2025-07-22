define RUN_LOCAL_TXT
Which service do you want to start run?
  1) docker-build-tar
  2) server-mysql-image
  3) template-node-image
  4) blog-nest-image
  5) workbench-node-image
endef
export RUN_LOCAL_TXT

.PHONY: run
run:
	@echo "$$RUN_LOCAL_TXT";
	@read -p "ENTER THE NUMBER: " SERVICE ;\
	if [ "$$SERVICE" = "1" ]; then make docker-build-tar; fi ;\
 	if [ "$$SERVICE" = "2" ]; then make server-mysql-image; fi ;\
 	if [ "$$SERVICE" = "3" ]; then make template-node-image; fi ;\
 	if [ "$$SERVICE" = "4" ]; then make blog-nest-image; fi ;\
	if [ "$$SERVICE" = "5" ]; then make workbench-node-image; fi ;\

.PHONY: _server-mysql-image
server-mysql-image:
	docker build -f Dockerfile.mysql -t server-mysql-image:latest .

.PHONY: _template-node-image
template-node-image:
	docker build -f Dockerfile.template.node -t template-node-image:latest .

.PHONY: _blog-nest-image
blog-nest-image:
	docker build -f Dockerfile.blog.nest -t blog-nest-image:latest .

.PHONY: _blog-nest-image
workbench-node-image:
	docker build -f Dockerfile.workbench.node -t workbench-node-image:latest .

.PHONY: _docker-build-tar
docker-build-tar:
	docker save -o ./server-container/blog-nest-image.tar blog-nest-image:latest
	docker save -o ./server-container/workbench-node-image.tar workbench-node-image:latest
	docker save -o ./server-container/template-node-image.tar template-node-image:latest
	docker save -o ./server-container/server-mysql-image.tar server-mysql-image:latest