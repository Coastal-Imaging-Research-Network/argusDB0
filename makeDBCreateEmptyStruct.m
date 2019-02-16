function foo = makeDBCreateEmptyStruct( )

% makeDBCreateEmptyStruct( )  -- create empty structs that match tables in the 
%  database current in use. E.g. 'argus'. You must have a current
%  connection to and be using that database.
%
%  E.g., makeDBCreateEmptyStruct( );
%
%  This scans the current database for all tables, calls the real
%  database-connected DBCreateEmptyStruct to create empty structs for
%  each table, and saves them in a .mat file. These can then be accessed
%  by the non-database DBCreateEmptyStruct.
%
%  NOTE: you must have a real database managed by argusDB to run this
%   -- succesfully.
%

% "hidden" database info managed by DBConnect
global DBinfo
global DBconn

% no DBinfo.server yet, you haven't connected
if( ~isfield(DBinfo,'server') )
    error('Must connect to a database server first!');
end

% and no server in that table, so ditto
if( isempty('DBinfo.server') )
    error('Must connect to a database server first!');
end

% 'db' is used only to create the file name later
db = DBinfo.database;

% lets find the real DBCreateEmptyStruct
s = which('DBCreateEmptyStruct','-ALL');
if( length(s) == 1 )
    error('You do not have a real DBCreateEmptyStruct?');
end

% argusDB0 has one which will be returned first in the 'which', so 
% assume the real one is in slot 2.
s = s{2};

% we must now go to and create a function handle to be able to call
% the "real" DBCreateEmptyStruct for each table we know about
here = cd;
[pth] = fileparts(s);
cd(pth);
fh = str2func('DBCreateEmptyStruct');
cd(here);

% DBconn contains DB info for the database, including all the table names!
% It's part of the management through DBConnect to speed up access later

for ii=1:length(DBconn.tables) 

    % here we call the "real" DBCreateEmptyStruct with the table name
    t = feval( fh, DBconn.tables{ii});
    % and save the empty table in a temp struct called, of course, foo
    foo.(DBconn.tables{ii}) = t;

end

% we want to store a time of creation, too. 
foo.creation_date_ = datestr(now);

% create a standard file name for this data
fn = ['structs.' db '.mat'];

% and save it as the fields of the struct
save( fn, '-struct', 'foo' );

% now our ersatz DBCreateEmptyStruct can load the empty structs and return
% the one being requested.


