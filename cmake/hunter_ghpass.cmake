# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
hunter_upload_password(
    REPO "hunter-cache"
    REPO_OWNER "michael-herwig"
    USERNAME "cpp-pm-ci"
    PASSWORD "$ENV{CI_HUNTER_TOKEN}"
)
