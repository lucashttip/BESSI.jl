using Bemto
using Documenter

DocMeta.setdocmeta!(Bemto, :DocTestSetup, :(using Bemto); recursive=true)

makedocs(;
    modules=[Bemto],
    authors="Lucas A Pacheco",
    repo="https://github.com/lucashttip/Bemto.jl/blob/{commit}{path}#{line}",
    sitename="Bemto.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://lucashttip.github.io/Bemto.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/lucashttip/Bemto.jl",
    devbranch="master",
)
