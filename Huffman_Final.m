clc;
close all;
% Take the message as input
msg = input('Enter the message:', 's');

% Step 1: Calculate frequency and probability of each unique symbol
[symbols,~,idx] = unique(msg);
freq = accumarray(idx,1); 
prob = freq / length(msg); 

% Step 2: Build the Huffman tree
nodes = [];
for i = 1:length(symbols)
    nodes = [nodes, struct('symbol', symbols(i), 'freq', freq(i), 'left', [], 'right', [])];
end

while length(nodes) > 1
    [~, idx] = sort([nodes.freq]); 
    nodes = nodes(idx); % Sort nodes by frequency
    newNode = struct('symbol', strcat(nodes(1).symbol, nodes(2).symbol), ...
                     'freq', nodes(1).freq + nodes(2).freq, ...
                     'left', nodes(1), 'right', nodes(2));
    nodes(1:2) = []; 
    nodes = [nodes, newNode]; % Add the new node back into the list
end
huffmanTree = nodes;

% Step 3: Generate codewords by traversing the Huffman tree
codes = generateCodes(huffmanTree, '');

% Display codewords for individual letters
fprintf('\nCodewords for individual letters:\n');
for i = 1:length(symbols)
    if symbols(i) == ' '
        fprintf('Space : %s\n', codes.space);
    else
        fprintf('%s : %s\n',symbols(i), codes.(symbols(i)));
    end
end

% Step 4: Encode the message
encodedMsg = '';
for i = 1:length(msg)
    if msg(i) == ' '
        encodedMsg = strcat(encodedMsg, codes.space);
    else
        encodedMsg = strcat(encodedMsg, codes.(msg(i)));
    end
end
disp('Encoded Message:');
disp(encodedMsg);

% Step 5: Decode the message
decodedMsg = ''; 
node = huffmanTree;
for i = 1:length(encodedMsg)
    if encodedMsg(i) == '0'
        node = node.left;
    else
        node = node.right;
    end
    if isempty(node.left) && isempty(node.right)
        decodedMsg = strcat(decodedMsg, node.symbol);
        node = huffmanTree;  % Go back to the root
    end
end
disp('Decoded Message:');
disp(decodedMsg);

% Calculate and display entropy, average code length, and efficiency
entropy = -sum(prob .* log2(prob));
avgCodeLength = sum(prob .* cellfun(@length, struct2cell(codes)));
efficiency = (entropy / avgCodeLength) * 100;
fprintf('\nEntropy of the source: %.4f bits\n', entropy);
fprintf('Average codeword length: %.4f bits\n', avgCodeLength);
fprintf('Efficiency of Huffman coding: %.2f%%\n', efficiency);

% Local function for generating codes
function codes = generateCodes(node, code)
    codes = struct();
    if isempty(node.left) && isempty(node.right)
        % Handle special case for spaces
        if char(node.symbol) == ' '
            codes.space = code;
        else
            codes.(char(node.symbol)) = code;
        end
    else
        codes = mergeStruct(codes, generateCodes(node.left, strcat(code, '0')));
        codes = mergeStruct(codes, generateCodes(node.right, strcat(code, '1')));
    end
end

% Helper function to merge two structs
function s = mergeStruct(s1, s2)
    fields = fieldnames(s2);
    for i = 1:numel(fields)
        s1.(fields{i}) = s2.(fields{i});
    end
    s = s1;
end