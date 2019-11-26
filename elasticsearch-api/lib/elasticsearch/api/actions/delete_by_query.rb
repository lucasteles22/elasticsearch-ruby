# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Actions
      # Deletes documents matching the provided query.

      #
      # @option arguments [List] :index A comma-separated list of index names to search; use `_all` or empty string to perform the operation on all indices
      # @option arguments [Hash] :body The search definition using the Query DSL (*Required*)

      #
      # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/docs-delete-by-query.html
      #
      def delete_by_query(arguments = {})
        raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]
        raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]

        arguments = arguments.clone

        _index = arguments.delete(:index)

        method = HTTP_POST
        path   = "#{Utils.__listify(_index)}/_delete_by_query"
        params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

        body = arguments[:body]

        perform_request(method, path, params, body).body
      end

      # Register this action with its valid params when the module is loaded.
      #
      # @since 6.2.0
      ParamsRegistry.register(:delete_by_query, [
        :analyzer,
        :analyze_wildcard,
        :default_operator,
        :df,
        :from,
        :ignore_unavailable,
        :allow_no_indices,
        :conflicts,
        :expand_wildcards,
        :lenient,
        :preference,
        :q,
        :routing,
        :scroll,
        :search_type,
        :search_timeout,
        :max_docs,
        :sort,
        :_source,
        :_source_excludes,
        :_source_includes,
        :terminate_after,
        :stats,
        :version,
        :request_cache,
        :refresh,
        :timeout,
        :wait_for_active_shards,
        :scroll_size,
        :wait_for_completion,
        :requests_per_second,
        :slices
      ].freeze)
    end
  end
end
