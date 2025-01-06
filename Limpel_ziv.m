clc; clear;
% Original text data
%This is an example of Lempel-Ziv compression. Lempel-Ziv is efficient! This is efficient.
text = input('Enter the message: ', 's');
disp(['Original Text: ', text]);

% Lempel-Ziv Compression
words = split(lower(text), {' ', '.', '!', '?', ','}); % Split and convert to lowercase
words = words(~cellfun('isempty', words)); % Remove empty cells
[unique_words, ~, indices] = unique(words, 'stable'); % Unique dictionary and word indices

dict_size = numel(unique_words);
original_size = numel(text) * 7; % ASCII size in bits
compressed_size_lz = numel(indices) * ceil(log2(dict_size)); % Bits for indices
compression_ratio_lz = original_size / compressed_size_lz;

disp('--- Lempel-Ziv Compression ---');
disp(['Dictionary Size: ', num2str(dict_size), ' words']);
disp(['Compressed Indices: ', mat2str(indices')]); % Display compressed indices
disp(['Compressed Size: ', num2str(compressed_size_lz), ' bits']);
disp(['Compression Ratio: ', num2str(compression_ratio_lz)]);

% Huffman Coding
% Calculate the frequency of each symbol in the message
freq = histc(text, unique(text)) / length(text);
% Create Huffman dictionary
dict = huffmandict(num2cell(unique(text)), freq);
% Encode the message
encoded = huffmanenco(text, dict);
compressed_size_huffman = numel(encoded); % Encoded size in bits
compression_ratio_huffman = original_size / compressed_size_huffman;
disp('--- Huffman Compression ---');
disp(['Compressed Size: ', num2str(compressed_size_huffman), ' bits']);
disp(['Compression Ratio: ', num2str(compression_ratio_huffman)]);

% Efficiency Comparison
efficiency_ratio = compression_ratio_lz / compression_ratio_huffman;
disp(['Efficiency Ratio (LZ vs Huffman): ', num2str(efficiency_ratio)]);

if compression_ratio_lz > compression_ratio_huffman
    disp('Lempel-Ziv is more efficient.');
else
    disp('Huffman Coding is more efficient.');
end