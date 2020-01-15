# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Indices
      module Actions
        # Updates the index mappings.

        #
        # @option arguments [List] :index A comma-separated list of index names the mapping should be added to (supports wildcards); use `_all` or omit to add the mapping on all indices.
        # @option arguments [Hash] :body The mapping definition (*Required*)

        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/indices-put-mapping.html
        #
        def put_mapping(arguments = {})
          raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]
          raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]

          arguments = arguments.clone

          _index = arguments.delete(:index)

          method = HTTP_PUT
          path   = "#{Utils.__listify(_index)}/_mapping"
          params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

          body = arguments[:body]

          perform_request(method, path, params, body).body
        end

        # Register this action with its valid params when the module is loaded.
        #
        # @since 6.2.0
        ParamsRegistry.register(:put_mapping, [
          :timeout,
          :master_timeout,
          :ignore_unavailable,
          :allow_no_indices,
          :expand_wildcards
        ].freeze)
  end
      end
end
end
