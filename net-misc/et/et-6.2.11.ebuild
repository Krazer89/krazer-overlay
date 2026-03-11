# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Re-Connectable secure remote shell"
HOMEPAGE="https://eternalterminal.dev"
if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MisterTea/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/MisterTea/EternalTerminal/archive/refs/tags/et-v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/EternalTerminal-et-v${PV}"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"

IUSE="coverage crash_log sentry telemetry"

RDEPEND="dev-cpp/gflags
	dev-libs/boost
	dev-libs/libsodium
	dev-libs/protobuf"

DEPEND="${RDEPEND}"

BDEPEND="virtual/pkgconfig dev-build/cmake"

REQUIRED_USE="sentry? ( telemetry )"

src_configure() {
	local mycmakeargs=(
		-DDISABLE_VCPKG:BOOL=ON
		-DDISABLE_SENTRY=$(usex !sentry)
		-DDISABLE_TELEMETRY=$(usex !telemetry)
		-DCODE_COVERAGE=$(usex coverage)
		-DDISABLE_CRASH_LOG=$(usex !crash_log)
	)

	cmake_src_configure
}
