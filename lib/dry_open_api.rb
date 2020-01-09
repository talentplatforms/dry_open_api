# Dependant libraries
require 'active_support'
require 'active_support/core_ext/hash'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/inclusion'

# dry_open_api/*
require 'dry_open_api/equatable_as_content'
require 'dry_open_api/version'
require 'dry_open_api/data_types'

# Models
require 'dry_open_api/specification'
require 'dry_open_api/info'
require 'dry_open_api/contact'
require 'dry_open_api/license'
require 'dry_open_api/server'
require 'dry_open_api/server_variable'
require 'dry_open_api/components'
require 'dry_open_api/paths'
require 'dry_open_api/path_item'
require 'dry_open_api/operation'
require 'dry_open_api/external_documentation'
require 'dry_open_api/parameter'
require 'dry_open_api/request_body'
require 'dry_open_api/media_type'
require 'dry_open_api/encoding'
require 'dry_open_api/responses'
require 'dry_open_api/response'
require 'dry_open_api/callback'
require 'dry_open_api/example'
require 'dry_open_api/link'
require 'dry_open_api/header'
require 'dry_open_api/tag'
require 'dry_open_api/reference'
require 'dry_open_api/schema'
require 'dry_open_api/discriminator'
require 'dry_open_api/xml'
require 'dry_open_api/security_schema'
require 'dry_open_api/o_auth_flows'
require 'dry_open_api/o_auth_flow'
require 'dry_open_api/security_requirement'

# Serializer
require 'dry_open_api/serializers'

# the base module ;)
module DryOpenApi
end
