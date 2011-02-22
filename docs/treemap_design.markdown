# Config and data files

The treemap is configured by a config file. This file can be a variety of formats, we are starting with YAML.       

# Startup procedure

1) Front-end should be in "loading" state.
2) Validate that the config file is correct. To be correct, must specify a datafile, levels, and size and color fields.
    If TRUE: Load data
    If FALSE: Change to "error" state, display relevant error message showing what is missing.
3) Load the data
4) Validate the data against the config file. All references to fields in levels, colors, sizes should exist in the data schema.
    If TRUE: Generate treemap and display
    If FALSE: Change to "error" state, display relevant error message showing that certain fields couldn't be found in the data.
5) Display treemap


# States

The front-end has the following states:

 * loading: During startup
 * error: Config or data file problems
 * treemap: Showing the treemap. The treemap skin may have additional states.

  