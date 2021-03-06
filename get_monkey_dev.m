function [task, monkey_name, pathname] =  get_monkey_dev(monkey)
global SETTINGS
%% VERSION LOG
% version 1: first working version, Linus data from 20120317 to 20120417
% version 2: reward probability added, Linus data from 20120418 to **
% version 3: current version from 20160113, for use with custum condition
% files
task.software                       = 'D:\Sources\MATLAB\monkeypsych2.0\monkeypsych_dev.m';
task.version                        = 3;
task.version_modified               = '20160411';

%% Sound SETTINGS
SETTINGS.INItrialSound              = 0;
SETTINGS.FixationAcquisitionSound   = 0;
SETTINGS.FixationBreakSound         = 1;
SETTINGS.SensorsReleasedSound       = 1;
SETTINGS.TouchscreenSound           = 1;
SETTINGS.MonkeyMovedSound           = 1;
SETTINGS.RewardSound                = 1;
SETTINGS.WrongTargetSound           = 1;

%% DEFAULT SETTINGS:
% GLOBAL VARIABLES
% global STATE
% STATES
% STATE.INI_TRI                       = 1; % initialize trial
% STATE.FIX_ACQ                       = 2; % fixation acquisition
% STATE.FIX_HOL                       = 3; % fixation hold
% STATE.TAR_ACQ                       = 4; % target acquisition
% STATE.TAR_HOL                       = 5; % target hold
% STATE.CUE_ON                        = 6; % cue on
% STATE.MEM_PER                       = 7; % memory period
% STATE.DEL_PER                       = 8; % delay period
% STATE.TAR_ACQ_INV                   = 9; % target acquisition invisible
% STATE.TAR_HOL_INV                   = 10; % target hold invisible
% STATE.MAT_ACQ                       = 11; % target acquisition in sample to match
% STATE.MAT_HOL                       = 12; % target acquisition in sample to match
% STATE.MAT_ACQ_MSK                   = 13; % target acquisition in sample to match
% STATE.MAT_HOL_MSK                   = 14; % target acquisition in sample to match
% STATE.SEN_RET                       = 15; % return to sensors for poffenberger
% STATE.FIX_PER                       = 16; % return to sensors for poffenberger
% STATE.ABORT                         = 19;
% STATE.SUCCESS                       = 20;
% STATE.REWARD                        = 21;
% STATE.ITI                           = 50;
% STATE.CLOSE                         = 99;

%% MICROSTIMULATION SETTINGS
task.microstim.fraction             = 0; % from 0 to 1
task.microstim.interval             = NaN;
task.microstim.state                = NaN;
task.microstim.start{1}             = NaN;
task.microstim.end{1}               = NaN;

%% BEHAVIORAL ENHANCEMENTS
task.extra_reward                   = 0;
task.force_target_location          = 0; % force same target after abort
task.force_hand                     = 0; % force same hand after abort
task.force_effector                 = 0;

%% INITIAL CHECKS
task.check_screen_touching          = 0;
task.rest_sensors_ini_time          = 1;
task.rest_hand                      = [0 0];
task.fraction_choice                = 0;
task.correct_choice_target          = [1 2];
task.custom_conditions              = '';
task.condition_file                 = '\Sources\MATLAB\monkeypsych_2.0\conditions\default_conditions.txt'; % might remove at some point if only custom conditions used

%% RANDOMIZATIONS
task.randomize_reach_hand           = 0;
task.randomize_reach_hand_ratio     = [0.5 0.5 0];
task.randomize_effector             = 0;
task.randomize_effector_ratio       = [0.5 0.5 0];

%% REWARD MODULATION
task.reward_modulation_effector     = 2; % 1 - eye, 2 - hand, only important when  task.effector =2; (it refers to which effector is important for acquisition and reward amount )
task.fraction_reward_modulation     = 0;
task.fraction_reward_small          = 0.5;
task.reward.prob_neutral            = 1;
task.reward.prob_small              = 1;
task.reward.prob_neutral            = 1;
task.reward.prob_large              = 1;
task.reward.large_color             = [218 70 255]; % color of ring around red or green targets
task.reward.time_large              = [1 1]; % 0.18ml per hit at 11.3 volts
task.reward.small_color             = [47 130 255];
task.reward.time_small              = [0.1 0.1]; % 0.12ml per hit at 11.3 volts

% this is "loss" part of risky gamble,
if  task.reward.time_large(2) == 0, % leave black
    task.reward.large_color2        = [0 0 0];
else % something else other than black
    % IRA change here if needed ( select one of those below,
    % comment out the rest
    % orange
    task.reward.large_color2        = [255 140 0];
    % yellow
    % task.reward.large_color       = [255 255 0];
end

%% COLOR DEFINITIONS
task.hnd_stay.color_dim_fix         = [128 128 0];
task.hnd_stay.color_bright_fix      = [255 255 0];
task.hnd_left.color_dim_fix         = [39 109 216];
task.hnd_left.color_bright_fix      = [119 230 253];
task.hnd_right.color_dim_fix        = [0 128 0];
task.hnd_right.color_bright_fix     = [0 255 0];
task.hnd_right.color_dim            = [0 128 0]; %
task.hnd_right.color_bright         = [0 255 0];
task.hnd_left.color_dim             = [39 109 216]; %
task.hnd_left.color_bright          = [119 230 253];
task.hnd_right.color_cue            = [0 128 0]; %[50 80 50]; %%isoluminance?
task.hnd_left.color_cue             = [39 109 216]; %[64 77 80];

% task.hnd_right.color_cue= task.hnd_right.color_dim;
% task.hnd_left.color_cue= task.hnd_left.color_dim;
% task.hnd.cue = task.hnd.tar;
% task.eye.cue = task.eye.tar;

%% TARGET SHAPE DEFINITIONS
task.eye.fix.shape                  = 'circle'; % 'circle', 'square'
task.hnd.fix.shape                  = 'circle'; % 'circle', 'square'

task.hnd.tar(1).shape               = 'circle';
task.hnd.tar(2).shape               = 'circle';
task.eye.tar(1).shape               = 'circle';
task.eye.tar(2).shape               = 'circle';

task.hnd.tar(1).color_inv           = SETTINGS.BG_COLOR;
task.hnd.tar(2).color_inv           = SETTINGS.BG_COLOR;
task.eye.tar(1).color_inv           = SETTINGS.BG_COLOR;
task.eye.tar(2).color_inv           = SETTINGS.BG_COLOR;

task.hnd.cue(1).shape               = 'circle';
task.hnd.cue(2).shape               = 'circle';
task.eye.cue(1).shape               = 'circle';
task.eye.cue(2).shape               = 'circle';

task.rings_only_on_cues             = 0;

%% TARGET SIZE AND RADIUS DEFINITIONS (TO BE OVERWRITTEN BY CUSTOM CONDITIONS, just in case of analysis problems for not defined positions)
% task.hnd.tar(1).size                = 5;
% task.hnd.tar(2).size                = 5;
% task.eye.tar(1).size                = 0.5;
% task.eye.tar(2).size                = 0.5;
% task.hnd.cue(1).size                = 5;
% task.hnd.cue(2).size                = 5;
% task.eye.cue(1).size                = 0.5;
% task.eye.cue(2).size                = 0.5;
%
% task.hnd.tar(1).radius              = 5;
% task.hnd.tar(2).radius              = 5;
% task.eye.tar(1).radius              = 5;
% task.eye.tar(2).radius              = 5;
% task.hnd.cue(1).radius              = 5;
% task.hnd.cue(2).radius              = 5;
% task.eye.cue(1).radius              = 5;
% task.eye.cue(2).radius              = 5;

%% MONKEY DEFINITIONS
switch monkey
    
    case 'Test'
        monkey_name                 = 'Tst';
        pathname                    = 'D:\Data\Test';
          %task.custom_conditions      = 'D:\Sources\MATLAB\monkeypsych_2.0\conditions\Normen\combined_condition_file_Normen_distractor_task';
        %task.custom_conditions      = 'D:\Sources\MATLAB\monkeypsych_2.0\conditions\Normen\combined_condition_file_hand_m2s_Normen';
%        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\standard_tasks';
%         task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_exploration_in_black_8_positions_humans';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_exploration_in_black_18_positions';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_2targets_exploration_in_black';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_exploration_in_black_8_positions';
        
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\combined_condition_file_Cornelius_distractor_task_full';
        %task.custom_conditions      =  '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand';
        
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_test';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\Memory_ephys';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Curius\combined_condition_file_Curius_distractor_task';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Curius\combined_condition_file_Curius_setup_sacc';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand_Tes';
%         task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_Bacchus_MRI_experiment';
%         task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_Bacchus_MRI';
        
        task.vd                     = 32; %32 chair 2 %30; chair 1 % cm
        task.screen_uh_cm           = 6; %32 chair 2 %30; chair 1 % cm
        
    case 'HumanNeglect'
        
        monkey_name         = 'SU1';
        pathname            = 'C:\Users\admin\Desktop\monkeypsych_20151111';
        task.condition_file = '\Sources\MATLAB\monkeypsych\conditions\linus_cornelius_0_1_2.txt';
        %task.custom_conditions      = '';
        task.custom_conditions      = 'C:\Users\admin\Desktop\monkeypsych_20151111\Sources\MATLAB\monkeypsych\conditions\combined_condition_file_eye_hand.m';
        task.vd = 50; % cm
        task.screen_uh_cm           = 4; %32 chair 2 %30; chair 1 % cm
        
    case 'TestTDT'
        
    case 'HumanM2S'
        SETTINGS.INItrialSound              = 1;
        SETTINGS.AllowManualSkipping        = 1;
        monkey_name                 = 'AM1';
        pathname                    = 'C:\Data\HumanM2S';
        %task.custom_conditions      = '\sources\MATLAB\monkeypsych_2.0\conditions\HumanM2S\calibration_task';
        task.custom_conditions      = '\sources\MATLAB\monkeypsych_2.0\conditions\HumanM2S\M2S_exploration';
        task.vd                     = 35; %32 30 %chair 2 %chair 1 % cm
        task.screen_uh_cm           = 16; %32 chair 2 %30; chair 1 % cm   
        
        
    case 'Norman'      
        monkey_name                 = 'Nor';
        pathname                    = 'V:\Projects\Wagering_monkey\Touch_M2S';
        %task.custom_conditions      = 'D:\Sources\MATLAB\monkeypsych_2.0\conditions\Norman\combined_condition_file_hand_m2s_Norman';
        %task.custom_conditions      = 'D:\Sources\MATLAB\monkeypsych_2.0\conditions\Norman\combined_condition_file_eye_hand_Norman_BasisTesla';
        task.custom_conditions      = 'D:\Sources\MATLAB\monkeypsych_2.0\conditions\Norman\combined_condition_file_Normen_distractor_task';

        task.vd                     = 26;
        task.screen_uh_cm           = 3.0;
        
    case 'Cornelius'
        monkey_name                 = 'Cor';
        %pathname                    = 'D:\Data\Cornelius';
%          task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\standard_tasks';
         task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\Memory_ephys';
%        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_exploration_in_black_18_positions';
%         task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_exploration_in_black_8_positions';
        task.vd                     = 36;  %chair 2 %30; %chair 1 % cm
        task.screen_uh_cm           = 8;
    
    case 'Cornelius_ina'
        monkey_name                 = 'Cor';
        pathname                    = 'D:\Data\Cornelius_ina';
%         task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\standard_tasks';
       task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\Memory_ephys';
%         task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_exploration_in_black_18_positions';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_2targets_exploration_in_black';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_exploration_in_black';
        task.vd                     = 36;  %chair 2 %30; %chair 1 % cm
        task.screen_uh_cm           = 8;%6; 
        
    case 'Cornelius_phys'
        monkey_name                 = 'Cor';
        pathname                    = 'D:\Data\Cornelius_phys';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\standard_tasks';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\Memory_ephys';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_exploration_in_black_16_positions';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_2targets_exploration_in_black';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Cornelius\M2S_exploration_in_black';
        task.vd                     = 36;  %chair 2 %30; %chair 1 % cm
        task.screen_uh_cm           = 6; 
        
        
    case 'Linus'
        monkey_name                 = 'Lin';
        pathname                    = '\Data\Linus';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand_DA';
        task.vd                     = 29.0;
        task.screen_uh_cm           = 6; 
%         task.custom_conditions        = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_flaffy';
%         task.custom_conditions        = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_lin_training';
        
    case 'Linus_phys'
        monkey_name                 = 'Lin';
        pathname                    = '\Data\Linus_phys';
        %         task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_phys';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand';
        task.vd                     = 29.5;
        task.screen_uh_cm           = 6;
        
    case 'Linus_microstim'
        monkey_name                 = 'Lin';
        pathname                    = '\Data\Linus_microstim';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_stim';
        task.vd                     = 29.5;
        task.screen_uh_cm           = 6;
        %         task.custom_conditions        = '\Sources\MATLAB\monkeypsych_2.0\conditions\Linus\microstim_fixation_20140710';
        
    case 'Linus_ina'
        monkey_name                 = 'Lin';
        pathname                    = '\Data\Linus_ina';
        %         task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_phys';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand';
        task.vd                     = 29.5;
        task.screen_uh_cm           = 6;
     
    

    case 'Flaffus'
        monkey_name                 = 'Fla';
        pathname                    = '\Data\Flaffus';
        task.custom_conditions      =  '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand';
        switch SETTINGS.setup
            case 2
                task.vd                     = 29.5;
                task.screen_uh_cm           = 6.5;
            case 3
                task.vd                     = 33.5;
                task.screen_uh_cm           = 6; % chair 2
        end
        
    case 'Flaffus_phys'
        monkey_name                 = 'Fla';
        pathname                    = '\Data\Flaffus_phys';
        task.custom_conditions      =  '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand';
        task.vd                     = 29.5;
        task.screen_uh_cm           = 6.5;
        
    case 'Flaffus_ina'
        monkey_name                 = 'Fla';
        pathname                    = '\Data\Flaffus_ina';
        task.custom_conditions      =  '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand';
        task.vd                     = 29.5;
        task.screen_uh_cm           = 6.5;   
        
    case 'Tesla'
        monkey_name                 = 'Tes';
        pathname                    = '\Data\Tesla';
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_eye_hand_Tes';
        task.vd                     = 26;
        task.screen_uh_cm           = 3.0;
        
    case 'Bacchus_MRI'
        monkey_name                 = 'Bac';
        pathname                    = '\Data\Bacchus';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_Bacchus_MRI';
        task.vd                     = 52.5; %55
        task.screen_uh_cm           = 16;
    
    case 'Bacchus'
        monkey_name                 = 'Bac';
        pathname                    = '\Data\Bacchus';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_Bacchus_MRI';
        task.vd                     = 46;
        task.screen_uh_cm           = 15; %18 old screen
        
    case 'Bacchus_scanner' % DPZ scanner
        monkey_name                 = 'Bac';
        pathname                    = '\Data\Bacchus';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file_Bacchus_MRI';
        task.vd                     = 60;
        task.screen_uh_cm           = 20;
        
    case 'Magnus'
        monkey_name                 = 'Mag';
        pathname                    = 'D:\Data\Magnus';
        task.vd                     = 30;
        task.screen_uh_cm           = 8;
        %task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Magnus\standard_tasks';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Magnus\combined_condition_file_Magnus.m';
    
    case 'Curius_microstim'
        monkey_name                 = 'Cur';
        pathname                    = '\Data\Curius_microstim';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\combined_condition_file.m';
        task.vd = 31.5;
        task.screen_uh_cm           = 20;
        %         task.custom_conditions        = '\Sources\MATLAB\monkeypsych_2.0\conditions\Curius\Detection_microstim_direct.m';
        %         task.custom_conditions        = '\Sources\MATLAB\monkeypsych_2.0\conditions\Curius\microstim_fixation_20140710.m';
        
    case 'Curius_phys'
        monkey_name                 = 'Cur';
        pathname                    = '\Data\Curius_phys';
        task.custom_conditions      = '';
        task.vd                     = 31.5;
        task.screen_uh_cm           = 20;
        
    case 'Curius'
        monkey_name                 = 'Cur';
        pathname                    = '\Data\Curius';
        % task.custom_conditions      = 'D:\Sources\MATLAB\monkeypsych_2.0\conditions\Curius\combined_condition_file_Curius_setup_sacc.m';
        task.custom_conditions      = 'D:\Sources\MATLAB\monkeypsych_2.0\conditions\Curius\combined_condition_file_Curius_distractor_task_full.m';
        switch SETTINGS.setup
            case 1
                task.vd                     = 29; % chair 1: 29, chair 2: 32, MRI 2: 54
                task.screen_uh_cm           = 6;  % chair 1 and 2: 6, MRI 2: 14
            case 3
                task.vd                     = 30;
                task.screen_uh_cm           = 7;
        end
        
    case 'Curius_scanner'
        monkey_name                 = 'Cur';
        pathname                    = '\Data\Curius';
        task.custom_conditions      = '\Sources\MATLAB\monkeypsych_2.0\conditions\Curius\combined_condition_file_Curius_MRI';
        task.vd                     = 65;
        task.screen_uh_cm           = 20;
        
end