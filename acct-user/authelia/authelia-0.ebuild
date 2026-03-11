# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for authelia"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( ${PN} )
ACCT_USER_HOME="/var/lib/authelia"
ACCT_USER_SHELL="/sbin/nologin"

acct-user_add_deps