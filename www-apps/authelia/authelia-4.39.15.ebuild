# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="An open-source authentication and authorization server"
HOMEPAGE="https://www.authelia.com https://github.com/authelia/authelia"
SRC_URI="https://github.com/authelia/authelia/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND=">=dev-lang/go-1.20"
RDEPEND="
	${DEPEND}
	acct-group/authelia
	acct-user/authelia
"

RESTRICT="test"

S="${WORKDIR}/${PN}-${PV}"

src_compile() {
	ego build -o authelia ./cmd/authelia
}

src_install() {
	dobin authelia
	einstalldocs
}
