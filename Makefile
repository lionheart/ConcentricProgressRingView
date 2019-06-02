# Copyright 2015-2018 Lionheart Software LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Usage: make VERSION=0.1.2

PODFILE := $(shell find . -name "*.podspec" -depth 1)
DIRECTORY := $(shell basename $(PODFILE) .podspec)
AWS_S3_BUCKET_NAME := lionheart-opensource
AWS_S3_REGION := us-east-2
AWS_CF_DISTRIBUTION_ID := E33XE7TKGUV1ZD

all: publish

version_provided:
	test -n "$(VERSION)"

podspec_found:
	test -n "$(PODFILE)"

quicklint:
	bundle exec pod spec lint --quick

replace_text: podspec_found version_provided
	sed -i "" "s/\(s.version[ ]*=[ ]\).*/\1 \"$(VERSION)\"/g" $(PODFILE)
	sed -i "" "s/tree\/[\.0-9]*/tree\/$(VERSION)/g" .jazzy.yaml

generate_docs: replace_text
	bundle exec jazzy
	git add docs/
	git add .jazzy.yaml
	-git commit -m "documentation update"
	sync_directory_to_s3 "$(AWS_S3_REGION)" "$(AWS_S3_BUCKET_NAME)" "$(AWS_CF_DISTRIBUTION_ID)" "docs" "$(DIRECTORY)/"

tag: quicklint generate_docs
	git add .
	# - ignores errors in this command
	-git commit -m "bump version to $(VERSION)"
	# Delete tag if already exists
	-git tag -d $(VERSION)
	-git push origin master :$(VERSION)
	git tag $(VERSION)
	git push origin master
	git push --tags

publish: tag
	bundle exec pod trunk push --allow-warnings

