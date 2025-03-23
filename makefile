define RUN_LOCAL_TXT
Which service do you want to start run?
  1) _server-mysql-image
  2) _blog-node-image
  3) _template-node-image
  4) _docker-build-tar

endef
export RUN_LOCAL_TXT

.PHONY: run
run:
	@echo "$$RUN_LOCAL_TXT";
	@read -p "ENTER THE NUMBER: " SERVICE ;\
	if [ "$$SERVICE" = "1" ]; then make _server-mysql-image; fi ;\
 	if [ "$$SERVICE" = "2" ]; then make _blog-node-image; fi ;\
 	if [ "$$SERVICE" = "3" ]; then make _template-node-image; fi ;\
 	if [ "$$SERVICE" = "4" ]; then make _docker-build-tar; fi ;\

.PHONY: _server-mysql-image
_server-mysql-image:
	docker build -f Dockerfile.mysql -t server-mysql-image:latest .

.PHONY: _blog-node-image
_blog-node-image:
	docker build -f Dockerfile.blog.node -t blog-node-image:latest .

.PHONY: _template-node-image
_template-node-image:
	docker build -f Dockerfile.template.node -t template-node-image:latest .


.PHONY: _docker-build-tar
_docker-build-tar:
	docker save -o ./server-container/blog-node-image.tar blog-node-image:latest
	docker save -o ./server-container/template-node-image.tar template-node-image:latest
	docker save -o ./server-container/server-mysql-image.tar server-mysql-image:latest