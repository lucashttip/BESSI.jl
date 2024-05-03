using BeSSI
using Documenter

DocMeta.setdocmeta!(BeSSI, :DocTestSetup, :(using BeSSI); recursive=true)

makedocs(;
    modules=[BeSSI],
    authors="Lucas A Pacheco",
    repo="https://github.com/lucashttip/BeSSI.jl/blob/{commit}{path}#{line}",
    sitename="BeSSI.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://lucashttip.github.io/BeSSI.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/lucashttip/BeSSI.jl",
    devbranch="master",
)
