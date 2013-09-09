% initial queues in CTM model
function ini_4int_queues(x0)

x = zeros(1,24);
x(1:16) = x0(:);
ctm_start(x,[1 1 1 1]);
