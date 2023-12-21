libilluminate-database.so:
	./bpc-prepare.sh src.list
	$(MAKE) -C ./Illuminate libilluminate-database

libilluminate-database:
	bpc -v \
		-c bpc.conf  \
		-l illuminate-database \
		-u illuminate-container     \
		-u illuminate-contracts     \
		-u illuminate-support       \
		-u illuminate-events        \
		-u illuminate-pagination    \
		-u symfony-polyfill-php80           \
		-u symfony-contracts-translation    \
		-u php-hash                         \
		-u php-mbstring                     \
		-u symfony-component-translation    \
		-u carbon                           \
		--input-file src.list

install-libilluminate-database:
	cd Illuminate && bpc -l illuminate-database --install
