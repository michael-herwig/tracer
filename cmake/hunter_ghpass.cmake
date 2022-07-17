# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
hunter_upload_password(
    REPO "hunter-cache"
    REPO_OWNER "michael-herwig"
    USERNAME "ci-hunter"
    PASSWORD "$ENV{CI_HUNTER_TOKEN}"
)
