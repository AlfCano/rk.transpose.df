
# RKWard Plugin: Transpose Data Frame (`rk.transpose.df`)

![Version](https://img.shields.io/badge/Version-0.01.2-blue.svg)
![License](https://img.shields.io/badge/License-GPL--3-green.svg)

> A simple RKWard plugin to transpose a data frame, converting rows to columns and columns to rows.

## Overview

This plugin provides a straightforward way to transpose a data frame within the RKWard graphical user interface. It serves as a simple front-end for R's base `t()` function, with the added convenience of converting the resulting matrix back into a data frame.

This is a fundamental data reshaping task, useful for situations where data is recorded in a format that needs to be "flipped" for analysis or plotting (e.g., samples are in columns but need to be in rows).

## Features

-   Selects any data frame from the current R workspace.
-   Transposes the data, swapping rows and columns.
-   Converts the transposed matrix back into a `data.frame` for easier use.
-   Saves the result to a new R object in the workspace.

### Important Note on Data Types

When a data frame with columns of different types (e.g., `numeric`, `character`, `factor`) is transposed, the resulting data frame will have all its columns converted to the `character` type. This is a consequence of the underlying matrix structure created by R's `t()` function, as matrices can only hold a single data type.

## Installation

### With `devtools` (Recommended)
You can install this plugin directly from its repository using the `devtools` package in R.

```
local({
## Preparar
require(devtools)
## Computar
  install_github(
    repo="AlfCano/rk.transpose.df"
  )
## Imprimir el resultado
rk.header ("Resultados de Instalar desde git")
})
```

### Manual Installation
1.  Download this repository as a `.zip` file.
2.  In RKWard, go to **Settings -> R Packages -> Install package(s) from local zip file(s)** and select the downloaded file.
3.  Restart RKWard. The plugin will be available in the `Data` menu.

## Usage

1.  Once installed, navigate to the **Data -> Transpose Data Frame** menu in RKWard.
2.  In the dialog window, select the data frame you wish to transpose from the list of available R objects.
3.  Specify a name for the new, transposed data frame object.
4.  Click **Submit**.

## Output

-   The primary output is a **new data frame object** saved to your R workspace with the name you specified.
-   A confirmation message and a preview of the first few rows of the transposed data will be shown in the RKWard Output window.

## License

This plugin is licensed under the GPL (>= 3).


