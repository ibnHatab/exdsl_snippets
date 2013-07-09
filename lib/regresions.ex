# File    : regresions.ex

defmodule Regresions do
    @moduledoc """
Provides a Regextp examples
"""
    Regex.run %r/[aieou]/, "caterpillar"

    Regex.index %r/[aieou]/g, "caterpillar"

    Regex.scan %r/[aieou]/, "caterpillar"

    Regex.split %r/[aieou]/, "caterpillar"

    Regex.replace %r/[aieou]/, "caterpillar", "*"

end