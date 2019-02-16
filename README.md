# argusDB0
Create the basic structures for Argus/CIL/CIRN data processing

Moving, storing, and processing data for many functions within the CIRN repositories depends on a known format for that data. For example, what things can we know about a camera and what do we call those things? 

If you use the Argus database, then this structure is imposed by the database server (currently MySQL). When you ask the database about a camera, you get a fixed format response. When you store data about a camera, the database expects certain things. 

And, of course, the code that uses the camera data looks for certain things with specific names. For example, the location of a camera is called 'x', 'y', and 'z'. In a multi-camera station, the camera number is 'cameraNumber'. Those are all numbers. The ID for the camera (a unique identifier) is called 'id', and is a string. If you want to know the model of camera, that is a string called 'modelID' which matches up with the 'id' field in the cameraModel table.

If you don't use the database you might create code using non-standard field names, which makes it very hard to share your code with others who have called the same thing something else. 

The function 'DBCreateEmptyStruct' was originally developed in the database environment to return an empty structure with the appropriate field names. This allowed users a nearly self-documenting method of identifying database fields for each table they might use. The 'DBCreateEmptyStruct' function in this repository (argusDB0, which is intended to mean "no Argus DB") refers to stored empty structures in Matlab .mat files. This data is created by 'makeDBCreateEmptyStruct', which was run on the current and soon-to-be-current Argus database maintained by the CIL.

If you are using your own special tables in a database accessed via the DBConnect/etc. functions of the CIL argusDB code, you can create your own empty structure data using makeDBCreateEmptyStruct, too. 



