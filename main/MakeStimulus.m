function [data1, data3, data4] = MakeStimulus(L0, dt)

%% Making the Stimulus: Experiment 1 & 2

t = dt:dt:2;
fps = 1440;
rep = 6;
pre_Hz = [144 240];
pro_Hz= [120 144 160 180 240 288];
s = 1;
pre_idx = [1 1 1 2 2 2];
pro_idx = [4 5 6 1 2 3];
idxs = [pre_idx' pro_idx'];
n = 1;
for i = 1:length(pre_Hz)
    Hz1 = pre_Hz(i);
    for j = 1:length(pro_Hz)
        Hz2 = pro_Hz(j);
        % Control TTP
        stim_L0_control = L0*ones( 1, length(t) );
        % Standard TTP
        stim_sine0{n,:} = L0*[zeros(1440,1); repmat(repelem([1;-1],1440/Hz1), Hz1/4,1); repmat(repelem([1;-1],1440/Hz2), Hz2/4,1)]'.*[zeros(1,1440) linspace(0,1,2*127) ones(1,1440 - 4*127) linspace(1,0,2*127)]; 
        
        if s >= 7
            s = 6;
        end
        if [i j] == idxs(s,:)
            switch s
                case 1
                    insert_frames = repmat(repelem([1;-1],1440/160),rep,1);
                case 2
                    insert_frames = [repmat(repelem([1;-1],1440/160),rep,1); repmat(repelem([1;-1],1440/180),rep,1)];
                case 3
                    insert_frames = [repmat(repelem([1;-1],1440/160),rep,1); repmat(repelem([1;-1],1440/180),rep,1); repmat(repelem([1;-1],1440/240),rep,1)];
                case 4
                    insert_frames = [repmat(repelem([1;-1],1440/180),rep,1); repmat(repelem([1;-1],1440/160),rep,1); repmat(repelem([1;-1],1440/144),rep,1)];
                case 5
                    insert_frames = [repmat(repelem([1;-1],1440/180),rep,1); repmat(repelem([1;-1],1440/160),rep,1)];
                case 6
                    insert_frames = repmat(repelem([1;-1],1440/180),rep,1);
            end
            s = s+1;
            % 1. Freq Oscillation
            lengthi = length(insert_frames);
            stim_sine1{n,:} = L0*[zeros(1440,1); repmat(repelem([1;-1],1440/Hz1), Hz1/4,1); insert_frames; repmat(repelem([1;-1],1440/Hz2), Hz2/4,1)]'.*[zeros(1,1440) linspace(0,1,2*127) ones(1,1440+ lengthi - 4*127) linspace(1,0,2*127)]; 
            stim_L01{n} = L0*ones( 1, length(t)+lengthi );
        else
        % 2. Contrast Reduction same amount of insert_fram
            stim_sine1{n,:} = stim_sine0{n,:};
            stim_L01{n} = L0*ones( 1, length(t));
        end
        % 3. Freq + Contrast
        n = n+1;
    end
end

n = n-1;
stim_sine = cat(2, stim_sine0, stim_sine1);
data1.stim_sine = stim_sine;

%% Make the Stimulus: Experiment 3

for rep = 0:13
    idx = rep + 1;
    Hz1 = 144;
    Hz2 = 288;
    if mod(rep,2) == 0
        insert_frames = [repmat(repelem([1;-1],1440/160),rep/2,1); repmat(repelem([1;-1],1440/180),rep/2,1); repmat(repelem([1;-1],1440/240),rep/2,1)];
        lengthi = length(insert_frames);
        stim_sine2{idx,:} = L0*[zeros(1440,1); repmat(repelem([1;-1],1440/Hz1), Hz1/4,1); insert_frames; repmat(repelem([1;-1],1440/Hz2), Hz2/4,1)]'.*[zeros(1,1440) linspace(0,1,2*127) ones(1,1440+ lengthi - 4*127) linspace(1,0,2*127)]; 
    elseif rep == 1
        insert_frames = [ones(1440/160,1); -1*ones(1440/180,1); ones(1440/240,1)];
        lengthi = length(insert_frames);
        stim_sine2{idx,:} = L0*[zeros(1440,1); repmat(repelem([1;-1],1440/Hz1), Hz1/4,1); insert_frames; -1*repmat(repelem([1;-1],1440/Hz2), Hz2/4,1)]'.*[zeros(1,1440) linspace(0,1,2*127) ones(1,1440+ lengthi - 4*127) linspace(1,0,2*127)]; 
    else
        insert_frames = [repmat(repelem([1;-1],1440/160),(rep-1)/2,1); ones(1440/160,1); -1*ones(1440/180,1); repmat(repelem([1;-1],1440/180),(rep-1)/2,1); repmat(repelem([1;-1],1440/240),(rep-1)/2,1); ones(1440/240,1)];
        lengthi = length(insert_frames);
        stim_sine2{idx,:} = L0*[zeros(1440,1); repmat(repelem([1;-1],1440/Hz1), Hz1/4,1); insert_frames; -1*repmat(repelem([1;-1],1440/Hz2), Hz2/4,1)]'.*[zeros(1,1440) linspace(0,1,2*127) ones(1,1440+ lengthi - 4*127) linspace(1,0,2*127)]; 
    end
    stim_L02{idx} = L0*ones( 1, length(t)+lengthi );

end
data3.stim_sine = stim_sine2;

%% Make the Stimulus in Exp 4
Hz1 = 80;
Hz2 = 240;
inter_Hz = [96 120 160];
for rep = 0:8
    idx = rep + 1;
    if mod(rep,2) == 0
        insert_frames = [repmat(repelem([1;-1],fps/inter_Hz(1)),rep/2,1); repmat(repelem([1;-1],fps/inter_Hz(2)),rep/2,1); repmat(repelem([1;-1],fps/inter_Hz(3)),rep/2,1)];
        lengthi = length(insert_frames);
        stim_sine3{idx,:} = L0*[zeros(fps,1); repmat(repelem([1;-1],fps/Hz1), Hz1/4,1); insert_frames; repmat(repelem([1;-1],fps/Hz2), Hz2/4,1)]'.*[zeros(1,fps) linspace(0,1,2*48) ones(1,fps + lengthi - 4*48) linspace(1,0,2*48)]; 
    elseif rep == 1
        insert_frames = [ones(fps/inter_Hz(1),1); -1*ones(fps/inter_Hz(2),1); ones(fps/inter_Hz(3),1)];
        lengthi = length(insert_frames);
        stim_sine3{idx,:} = L0*[zeros(fps,1); repmat(repelem([1;-1],fps/Hz1), Hz1/4,1); insert_frames; -1*repmat(repelem([1;-1],fps/Hz2), Hz2/4,1)]'.*[zeros(1,fps) linspace(0,1,2*48) ones(1,fps + lengthi - 4*48) linspace(1,0,2*48)]; 
    else
        insert_frames = [repmat(repelem([1;-1],fps/inter_Hz(1)),(rep-1)/2,1); ones(fps/inter_Hz(1),1); -1*ones(fps/inter_Hz(2),1); repmat(repelem([1;-1],fps/inter_Hz(2)),(rep-1)/2,1); repmat(repelem([1;-1],fps/inter_Hz(3)),(rep-1)/2,1); ones(fps/inter_Hz(3),1)];
        lengthi = length(insert_frames);
        stim_sine3{idx,:} = L0*[zeros(fps,1); repmat(repelem([1;-1],fps/Hz1), Hz1/4,1); insert_frames; -1*repmat(repelem([1;-1],fps/Hz2), Hz2/4,1)]'.*[zeros(1,fps) linspace(0,1,2*48) ones(1,fps + lengthi - 4*48) linspace(1,0,2*48)]; 
    end
    stim_L02{idx} = L0*ones( 1, length(t)+lengthi );

end

data4.stim_sine = stim_sine3;

