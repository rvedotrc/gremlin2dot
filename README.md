gremlin2dot
===========

Run a Gremlin query (e.g. against AWS Neptune), and visualise the results
using GraphViz.

```
Usage: gremlin2dot [options]
    -e, --endpoint URL               The URL of the Gremlin endpoint
    -q, --query QUERY                The Gremlin query to run
        --stdin                      Read Gremlin results as JSON from standard input
        --save-json FILE             Save the JSON to FILE
        --canon FILE                 Write the results as canonical DOT to FILE
        --dot FILE                   Write the results as placed DOT to FILE
        --png FILE                   Write the results as PNG to FILE
        --svg FILE                   Write the results as SVG to FILE

gremlin2dot turns the results of a Gremlin query into a GraphViz graph, so
that they can be visualised.

It can either fetch the results as JSON from a Gremlin endpoint (--endpoint
URL --query QUERY), or it can read some results from standard input (--stdin).

The JSON can then be saved as-is (--save-json FILE).  Obviously this is most
useful with --endpoint/--query.

The graph is then generated, in one or more of the following forms:

 * as "canonical" DOT (--canon FILE)
 * as "placed" DOT (--dot FILE)
 * as PNG (--png FILE)
 * as SVG (--svg FILE)

If none of --canon/--dot/--png/--svg are specified, then "--canon /dev/stdout"
is assumed.

If no options are specified at all, then this help is shown.
```
