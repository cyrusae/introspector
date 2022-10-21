# Contributing to introspector

This outlines how to propose a change to introspector. It is based on the tidyverse default scripts but has been modified somewhat and will likely change in the future. Above all, when in doubt, [try asking questions!](https://github.com/cyrusae/introspector/issues/)

## Fixing typos

You can fix typos, spelling mistakes, or grammatical errors in the documentation directly using the GitHub web interface, as long as the changes are made in the _source_ file. 
This generally means you'll need to edit [roxygen2 comments](https://roxygen2.r-lib.org/articles/roxygen2.html) in an `.R`, not a `.Rd` file. 
You can find the `.R` file that generates the `.Rd` by reading the comment in the first line.

## Bigger changes

If you want to make a bigger change, it's a good idea to file an issue explaining your intent. The "team" is currently very small (one person, at time of writing!), so if you have a proposal you're feeling enthusiastic about, you're welcome to start working on it without explicit permission. Any kind of good-faith contributions or suggestions are welcome, as long as you're willing to accept the possibility of getting changes requested or an out-of-scope proposal being turned down. 

If you’ve found a bug, please file an issue that illustrates the bug with a minimal 
[reprex](https://www.tidyverse.org/help/#reprex) (this will also help you write a unit test, if needed).

### Pull request process

> **Note:** Except for *[comments in brackets]*, the recommendations in this section come from the *tidyverse* by way of `usethis`. They are currently reproduced as originally written--that team has much more practice here than I do! 

*   Fork the package and clone onto your computer. If you haven't done this before, we recommend using `usethis::create_from_github("cyrusae/introspector", fork = TRUE)`.

*   Install all development dependencies with `devtools::install_dev_deps()`, and then make sure the package passes R CMD check by running `devtools::check()`. 
    If R CMD check doesn't pass cleanly, it's a good idea to ask for help before continuing. 
*   Create a Git branch for your pull request (PR). We recommend using `usethis::pr_init("brief-description-of-change")`.

*   Make your changes, commit to git, and then create a PR by running `usethis::pr_push()`, and following the prompts in your browser.
    The title of your PR should briefly describe the change.
    The body of your PR should contain `Fixes #issue-number`.

*  For user-facing changes, add a bullet to the top of `NEWS.md` (i.e. just below the first header). Follow the style described in <https://style.tidyverse.org/news.html>.

### Code style

*   *[When in doubt,]* New code should follow the tidyverse [style guide](https://style.tidyverse.org). 
    You can use the [styler](https://CRAN.R-project.org/package=styler) package to apply these styles, but please don't restyle code that has nothing to do with your PR.  

*  We use [roxygen2](https://cran.r-project.org/package=roxygen2), with [Markdown syntax](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd-formatting.html), for documentation.  

*  We use [testthat](https://cran.r-project.org/package=testthat) for unit tests. 
   Contributions with test cases included are easier to accept.  

### What about contributor conduct?

*[The problem with the author taking the question of a Code of Conduct seriously is that (at the point where I'm writing this note, along with the very first iteration of the package-in-progress itself) I need to make sure I mean what I'm asking people to comply with. That document will be linked here when finalized. As for a zeroth law: do not make me regret the existence of that window.]*