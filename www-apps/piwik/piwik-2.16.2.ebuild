# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-4.0.5.ebuild,v 1.8 2013/08/24 12:35:25 ago Exp $

EAPI=5

inherit eutils webapp depend.php

DESCRIPTION="Open source web analytics platform"
HOMEPAGE="https://piwik.org/"
SRC_URI="http://builds.piwik.org/${P}.tar.gz"

LICENSE="GPL-3+"
KEYWORDS="~amd64 ~x86"
IUSE="gd"

RDEPEND="
	dev-lang/php[gd?]
	|| (
		dev-lang/php[mysqli]
		dev-lang/php[mysql]
	)
"

need_php_httpd

S="${WORKDIR}/${PN}"

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	dodoc README.md || die
	rm -f LEGALNOTICE

	insinto "${MY_HTDOCSDIR#${EPREFIX}}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR#${EPREFIX}}"/config/global.ini.php
	webapp_serverowned "${MY_HTDOCSDIR#${EPREFIX}}"/config/global.ini.php
	webapp_src_install
}
