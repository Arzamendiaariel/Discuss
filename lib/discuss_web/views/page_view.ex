defmodule DiscussWeb.PageView do
  use DiscussWeb, :view

  def render(assigns) do
    ~H"""
    <section class="flex flex-col w-full justify-center items-center p">
    <h1><%= gettext "Welcome to %{name}!", name: "Phoenix" %></h1>
    <p>Peace of mind from prototype to production</p>
    </section>

    <section class="grid grid-cols-2">
    <article class="column">
    <h2>Resources</h2>
    <ul>
    <li>
    <a href="https://hexdocs.pm/phoenix/overview.html">Guides &amp; Docs</a>
    </li>
    <li>
    <a href="https://github.com/phoenixframework/phoenix">Source</a>
    </li>
    <li>
    <a
      href="https://github.com/phoenixframework/phoenix/blob/v1.6/CHANGELOG.md"
    >
      v1.6 Changelog
    </a>
    </li>
    <li>
    <a href="https://google.com">Google</a>
    </li>
    </ul>
    </article>
    <article class="column">
    <h2>Help</h2>
    <ul>
    <li>
    <a href="https://elixirforum.com/c/phoenix-forum">Forum</a>
    </li>
    <li>
    <a href="https://web.libera.chat/#elixir"
      >#elixir on Libera Chat (IRC)
    </a>
    </li>
    <li>
    <a href="https://twitter.com/elixirphoenix">Twitter @elixirphoenix</a>
    </li>
    <li>
    <a href="https://elixir-slackin.herokuapp.com/">Elixir on Slack</a>
    </li>
    <li>
    <a href="https://discord.gg/elixir">Elixir on Discord</a>
    </li>
    </ul>
    </article>
    </section>

    """
  end
end