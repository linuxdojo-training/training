TEMPDIR := $(shell readlink -m package)

test:
	./pingtest >/dev/null 2>&1 && echo Tests pass || (echo Tests fail && exit 1)

package:
	mkdir -p ${TEMPDIR}/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS,ENV}

	cp  ./pingtest ${TEMPDIR}/SOURCES

	rpmbuild -vv -bb --target="noarch" --clean --define "_topdir ${TEMPDIR}" support/pingtest.spec
	find ${TEMPDIR} -type f -name '*.rpm' -print0 | xargs -0 -I {} mv {} ./
	rm -rf ${TEMPDIR}