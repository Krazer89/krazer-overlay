# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Show interesting new systemd journal entries since last run"
HOMEPAGE="https://github.com/twaugh/journal-brief"
SRC_URI="https://github.com/twaugh/journal-brief/archive/refs/tags/v${PV}.tar.gz -> ${PV}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/python-systemd[${PYTHON_USEDEP}]
"

#BDEPEND="
#	test? (
#		dev/python/pytest[${PYTHON_USEDEP}]
#		dev-python/flexmock[${PYTHON_USEDEP}]
#		dev-python/pytest-mock[${PYTHON_USEDEP}]
#	)
#"
