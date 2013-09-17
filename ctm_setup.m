% add paths for ctm_matlab
mpath = mfilename('fullpath');
temp = strfind( mpath, filesep );
mpath( temp(end) : end ) = [];
addpaths = { 'scripts', 'examples' };
for k = 1 : length(addpaths),
    addpath([ mpath, filesep, addpaths{k} ]);
end
addpath(mpath);
clear mpath temp addpaths k;