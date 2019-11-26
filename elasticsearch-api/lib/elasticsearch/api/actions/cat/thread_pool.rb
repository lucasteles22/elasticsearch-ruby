# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Cat
      module Actions
        # Returns cluster-wide thread pool statistics per node.
        # By default the active, queue and rejected statistics are returned for all thread pools.

        #
        # @option arguments [List] :thread_pool_patterns A comma-separated list of regular-expressions to filter the thread pools in the output

        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/cat-thread-pool.html
        #
        def thread_pool(arguments = {})
          arguments = arguments.clone

          _thread_pool_patterns = arguments.delete(:thread_pool_patterns)

          method = HTTP_GET
          path   = if _thread_pool_patterns
                     "_cat/thread_pool/#{Utils.__listify(_thread_pool_patterns)}"
                   else
                     "_cat/thread_pool"
  end
          params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

          body = nil

          perform_request(method, path, params, body).body
        end

        # Register this action with its valid params when the module is loaded.
        #
        # @since 6.2.0
        ParamsRegistry.register(:thread_pool, [
          :format,
          :size,
          :local,
          :master_timeout,
          :h,
          :help,
          :s,
          :v
        ].freeze)
  end
      end
end
end
