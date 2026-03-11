# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="An open-source authentication and authorization server"
HOMEPAGE="https://www.authelia.com https://github.com/authelia/authelia"
SRC_URI="
	https://github.com/authelia/authelia/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/authelia/authelia/releases/download/v${PV}/authelia-v${PV}-public_html.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=">=dev-lang/go-1.20"
RDEPEND="
	${DEPEND}
	acct-group/authelia
	acct-user/authelia
"

RESTRICT="test"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	default
	# Extract and install prebuilt public_html
	mkdir -p "internal/server/public_html/api"
	tar -xzf "${DISTDIR}/authelia-v${PV}-public_html.tar.gz" -C "internal/server/public_html/"
}

src_compile() {
	# Download Go modules
	ego mod download

	# Build with security hardening flags
	ego build \
		-ldflags "-linkmode=external -s -w" \
		-trimpath \
		-buildmode=pie \
		-o authelia \
		./cmd/authelia
}

src_install() {
	dobin authelia
	diropts -o authelia -g authelia -m 0750
	dodir /var/lib/authelia
	einstalldocs
}
