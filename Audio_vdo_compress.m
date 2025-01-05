clc;
clear all;
close all;% Video Compression
videoReader = VideoReader('EEE.mp4'); % Load a video file
videoWriter = VideoWriter('E:\Huawei\Doccuments\4th Year 2nd semester\EEE 4218 Sessional Based on EEE 4217\EEE.mp4', 'MPEG-4'); % Create writer object
videoWriter.FrameRate = videoReader.FrameRate / 2; % Reduce frame rate by half
open(videoWriter);

while hasFrame(videoReader)
    frame = readFrame(videoReader);
    compressedFrame = imresize(frame, 0.5); % Reduce frame size by 50%
    writeVideo(videoWriter, compressedFrame);
end

close(videoWriter);
disp('Video compression complete. Check compressedVideo.mp4');

% Audio Compression
[audio, fs] = audioread('EEE.wav'); % Load an audio file
compressedAudio = audio(1:2:end);         % Downsample by 2 (reduces file size)
audiowrite('E:\Huawei\Doccuments\4th Year 2nd semester\EEE 4218 Sessional Based on EEE 4217\EEE.wav', compressedAudio, fs/2);
disp('Audio compression complete. Check compressedAudio.wav');