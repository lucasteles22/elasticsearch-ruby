# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Cat
      module Actions

        # Display shard allocation across nodes
        #
        # @example Display information for all indices
        #
        #     puts client.cat.shards
        #
        # @example Display information for a specific index
        #
        #     puts client.cat.shards index: 'index-a'
        #
        # @example Display information for a list of indices
        #
        #     puts client.cat.shards index: ['index-a', 'index-b']
        #
        # @example Display header names in the output
        #
        #     puts client.cat.shards v: true
        #
        # @example Display shard size in choice of units
        #
        #     puts client.cat.shards bytes: 'b'
        #
        # @example Display only specific columns in the output (see the `help` parameter)
        #
        #     puts client.cat.shards h: ['node', 'index', 'shard', 'prirep', 'docs', 'store', 'merges.total']
        #
        # @example Display only specific columns in the output, using the short names
        #
        #     puts client.cat.shards h: 'n,i,s,p,d,sto,mt'
        #
        # @example Return the information as Ruby objects
        #
        #     client.cat.shards format: 'json'
        #
        # @option arguments [List] :index A comma-separated list of index names to limit the returned information
        # @option arguments [String] :bytes The unit in which to display byte values (options: b, k, m, g)
        # @option arguments [List] :h Comma-separated list of column names to display -- see the `help` argument
        # @option arguments [Boolean] :v Display column headers as part of the output
        # @option arguments [List] :s Comma-separated list of column names or column aliases to sort by
        # @option arguments [String] :format The output format. Options: 'text', 'json'; default: 'text'
        # @option arguments [Boolean] :help Return information about headers
        # @option arguments [Boolean] :local Return local information, do not retrieve the state from master node
        #                                    (default: false)
        # @option arguments [Time] :master_timeout Explicit operation timeout for connection to master node
        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/cat-shards.html
        #
        def shards(arguments={})
          index = arguments.delete(:index)
          method = HTTP_GET
          path   = Utils.__pathify '_cat/shards', Utils.__listify(index)

          params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)
          params[:h] = Utils.__listify(params[:h]) if params[:h]

          body   = nil

          perform_request(method, path, params, body).body
        end

        # Register this action with its valid params when the module is loaded.
        #
        # @since 6.1.1
        ParamsRegistry.register(:shards, [
            :format,
            :bytes,
            :local,
            :master_timeout,
            :h,
            :help,
            :s,
            :v ].freeze)
      end
    end
  end
end
