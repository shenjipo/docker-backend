define RUN_LOCAL_TXT
Which service do you want to start run?
  1) _docker-build-tar
  2) _server-mysql-image
  3) _template-node-image
  4) _blog-nest-image

endef
export RUN_LOCAL_TXT

.PHONY: run
run:
	@echo "$$RUN_LOCAL_TXT";
	@read -p "ENTER THE NUMBER: " SERVICE ;\
	if [ "$$SERVICE" = "1" ]; then make _docker-build-tar; fi ;\
 	if [ "$$SERVICE" = "2" ]; then make _server-mysql-image; fi ;\
 	if [ "$$SERVICE" = "3" ]; then make _template-node-image; fi ;\
 	if [ "$$SERVICE" = "4" ]; then make _blog-nest-image; fi ;\

.PHONY: _server-mysql-image
_server-mysql-image:
	docker build -f Dockerfile.mysql -t server-mysql-image:latest .

.PHONY: _blog-nest-image
_blog-nest-image:
	docker build -f Dockerfile.blog.nest -t blog-nest-image:latest .

.PHONY: _template-node-image
_template-node-image:
	docker build -f Dockerfile.template.node -t template-node-image:latest .


.PHONY: _docker-build-tar
_docker-build-tar:
	docker save -o ./server-container/blog-nest-image.tar blog-nest-image:latest
	docker save -o ./server-container/template-node-image.tar template-node-image:latest
	docker save -o ./server-container/server-mysql-image.tar server-mysql-image:latest