# ExAws.AutoScaling

Service module for [ex_aws](https://hex.pm/packages/ex_aws)

## Installation

The package can be installed by adding `ex_aws_auto_scaling` via `:git` to your
list of dependencies in `mix.exs` along with `:ex_aws` as well as JSON, XML and
HTTP client packages.

```elixir
def deps do
  [
    {:ex_aws, "~> 2.0"},
    {:ex_aws_ecs, git: "https://github.com/ottobar/ex_aws_auto_scaling.git"},
    {:hackney, "~> 1.15"},
    {:poison, "~> 3.1"},
    {:sweet_xml, "~> 0.6"}
  ]
end
```

## License

MIT License

Copyright (c) 2019 Don Barlow

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
