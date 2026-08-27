#!/usr/bin/env bash

set -euo pipefail

package_version=$(awk -F'"' '/^let version = / { print $2; exit }' Package.swift)
podspec_version=$(awk -F'"' '/^[[:space:]]*s\.version = / { print $2; exit }' RoktSDKPlus.podspec)
source_version=$(awk -F'"' '/public static let version = / { print $2; exit }' Sources/RoktSDKPlus/RoktSDKPlus.swift)

if [[ -z "${package_version}" || -z "${podspec_version}" || -z "${source_version}" ]]; then
	echo "Unable to read every mirrored version." >&2
	exit 1
fi

if [[ "${package_version}" != "${podspec_version}" || "${package_version}" != "${source_version}" ]]; then
	printf 'Mirror versions differ: Package.swift=%s, podspec=%s, source=%s\n' \
		"${package_version}" "${podspec_version}" "${source_version}" >&2
	exit 1
fi

swift package dump-package >/dev/null
ruby -c RoktSDKPlus.podspec >/dev/null

printf 'Validated Rokt SDK+ release mirror version %s.\n' "${package_version}"
