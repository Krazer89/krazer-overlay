# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd tmpfiles

DESCRIPTION="An open-source authentication and authorization server"
HOMEPAGE="https://www.authelia.com https://github.com/authelia/authelia"
SRC_URI="https://github.com/authelia/authelia/releases/download/v${PV}/authelia-v${PV}-linux-amd64.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	acct-group/authelia
	acct-user/authelia
"

S="${WORKDIR}"

src_install() {
	dobin authelia

	# Install systemd service files
	systemd_dounit authelia.service authelia@.service

	# Install sysusers config
	insinto /usr/lib/sysusers.d
	doins authelia.sysusers.conf

	# Install tmpfiles configs
	insinto /usr/lib/tmpfiles.d
	doins authelia.tmpfiles.conf authelia.tmpfiles.config.conf

	# Install example config
	insinto /etc/authelia
	newins config.template.yml configuration.example.yml
}

pkg_postinst() {
	tmpfiles_process authelia.tmpfiles.conf authelia.tmpfiles.config.conf
}
