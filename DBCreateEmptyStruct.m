function st = DBCreateEmptyStruct( sname, database )

% out = DBCreateEmptyStruct( structName [, database] );
%
%  Create an empty structure that mirrors that found in the CIL/Argus
%  database. This allows code to be written using a data structure that
%  is common to all, with known fields. I.e., people who don't have the
%  database at all can still share code and have some expectation that it
%  won't crash or call things by different names.
%
%  structName -- the name of the table (struct) to create.
%  database   -- the name of the database to pull this from.
%  out        -- an empty struct will all the correct fields
%
%  The standard Argus database is named 'argus', and if you omit the
%  database name, 'argus' is assumed.
%
%  The empty information is stored in .mat files in the argusDB0 directory
%  with names formed as "structs.database.mat'. For 'argus', this is
%  'structs.argus.mat'. 
%
%  Each field in the empty struct is created in a form that tells the user
%  what kind of data the database, and the other code that uses these
%  structs, expects to find. 
%
%   Field value      Expected type
%      0               scalar double
%      []              matrix
%      ''              string
%

if nargin==1
    database = 'argus';
end

% find where the data lives
s = which('DBCreateEmptyStruct');
s = s(1:max(find(s==filesep)));

fn = [ s 'structs.' database '.mat'];
xx = load(fn);

st = xx.(sname);

