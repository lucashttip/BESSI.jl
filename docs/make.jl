using BESSI
using Documenter

DocMeta.setdocmeta!(BESSI, :DocTestSetup, :(using BESSI); recursive=true)

makedocs(;
    modules=[BESSI],
    authors="Lucas A Pacheco",
    repo="https://github.com/lucashttip/BESSI.jl/blob/{commit}{path}#{line}",
    sitename="BESSI.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://lucashttip.github.io/BESSI.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/lucashttip/BESSI.jl",
    devbranch="master",
)
