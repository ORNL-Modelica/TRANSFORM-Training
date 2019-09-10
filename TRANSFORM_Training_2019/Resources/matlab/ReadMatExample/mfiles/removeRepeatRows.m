function [dataNew] = removeRepeatRows(data,col,col_del)
% Remove repeated rows based on the values in the column 'col' in order
% to use tools such as spline which require a monotonically increasing data
% for the independent variable.

% data => MxN matrix or 1-D array
% col => column to check for repeated row values
% col_del => =true to delete 'col' in dataNew

% Find unique rows based on specified column
[~, i, ~] = unique(data(1:end,col));

% Extract the filtered data
dataNew =  data(i,:);

% Remove sorted row based on input
if col_del
  dataNew(:,col) = [];
end
