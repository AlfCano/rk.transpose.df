// this code was generated using the rkwarddev package.
// perhaps don't make changes here, but in the rkwarddev script instead!



function preprocess(is_preview){
	// add requirements etc. here

}

function calculate(is_preview){
	// read in variables from dialog


	// the R code to be evaluated

    // Load GUI values
    var data_frame = getValue("var_data");

    // Generate the R code to perform the transposition.
    // The base t() function returns a matrix, so we convert it back to a data.frame.
    echo("transposed.data <- as.data.frame(t(" + data_frame + "))\n");

}

function printout(is_preview){
	// printout the results
	new Header(i18n("Transpose Data Frame results")).print();

	//// save result object
	// read in saveobject variables
	var savResult = getValue("sav_result");
	var savResultActive = getValue("sav_result.active");
	var savResultParent = getValue("sav_result.parent");
	// assign object to chosen environment
	if(savResultActive) {
		echo(".GlobalEnv$" + savResult + " <- transposed.data\n");
	}

}

