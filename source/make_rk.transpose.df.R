local({
# Golden Rule 1: This R script is the single source of truth.
# It programmatically defines and generates all plugin files.

# --- PRE-FLIGHT CHECK ---
# Stop if the user is accidentally running this inside an existing plugin folder

# Require "rkwarddev"
require(rkwarddev)

# --- Plugin Metadata and Author Information ---
# Golden Rule 5: Correct syntax for author and metadata node.
about_author <- person(
  given = "Alfonso",
  family = "Cano Robles",
  email = "alfonso.cano@correo.buap.mx",
  role = c("aut", "cre")
)

# A valid R package name (letters, numbers, periods only)
plugin_name <- "rk.transpose.df"

about_plugin_list <- list(
  name = plugin_name,
  author = about_author,
  about = list(
    desc = "An RKWard plugin to transpose a data frame, turning rows into columns and columns into rows.",
    version = "0.01.2",
    date = format(Sys.Date(), "%Y-%m-%d"),
    url = "https://github.com/AlfCano/rk.transpose.df",
    license = "GPL",
    dependencies = "R (>= 3.00)"
  )
)

about_node <- rk.XML.about(
  name = about_plugin_list$name,
  author = about_plugin_list$author,
  about = about_plugin_list$about
)


# --- Help File Definition (User-friendly R list) ---
# Golden Rule 2: Define help content in a simple list first.
plugin_help <- list(
  title = "Transpose Data Frame",
  summary = "Transposes a data frame, turning its rows into columns and its columns into rows.",
  usage = "Select a data frame to transpose from the list of available R objects.",
  sections = list(
    list(
      title = "Usage",
      text = "<p>This plugin takes a data frame as input and uses the base R <code>t()</code> function to transpose it. The result of <code>t()</code> is a matrix, which is then converted back into a data frame for convenience.</p><p>Note that if the original data frame had columns of different types (e.g., numeric, character), all columns in the resulting transposed data frame will be of type character.</p>"
    ),
    list(
      title = "Output",
      text = "<p>A new data frame is created where the rows are the columns of the input data frame, and the columns are the rows of the input data frame.</p>"
    )
  )
)

# --- Help File Generation (Adhering to Golden Rule 2) ---
rkh_title <- rk.rkh.title(text = plugin_help$title)
rkh_summary <- rk.rkh.summary(text = plugin_help$summary)
rkh_usage <- rk.rkh.usage(text = plugin_help$usage)
rkh_sections <- lapply(plugin_help$sections, function(sec) {
  rk.rkh.section(title = sec$title, text = sec$text)
})
transpose_help_rkh <- rk.rkh.doc(
  title = rkh_title,
  summary = rkh_summary,
  usage = rkh_usage,
  sections = rkh_sections
)


# --- UI Element Definition (XML) ---
# Golden Rule 3: The Inflexible Two-Part UI for Variable Selection.
# Part 1: The source list of available data.frames.
data_selector <- rk.XML.varselector(label = "Select data object")
attr(data_selector, "classes") <- "data.frame"

# Part 2: The destination box that shows the selection. This is what we get the value from.
data_slot <- rk.XML.varslot(
  label = "Data frame to transpose (required)",
  source = data_selector,
  id.name = "var_data"
)
attr(data_slot, "required") <- "1" # Golden Rule 5: Use attr() for optional arguments.

selection_row <- rk.XML.row(data_selector, data_slot)

# Golden Rule 4: The 'saveobj' component.
save_results <- rk.XML.saveobj(
  label = "Save transposed data to object",
  chk = TRUE,
  checkable = TRUE,
  initial = "transposed.data", # This name MUST match the object in js_calculate
  id.name = "sav_result"
)

# Assemble the final UI dialog
dialog_col <- rk.XML.col(selection_row, save_results)
transpose_dialog <- rk.XML.dialog(label = "Transpose Data Frame", child = dialog_col)


# --- JavaScript Logic ---
# Golden Rule 6: JavaScript generates R code via echo().
# Golden Rule 4: 'calculate' creates an object named 'transposed.data'.
js_calculate <- '
    // Load GUI values
    var data_frame = getValue("var_data");

    // Generate the R code to perform the transposition.
    // The base t() function returns a matrix, so we convert it back to a data.frame.
    echo("transposed.data <- as.data.frame(t(" + data_frame + "))\\n");
'

# 'printout' displays the 'transposed.data' object.


# --- Plugin Skeleton Generation ---
rk.plugin.skeleton(
  about = about_node,
  pluginmap = list(name = "Transpose Data Frame", hierarchy = list("data")),
  xml = list(dialog = transpose_dialog),
  js = list(calculate = js_calculate, printout = ""),
  rkh = list(help = transpose_help_rkh),
  path = ".",
  overwrite = TRUE,
  create = c("pmap", "xml", "js", "desc", "rkh"),
  load = TRUE,
  show = TRUE
)

# --- Final Instructions ---
message(
  paste0('Plugin \'', plugin_name, '\' created successfully.\n\n'),
  'NEXT STEPS:\n',
  '1. Open RKWard.\n',
  '2. In the R console, run:\n',
  paste0('   rk.updatePluginMessages("', plugin_name, '")\n'),
  '3. Then, to install the plugin in your RKWard session, run:\n',
  paste0('   rk.load.plugin("', plugin_name, '")\n'),
  '4. Or, for a permanent installation (requires devtools), run:\n',
  paste0('   # Make sure your working directory is the parent of the \'', plugin_name, '\' folder\n'),
  paste0('   # devtools::install("', plugin_name, '")')
)
})
