%% Effectors
% 0 eye
% 1 free gaze reach
% 2 joint movement eye and hand
% 3 dissociated saccade
% 4 dissociated reach
% 5 Poffenberger task (MRI buttons)
% 6 free gaze reach with initial eye fixation

%% Task types
% 1 fixation
% 2 direct saccade
% 3 memory saccade

%% Task settings

if ~exist('dyn','var') || dyn.trialNumber == 1
    
%     esperimentazione        = {'calibration'};    
%     
%     esperimentazione        = {'choice target-distractor memory saccades'};
%     esperimentazione        = {'choice target-distractor direct saccades'};
%     esperimentazione        = {'choice distractor-distractor memory saccades'};
%     esperimentazione        = {'choice distractor-distractor direct saccades'};
%     esperimentazione        = {'choice target-target memory saccades'};
%     esperimentazione        = {'choice target-target direct saccades'};
%     
%     esperimentazione        = {'instructed memory saccades'};
%     esperimentazione        = {'instructed distractor memory saccades'};
%     esperimentazione        = {'instructed direct saccades'};
%     esperimentazione        = {'instructed distractor direct saccades'};
%     
%     esperimentazione        = {'instructed direct saccades','choice target-distractor direct saccades'};
    esperimentazione        = {'choice target-distractor direct saccades','choice distractor-distractor direct saccades'};
%
%     esperimentazione        = {'choice target-distractor memory saccades','choice distractor-distractor memory saccades'};
%     esperimentazione        = {'instructed memory saccades','choice target-distractor memory saccades'};

% esperimentazione        = {'instructed memory saccades','instructed distractor memory saccades','choice target-distractor memory saccades','choice distractor-distractor memory saccades'};
% esperimentazione        = {'instructed direct saccades','instructed distractor direct saccades','choice target-distractor direct saccades','choice distractor-distractor direct saccades'};
% esperimentazione        = {'instructed direct saccades','instructed distractor direct saccades'};
% esperimentazione        = {'instructed memory saccades','instructed distractor memory saccades'};
        

    for n_exp = 1:numel(esperimentazione)
        experiment=esperimentazione{n_exp};
        task.calibration                    = 0;
        SETTINGS.GUI_in_acquisition         = 0;
        PEST_ON                             = 0;
        task.rest_hand                      = [0 0];
        multiple_targets_per_trial          = 0;
        
        %% Order of fields here defines the order of parameters to be sent to TDT as the trial_classifiers
        All = struct(...
            'angle_cases',0, 'instructed_choice_con',0, 'type_con',0, 'effector_con',0, 'reach_hand_con',0, 'excentricities',0, 'stim_con',0, 'timing_con',0, 'size_con',0,...
            'shape_con',0, 'offset_con',0, 'exact_excentricity_con_x',NaN, 'exact_excentricity_con_y',NaN, 'colors_con',0, 'targets_con',0, 'reward_time',0, 'correct_choice_target', 0);
        
        %% Tasks
        
        % general settings
        SETTINGS.check_motion_jaw           = 0;
        SETTINGS.check_motion_body          = 0;
        SETTINGS.MonkeyMovedSound           = 0;
        
        fix_eye_y                           = 0;
        fix_hnd_y                           = 0;
        
        task.force_conditions                    = 0;
        task.shuffle_conditions                  = 1;
        
        SETTINGS.take_angles_con            = 1;
        pool_of_angles                      = [20,0,340,200,180,160]; %[0,30,150,180,210,330] [20,0,340,200,180,160]
        All.excentricities                  = [13];
        All.angle_cases                     = [1,2,3,4,5,6]; %[1,2,3,4,5,6];
        All.offset_con                      = 0; % offset of fixation spot (x dimension)
        All.effector_con                    = 0; % 0 - eye
        All.stim_con                        = 0;
        
        switch experiment
            
            case 'calibration'
                
                SETTINGS.check_motion_jaw           = 0;
                SETTINGS.check_motion_body          = 0;                
                
                SETTINGS.take_angles_con            = 1;
                pool_of_angles                      = [0];
                All.excentricities                  = [0];
                All.angle_cases                     = [1];
                
                task.force_conditions                    = 1;
                task.shuffle_conditions                  = 0;
                N_repetitions                       = 100;
                
                fix_eye_y                           = 0;
                fix_hnd_y                           = 0;
                
                All.reward_time                     = 0.05; %
                
                All.offset_con                      = 0; % offset of fixation spot
                All.effector_con                    = 0; % effector
                All.type_con                        = 1; % fixation
                All.timing_con                      = 0;
                All.size_con                        = 0;
                All.instructed_choice_con           = [0];
                
            case 'choice target-distractor memory saccades'    
                
                All.reward_time                     = 0.09; %
                 
                All.type_con                        = [3];
                All.timing_con                      = 1;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 1; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct             
                All.colors_con                      = [1 5]; %1; %[6 7];
                All.targets_con                     = 1; % 0 - two targets, 1 - three targets
                All.shape_con                       = 1;
                
                N_repetitions                       = 10;
                
            case 'choice target-distractor direct saccades'
                
                All.reward_time                     = 0.09; %               

                All.type_con                        = 2;
                All.timing_con                      = 2;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 1; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct 
                All.colors_con                      = [1 5 6 7 8]; %[1 5 6 7 8];
                All.targets_con                     = 1; % 0 - two targets, 1 - three targets
                All.shape_con                       = 1;
                
                N_repetitions                       = 12;
                
            case 'choice distractor-distractor memory saccades'
                
                All.reward_time                     = 0.09; %                

                All.type_con                        = 3;
                All.timing_con                      = 1;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 3; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct 
                All.colors_con                      = [2 9];
                All.targets_con                     = 1; % 0 - two targets, 1 - three targets
                All.shape_con                       = 1;
                
                N_repetitions                       = 5;
                
            case 'choice distractor-distractor direct saccades'
                
                All.reward_time                     = 0.09; %                
                
                All.type_con                        = 2;
                All.timing_con                      = 2;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 3; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct 
                All.colors_con                      = [2 9:12]; %[2 9:12];
                All.targets_con                     = 1; % 0 - two targets, 1 - three targets
                All.shape_con                       = 1;
                
                N_repetitions                       = 6;
                
            case 'choice target-target memory saccades'
                
                All.reward_time                     = 0.09; %                
                
                All.type_con                        = 3;
                All.timing_con                      = 1;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 0; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct 
                All.colors_con                      = 0;
                All.targets_con                     = 1; % 0 - two targets, 1 - three targets
                All.shape_con                       = 1;
                
                N_repetitions                       = 10;
                
            case 'choice target-target direct saccades'
                
                All.reward_time                     = 0.08; %
                
                All.type_con                        = 2;
                All.timing_con                      = 2;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 0; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct
                All.colors_con                      = 0;
                All.targets_con                     = 1; % 0 - two targets, 1 - three targets
                All.shape_con                       = 1;
                
                N_repetitions                       = 6;
                
            case 'instructed memory saccades'
                
                All.reward_time                     = 0.09; %
                
                All.type_con                        = [3];
                All.timing_con                      = 1;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 1; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct
                All.colors_con                      = [3];
                All.targets_con                     = 0; % 0 - two targets, 1 - three targets
                All.shape_con                       = 0;
                
                N_repetitions                       = 10;
                
            case 'instructed direct saccades'
                
                All.reward_time                     = 0.08; %
                
                All.type_con                        = 2;
                All.timing_con                      = 2;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 1; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct
                All.colors_con                      = 3;
                All.targets_con                     = 0; % 0 - two targets, 1 - three targets
                All.shape_con                       = 0;
                
                N_repetitions                       = 6;
                
            case 'instructed distractor memory saccades'
                
                All.reward_time                     = 0.09; %
                
                All.type_con                        = [3];
                All.timing_con                      = 1;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 2; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct
                All.colors_con                      = [4 13];
                All.targets_con                     = 0; % 0 - two targets, 1 - three targets
                All.shape_con                       = 0;
                
                N_repetitions                       = 10;
                
            case 'instructed distractor direct saccades'
                
                All.reward_time                     = 0.08; %
                
                All.type_con                        = 2;
                All.timing_con                      = 2;
                All.size_con                        = 1;
                All.instructed_choice_con           = [1];
                All.correct_choice_target           = 2; % 0 - targets #1 and #2 correct, 1 - target #1 correct, 2 - target #2 correct, 3 - target #3 correct
                All.colors_con                      = [4 13:14]; %[4 13:16];
                All.targets_con                     = 0; % 0 - two targets, 1 - three targets
                All.shape_con                       = 0;
                
                N_repetitions                       = 6;
                
        end
        
        %% create trial sequence
        all_fieldnames=fieldnames(All);
        N_total_conditions       =1;
        sequence_cell            ={};
        for FN=1:numel(all_fieldnames)
            N_total_conditions=N_total_conditions*numel(All.(all_fieldnames{FN}));
            sequence_cell=[sequence_cell, {All.(all_fieldnames{FN})}];
        end
        
        sequence_matrix_exp{n_exp}          = repmat(combvec(sequence_cell{:}),1,N_repetitions);
        ordered_sequence_indexes_exp{n_exp} = 1:N_total_conditions*N_repetitions;
    end
    
    if  n_exp == 0 % pseudo-randomization for fMRI tasks
        sequence_indexes_exp_shuff = cellfun(@(x) x(randperm(length(x))), ordered_sequence_indexes_exp, 'UniformOutput',0);
        
        ntrials = cellfun(@(x) size(x,2),sequence_indexes_exp_shuff);
        if ntrials(1)/ntrials(2) == 1
            s = [1 2];
        else
            s = [find(ntrials == min(ntrials)) repmat(find(ntrials == max(ntrials)),1,ntrials(ntrials == max(ntrials))/ntrials(ntrials == min(ntrials)))];
        end        
        s = repmat(s,1,6/size(s,2));       
        seq = repmat(s(randperm(length(s))),1,size([sequence_matrix_exp{:}],2)/length(s));
        count = cell(1,2);
        count{1} = 0; count{2} = 0;
        sequence_matrix = zeros(length(all_fieldnames),length(seq));
        for n = 1:length(seq)
            count{seq(n)} = count{seq(n)}+1;
            sequence_matrix(:,n) = sequence_matrix_exp{seq(n)}(:,sequence_indexes_exp_shuff{seq(n)}(count{seq(n)}));
        end
        ordered_sequence_indexes = 1:size(sequence_matrix,2);
    else
        sequence_matrix          = [sequence_matrix_exp{:}];
        idx_exact_x=ismember(all_fieldnames,'exact_excentricity_con_x');
        idx_exact_y=ismember(all_fieldnames,'exact_excentricity_con_y');
        conditions_to_remove=(sequence_matrix(idx_exact_y,:)==0 & sequence_matrix(idx_exact_x,:)==0);
        sequence_matrix(:,conditions_to_remove)=[];
        ordered_sequence_indexes = 1:(numel([ordered_sequence_indexes_exp{:}])-sum(conditions_to_remove));
    end
end

%% Shuffling conditions
if ~exist('dyn','var') || (dyn.trialNumber == 1 && task.shuffle_conditions==0)
    sequence_indexes = ordered_sequence_indexes;
elseif dyn.trialNumber == 1 && (task.shuffle_conditions==1)
    sequence_indexes = Shuffle(ordered_sequence_indexes);
end

%% Force conditions
if exist('dyn','var') && dyn.trialNumber > 1,
    if task.force_conditions==1 % error trial will be repeated
        if sum([trial.success])==length(sequence_indexes),
            dyn.state = STATE.CLOSE; return
        else
            custom_trial_condition = sequence_indexes(sum([trial.success])+1);
        end
        
    elseif task.force_conditions==2 % semi-forced: if trial is not successful, the condition is put back into the pool
        if trial(end-1).success==1
            sequence_indexes=sequence_indexes(2:end);
        else
            sequence_indexes=Shuffle(sequence_indexes);
        end
        if numel(sequence_indexes)==0
            dyn.state = STATE.CLOSE; return
        else
            custom_trial_condition = sequence_indexes(1);
        end
    else
        if numel(trial)-1==length(sequence_indexes),
            dyn.state = STATE.CLOSE; return
        else
            custom_trial_condition = sequence_indexes(numel(trial));
        end
    end
else
    custom_trial_condition = sequence_indexes(1);
end

%dyn.trial_classifier(1)=numel(All.tar_pos_con);
for field_index=1:numel(all_fieldnames)
    Current_con.(all_fieldnames{field_index})=sequence_matrix(field_index,custom_trial_condition);
    %dyn.trial_classifier(field_index+1) = Current_con.(all_fieldnames{field_index});
    dyn.trial_classifier(field_index) = abs(round(Current_con.(all_fieldnames{field_index})));
end


%% REWARD TIME
task.reward.time_neutral    = repmat(Current_con.reward_time,1,2);

%% FIXATION OFFSET
fix_eye_x             = Current_con.offset_con;
fix_hnd_x             = fix_eye_x;

%% CHOICE\INSTRUCTED
task.choice                 = Current_con.instructed_choice_con;

switch Current_con.correct_choice_target;
    case 0 % target #1 and target #2 correct
        task.correct_choice_target  = [1 2];
    case 1 % target #1 correct
        task.correct_choice_target  = 1;
    case 2 % target #2 correct
        task.correct_choice_target  = 2;
    case 3 % target #3 correct
        task.correct_choice_target  = 3;        
end

%% TYPE
task.type                   = Current_con.type_con;

%% EFFECTOR
task.effector               = Current_con.effector_con;

%% REACH hand
task.reach_hand             = Current_con.reach_hand_con;

%% STIMULATION timing
switch Current_con.stim_con
    case 0
        task.microstim.stim_on      = 0;
        task.microstim.state        = [STATE.TAR_ACQ];
        task.microstim.start{1}     = [0] ;
        task.microstim.end{1}       = [0];
end

%% TASK TIMING

% general timing
task.timing.grace_time_eye          = 0;
task.timing.fix_time_to_acquire_eye = 0.5; % 0.5
task.timing.tar_time_to_acquire_eye = 0.5; % 0.5
task.timing.wait_for_reward         = 0.5;
task.timing.ITI_success             = 2;
task.timing.ITI_success_var         = 0;
task.timing.ITI_fail                = 1;
task.timing.ITI_fail_var            = 0;
task.timing.ITI_incorrect_completed = 1;

switch Current_con.timing_con
    case 0 % 'calibration'
        
        task.timing.grace_time_eye              = 0;
        task.timing.ITI_success                 = 2;
        task.timing.ITI_success_var             = 0;
        task.timing.ITI_fail                    = 1;
        task.timing.ITI_fail_var                = 0;                
        task.timing.fix_time_hold               = 2;
        task.timing.fix_time_hold_var           = 0;
        
    case 1 % choice memory saccades
        
        task.timing.fix_time_hold               = 0.5; % duration of initial fixation
        task.timing.fix_time_hold_var           = 0.2;
        task.timing.cue_time_hold               = 0.2; % duration of the cue
        task.timing.cue_time_hold_var           = 0;
        task.timing.mem_time_hold               = 0.7; %  duration of the memory period
        task.timing.mem_time_hold_var           = 0.5;
        task.timing.tar_time_to_acquire_eye     = 0;
        task.timing.tar_inv_time_to_acquire_eye = 0.5; %0.5
        task.timing.tar_inv_time_hold           = 0.1;
        task.timing.tar_inv_time_hold_var       = 0;  
        task.timing.tar_time_hold               = 0.3; % target hold time
        task.timing.tar_time_hold_var           = 0; 
        
    case 2 % choice direct saccades
        
        task.timing.fix_time_hold               = 0.5;
        task.timing.fix_time_hold_var           = 0.4;
        task.timing.tar_time_hold               = 0.5;
        task.timing.tar_time_hold_var           = 0.0;
        
end

%% SHAPES of fixation spot and targets

task.eye.fix.shape                  = 'circle'; % 'circle', 'square'
task.hnd.fix.shape                  = 'circle'; % 'circle', 'square'

switch Current_con.shape_con
    
    case 0 % one peripheral target, one fixation target
        
        task.eye.tar(1).shape               = 'circle';
        task.eye.tar(2).shape               = 'circle';
        task.hnd.tar(1).shape               = 'circle';
        task.hnd.tar(2).shape               = 'circle';       
        
        task.eye.cue(1).shape               = 'circle';
        task.eye.cue(2).shape               = 'circle';
        task.hnd.cue(1).shape               = 'circle';
        task.hnd.cue(2).shape               = 'circle';
        
    case 1 % two peripheral targets, one fixation target
        
        task.eye.tar(1).shape               = 'circle';
        task.eye.tar(2).shape               = 'circle';
        task.eye.tar(3).shape               = 'circle';
        task.hnd.tar(1).shape               = 'circle';
        task.hnd.tar(2).shape               = 'circle';
        task.hnd.tar(3).shape               = 'circle';
        
        task.eye.cue(1).shape               = 'circle';
        task.eye.cue(2).shape               = 'circle';
        task.eye.cue(3).shape               = 'circle';
        task.hnd.cue(1).shape               = 'circle';
        task.hnd.cue(2).shape               = 'circle';
        task.hnd.cue(3).shape               = 'circle';
end

%% RADIUS and SIZES

if task.type==5 || task.type==6
    task.eye=rmfield(task.eye,'tar');
    task.hnd=rmfield(task.hnd,'tar');
end

switch Current_con.size_con
    case 0 %'calibration'
        task.eye.fix.size       = 0.25;
        task.eye.fix.radius     = 30;
        task.eye.tar(1).size    = 0.25;
        task.eye.tar(1).radius  = 30;
        
        task.hnd.fix.radius     = 4;
        task.hnd.fix.size       = 4;
        task.hnd.tar(1).size    = 4;
        task.hnd.tar(1).radius  = 4;
        
    case 1 % saccades
        
        task.eye.fix.size       = 0.5;
        task.eye.fix.radius     = 5;
        task.eye.tar(1).size    = 0.5;
        task.eye.tar(1).radius  = 5;
        
        task.hnd.fix.radius     = 4;
        task.hnd.fix.size       = 4;
        task.hnd.tar(1).size    = 4;
        task.hnd.tar(1).radius  = 4;        
        
end

task.eye.tar(2).size    = task.eye.tar(1).size;
task.hnd.tar(2).size    = task.hnd.tar(1).size ; % deg
task.eye.tar(2).radius  = task.eye.tar(1).radius;
task.hnd.tar(2).radius  = task.hnd.tar(1).radius; % deg

if Current_con.targets_con == 1
    
    task.eye.tar(3).size    = task.eye.tar(1).size;
    task.hnd.tar(3).size    = task.hnd.tar(1).size ; % deg
    task.eye.tar(3).radius  = task.eye.tar(1).radius;
    task.hnd.tar(3).radius  = task.hnd.tar(1).radius; % deg
    
end

%% TARGET POSITIONS

if SETTINGS.take_angles_con
    current_angle=pool_of_angles(Current_con.angle_cases); %
    tar_dis_x   = Current_con.excentricities*cos(current_angle*2*pi/360);
    tar_dis_y   = Current_con.excentricities*sin(current_angle*2*pi/360);
else
    tar_dis_x   = Current_con.exact_excentricity_con_x;
    tar_dis_y   = Current_con.exact_excentricity_con_y;
end

tar_dis_1x = + tar_dis_x;
tar_dis_1y = + tar_dis_y;
tar_dis_2x = - tar_dis_x;
tar_dis_2y = + tar_dis_y;
tar_dis_3x = 0;
tar_dis_3y = 10;

% fixation spot
if task.type==1 % fixation
    
    task.eye.fix.x    = fix_eye_x  + tar_dis_1x;
    task.eye.fix.y    = fix_eye_y  + tar_dis_1y;
    task.hnd.fix.x    = fix_hnd_x  + tar_dis_1x;
    task.hnd.fix.y    = fix_hnd_y  + tar_dis_1y;
else
    
    task.eye.fix.x    = fix_eye_x;
    task.eye.fix.y    = fix_eye_y;
    task.hnd.fix.x    = fix_hnd_x;
    task.hnd.fix.y    = fix_hnd_y;
end

% target positions
switch Current_con.targets_con
    
    case 0 % one peripheral target, one fixation target (instructed)
        
        task.eye.tar(1).x = fix_eye_x  + tar_dis_1x;
        task.eye.tar(1).y = fix_eye_y  + tar_dis_1y;
        task.eye.tar(2).x = fix_eye_x;
        task.eye.tar(2).y = fix_eye_y;
        
    case 1 % two peripheral targets, one fixation target (choice)

        task.eye.tar(1).x = fix_eye_x  + tar_dis_1x;
        task.eye.tar(1).y = fix_eye_y  + tar_dis_1y;
        task.eye.tar(2).x = fix_eye_x  + tar_dis_2x;
        task.eye.tar(2).y = fix_eye_y  + tar_dis_2y;
        task.eye.tar(3).x = fix_eye_x;
        task.eye.tar(3).y = fix_eye_y; % + tar_dis_3y;
        
        task.hnd.tar(1).x = fix_hnd_x  + tar_dis_1x;
        task.hnd.tar(1).y = fix_hnd_y  + tar_dis_1y;
        task.hnd.tar(2).x = fix_hnd_x  + tar_dis_2x;
        task.hnd.tar(2).y = fix_hnd_y  + tar_dis_2y;
        task.hnd.tar(3).x = fix_hnd_x;
        task.hnd.tar(3).y = fix_hnd_y; % + tar_dis_3y;

end
        
%% COLORS of fixation spot and targets - see D:\Sources\color_luminance_measurements.txt for luminance

task.eye.fix.color_dim          = [60 60 60]; % [128 0 0]
task.eye.fix.color_bright       = [110 110 110]; % [255 0 0]
      
switch Current_con.colors_con
    
    % conditions with basic distractor color
    case 0 % choice target-target saccades
        
        task.eye.tar(1).color_dim       = [128 0 0]; % red target
        task.eye.tar(1).color_bright    = [255 0 0];         
        task.eye.tar(2).color_dim       = task.eye.tar(1).color_dim; % red target
        task.eye.tar(2).color_bright    = task.eye.tar(1).color_bright;
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
        % luminance test
%         task.eye.tar(2).color_dim       = [128 0 0]; 
%         task.eye.tar(2).color_bright    = [255 0 0];        
        
    case 1 % choice target-distractor saccades
        
        task.eye.tar(1).color_dim       = [128 0 0]; % red target
        task.eye.tar(1).color_bright    = [255 0 0];
        task.eye.tar(2).color_dim       = [60 60 0]; % yellow distractor, in setup 1 [123 123 0] same luminance as [255 0 0]
        task.eye.tar(2).color_bright    = [123 123 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
    case 2 % choice distractor-distractor saccades
        
        task.eye.tar(1).color_dim       = [60 60 0]; % yellow distractor
        task.eye.tar(1).color_bright    = [123 123 0];
        task.eye.tar(2).color_dim       = [60 60 0]; % yellow distractor
        task.eye.tar(2).color_bright    = [123 123 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
    case 3 % instructed saccades
        
        task.eye.tar(1).color_dim       = [128 0 0]; % red target
        task.eye.tar(1).color_bright    = [255 0 0];
        task.eye.tar(2).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(2).color_bright    = [110 110 110];
        
        if numel(task.eye.tar) == 3
            task.eye.tar(3) = [];
        end
        
    case 4 % instructed saccades, only distractor
        
        task.eye.tar(1).color_dim       = [60 60 0]; % yellow distractor
        task.eye.tar(1).color_bright    = [123 123 0];
        task.eye.tar(2).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(2).color_bright    = [110 110 110];
        
        if numel(task.eye.tar) == 3
            task.eye.tar(3) = [];
        end
        
        
    % conditions with intermediate distractor colors
    case 5 % choice target-distractor saccades
        
        task.eye.tar(1).color_dim       = [128 0 0]; % red target
        task.eye.tar(1).color_bright    = [255 0 0];
        task.eye.tar(2).color_dim       = [95 59 0]; % distractor
        task.eye.tar(2).color_bright    = [185 90 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
    case 6 
        
        task.eye.tar(1).color_dim       = [128 0 0]; % red target
        task.eye.tar(1).color_bright    = [255 0 0];
        task.eye.tar(2).color_dim       = [113 42 0]; % distractor
        task.eye.tar(2).color_bright    = [205 60 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
    case 7
        
        task.eye.tar(1).color_dim       = [128 0 0]; % red target
        task.eye.tar(1).color_bright    = [255 0 0];
        task.eye.tar(2).color_dim       = [126 30 0]; % distractor
        task.eye.tar(2).color_bright    = [220 40 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
    case 8 
        
        task.eye.tar(1).color_dim       = [128 0 0]; % red target
        task.eye.tar(1).color_bright    = [255 0 0];
        task.eye.tar(2).color_dim       = [128 23 0]; % distractor
        task.eye.tar(2).color_bright    = [228 20 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
        
    case 9 % choice distractor-distractor saccades
        
        task.eye.tar(1).color_dim       = [95 59 0]; % distractor
        task.eye.tar(1).color_bright    = [185 90 0];
        task.eye.tar(2).color_dim       = [95 59 0]; % distractor
        task.eye.tar(2).color_bright    = [185 90 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
    case 10
        
        task.eye.tar(1).color_dim       = [113 42 0]; % distractor
        task.eye.tar(1).color_bright    = [205 60 0];
        task.eye.tar(2).color_dim       = [113 42 0]; % distractor
        task.eye.tar(2).color_bright    = [205 60 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
    case 11 
        
        task.eye.tar(1).color_dim       = [126 30 0]; % distractor
        task.eye.tar(1).color_bright    = [220 40 0];
        task.eye.tar(2).color_dim       = [126 30 0]; % distractor
        task.eye.tar(2).color_bright    = [220 40 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
    case 12
        
        task.eye.tar(1).color_dim       = [128 23 0]; % distractor
        task.eye.tar(1).color_bright    = [228 20 0];
        task.eye.tar(2).color_dim       = [128 23 0]; % distractor
        task.eye.tar(2).color_bright    = [228 20 0];
        task.eye.tar(3).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(3).color_bright    = [110 110 110];
        
        
    case 13 % instructed saccades, only distractor
        
        task.eye.tar(1).color_dim       = [95 59 0]; % distractor
        task.eye.tar(1).color_bright    = [185 90 0];
        task.eye.tar(2).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(2).color_bright    = [110 110 110];
        
        if numel(task.eye.tar) == 3
            task.eye.tar(3) = [];
        end
        
    case 14
        
        task.eye.tar(1).color_dim       = [113 42 0]; % distractor
        task.eye.tar(1).color_bright    = [205 60 0];
        task.eye.tar(2).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(2).color_bright    = [110 110 110];
        
        if numel(task.eye.tar) == 3
            task.eye.tar(3) = [];
        end 
        
    case 15 
        
        task.eye.tar(1).color_dim       = [126 30 0]; % distractor
        task.eye.tar(1).color_bright    = [220 40 0];
        task.eye.tar(2).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(2).color_bright    = [110 110 110];
        
        if numel(task.eye.tar) == 3
            task.eye.tar(3) = [];
        end
        
    case 16
        
        task.eye.tar(1).color_dim       = [128 23 0]; % distractor
        task.eye.tar(1).color_bright    = [228 20 0];
        task.eye.tar(2).color_dim       = [60 60 60]; % fixation target
        task.eye.tar(2).color_bright    = [110 110 110];
        
        if numel(task.eye.tar) == 3
            task.eye.tar(3) = [];
        end
        
end

% only important for tasks with effector hand
task.hnd_right.color_dim        = [0 128 0]; %
task.hnd_right.color_bright     = [0 255 0];
task.hnd_left.color_dim         = [39 109 216]; %
task.hnd_left.color_bright      = [119 230 253];
task.hnd_right.color_cue_dim    = [0 128 0];
task.hnd_right.color_cue_bright = [0 255 0];
task.hnd_left.color_cue_dim     = [39 109 216];
task.hnd_left.color_cue_bright  = [119 230 253];
task.hnd_stay.color_dim         = [128 129 0];
task.hnd_stay.color_bright      = [255 255 0];

% new colors dim
% [95 59 0]
% [113 42 0]
% [126 30 0]
% [128 23 0]

% new colors bright
% [185 90 0] for [95 59 0]
% [205 60 0] for [113 42 0]
% [220 40 0] for [126 30 0]
% [228 20 0] for [128 23 0]

%% CUE assignment: Positions and colors

% same positions as targets
task.eye.cue  = task.eye.tar;
task.hnd.cue  = task.hnd.tar;

% colors
switch Current_con.colors_con
    
    case 0 % choice target-target saccades 
        
        task.eye.cue(1).color_dim       = [128 0 0];
        task.eye.cue(1).color_bright    = [128 0 0];
        task.eye.cue(2).color_dim       = task.eye.cue(1).color_dim;
        task.eye.cue(2).color_bright    = task.eye.cue(1).color_bright;
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
        
    case 1 % choice target-distractor saccades
        
        task.eye.cue(1).color_dim       = [128 0 0];
        task.eye.cue(1).color_bright    = [128 0 0];
        task.eye.cue(2).color_dim       = [60 60 0];
        task.eye.cue(2).color_bright    = [60 60 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
            
    case 2 % choice distractor-distractor saccades
        
        task.eye.cue(1).color_dim       = [60 60 0];
        task.eye.cue(1).color_bright    = [60 60 0];
        task.eye.cue(2).color_dim       = [60 60 0];
        task.eye.cue(2).color_bright    = [60 60 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
        
    case 3 % instructed saccades
        
        task.eye.cue(1).color_dim       = [128 0 0];
        task.eye.cue(1).color_bright    = [128 0 0];
        task.eye.cue(2).color_dim       = [110 110 110];
        task.eye.cue(2).color_bright    = [110 110 110];
        
        if numel(task.eye.cue) == 3
            task.eye.cue(3) = [];
        end
        
    case 4 % instructed saccades, only distractor
        
        task.eye.cue(1).color_dim       = [60 60 0];
        task.eye.cue(1).color_bright    = [60 60 0];
        task.eye.cue(2).color_dim       = [110 110 110];
        task.eye.cue(2).color_bright    = [110 110 110];
         
        if numel(task.eye.cue) == 3
            task.eye.cue(3) = [];
        end
        
        
        % conditions with intermediate distractor colors
    case 5 % choice target-distractor saccades
        
        task.eye.cue(1).color_dim       = [128 0 0];
        task.eye.cue(1).color_bright    = [128 0 0];
        task.eye.cue(2).color_dim       = [95 59 0];
        task.eye.cue(2).color_bright    = [95 59 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
    
    case 6 % choice target-distractor saccades
        
        task.eye.cue(1).color_dim       = [128 0 0];
        task.eye.cue(1).color_bright    = [128 0 0];
        task.eye.cue(2).color_dim       = [113 42 0];
        task.eye.cue(2).color_bright    = [113 42 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
        
    case 7 
        
        task.eye.cue(1).color_dim       = [128 0 0];
        task.eye.cue(1).color_bright    = [128 0 0];
        task.eye.cue(2).color_dim       = [126 30 0];
        task.eye.cue(2).color_bright    = [126 30 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
        
    case 8
        
        task.eye.cue(1).color_dim       = [128 0 0];
        task.eye.cue(1).color_bright    = [128 0 0];
        task.eye.cue(2).color_dim       = [128 23 0];
        task.eye.cue(2).color_bright    = [128 23 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
        
        
    case 9 % choice distractor-distractor saccades
        
        task.eye.cue(1).color_dim       = [95 59 0];
        task.eye.cue(1).color_bright    = [95 59 0];
        task.eye.cue(2).color_dim       = [95 59 0];
        task.eye.cue(2).color_bright    = [95 59 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
        
    case 10 % choice distractor-distractor saccades
        
        task.eye.cue(1).color_dim       = [113 42 0];
        task.eye.cue(1).color_bright    = [113 42 0];
        task.eye.cue(2).color_dim       = [113 42 0];
        task.eye.cue(2).color_bright    = [113 42 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
        
    case 11
        
        task.eye.cue(1).color_dim       = [126 30 0];
        task.eye.cue(1).color_bright    = [126 30 0];
        task.eye.cue(2).color_dim       = [126 30 0];
        task.eye.cue(2).color_bright    = [126 30 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
        
    case 12
        
        task.eye.cue(1).color_dim       = [128 23 0];
        task.eye.cue(1).color_bright    = [128 23 0];
        task.eye.cue(2).color_dim       = [128 23 0];
        task.eye.cue(2).color_bright    = [128 23 0];
        task.eye.cue(3).color_dim       = [110 110 110];
        task.eye.cue(3).color_bright    = [110 110 110];
        
        
    case 13 % instructed saccades, only distractor
        
        task.eye.cue(1).color_dim       = [95 59 0];
        task.eye.cue(1).color_bright    = [95 59 0];
        task.eye.cue(2).color_dim       = [110 110 110];
        task.eye.cue(2).color_bright    = [110 110 110];
        
        if numel(task.eye.cue) == 3
            task.eye.cue(3) = [];
        end
        
    case 14 % instructed saccades, only distractor
        
        task.eye.cue(1).color_dim       = [113 42 0];
        task.eye.cue(1).color_bright    = [113 42 0];
        task.eye.cue(2).color_dim       = [110 110 110];
        task.eye.cue(2).color_bright    = [110 110 110];
        
        if numel(task.eye.cue) == 3
            task.eye.cue(3) = [];
        end
        
    case 15
        
        task.eye.cue(1).color_dim       = [126 30 0];
        task.eye.cue(1).color_bright    = [126 30 0];
        task.eye.cue(2).color_dim       = [110 110 110];
        task.eye.cue(2).color_bright    = [110 110 110];
         
        if numel(task.eye.cue) == 3
            task.eye.cue(3) = [];
        end
        
    case 16
        
        task.eye.cue(1).color_dim       = [128 23 0];
        task.eye.cue(1).color_bright    = [128 23 0];
        task.eye.cue(2).color_dim       = [110 110 110];
        task.eye.cue(2).color_bright    = [110 110 110];
         
        if numel(task.eye.cue) == 3
            task.eye.cue(3) = [];
        end
        
end