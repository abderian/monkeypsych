function get_setup_dev
global SETTINGS
SETTINGS.setup                      = 3;         % see switch SETTINGS.setup below

%% General switches
SETTINGS.GUI                        = 1;          % user GUI
SETTINGS.ITI_GUI                    = 1;
SETTINGS.useParallel                = 1;
SETTINGS.useSerial                  = 0;
SETTINGS.useSound                   = 1;
SETTINGS.useMouse                   = 0;         % 0 use mouse instead of eye position
SETTINGS.useVPacq                   = 1;         % 1 enable ViewPoint eye position acquisition
SETTINGS.useViewAPI                 = 0;       % enable SMI eye position acquisition
SETTINGS.vpx_calibration            = 0;
SETTINGS.automatic_offset_update    = 0;
SETTINGS.AllowManualSkipping        = 0;
SETTINGS.special_error              = '';

%% Sound SETTINGS
SETTINGS.INItrialSound              = 0;
SETTINGS.FixationAcquisitionSound   = 0;
SETTINGS.FixationBreakSound         = 1;
SETTINGS.SensorsReleasedSound       = 1;
SETTINGS.TouchscreenSound           = 1;
SETTINGS.MonkeyMovedSound           = 1;
SETTINGS.RewardSound                = 1;
SETTINGS.WrongTargetSound           = 1;

switch SETTINGS.setup,    
    case -10 % T�bingen        
        
        % Screen settings
        SETTINGS.whichScreen                            = 1;
        SETTINGS.screen_w_pix                           = 1920;
        SETTINGS.screen_h_pix                           = 1200;
        %SETTINGS.screen_w_pix = 1280;
        %SETTINGS.screen_h_pix = 1024;
        SETTINGS.screen_w_cm                            = 57;
        SETTINGS.screen_h_cm                            = 31.5;
        SETTINGS.BG_COLOR                               = [100 100 100];   % screen background color
        SETTINGS.GUI_aspect_ratio                       =  SETTINGS.screen_h_pix/SETTINGS.screen_w_pix;
        SETTINGS.GUI_coordinates                        = [1930 300 1000 1000*SETTINGS.GUI_aspect_ratio];
        SETTINGS.ITI_GUI_coordinates                    = [3020 300 600 600*SETTINGS.GUI_aspect_ratio];
        SETTINGS.DefaultFigurePosition                  = [2500 300 600 600*SETTINGS.GUI_aspect_ratio];
                
        %Touchscreen 1920x1200 1280x720
        SETTINGS.touchscreen                            = 0;
        SETTINGS.touchscreen_calibration.y_gain         = 113;
        SETTINGS.touchscreen_calibration.y_offset       = 535;
        SETTINGS.touchscreen_calibration.x_gain         = -190;
        SETTINGS.touchscreen_calibration.x_offset       = 980;
        SETTINGS.touchscreen_calibration.x_threshold    = -4.2; %-8.2; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = -4.2; % -8.2 lowest Voltage still different from not touched
        
        %I/O Switches
        SETTINGS.ai                                     = 0;
        SETTINGS.ao                                     = 0;
        SETTINGS.use_digital_to_TDT                     = 0;
        SETTINGS.check_motion_jaw                       = 0;
        SETTINGS.check_motion_body                      = 0;
        SETTINGS.interface_with_scanner                 = 0;
        SETTINGS.daq_digital_output_port_to_TDT         = 0;
        
        % I/O connection configuration
        SETTINGS.AI_channels                            = [0 1 2 3]; % touch_x touch_y jaw_motion body_motion
        SETTINGS.sensor_pins                            = [10 11 12 13]; %sensor left, sensor right, jaw_motion, body_motion
        SETTINGS.Motion_detection_interface             = 'Parallel';%'DAQ';
        SETTINGS.TDT_interface                          = 'Parallel';%'DAQ'; 
        SETTINGS.serial_port                            = 'com1';
        SETTINGS.DAQ_card                               = 'nidaq';
        SETTINGS.DAQSingleEnded                         = 1;
        SETTINGS.pp.address_inp                         = hex2dec('D051'); % e.g. sensors
        SETTINGS.pp.address_out_reward                  = hex2dec('D052'); % e.g. reward
        SETTINGS.pp.address_out_TDT                     = hex2dec('D050'); % e.g. TDT
                
        % Path definitions
        SETTINGS.BASE_PATH = 'C:';
        SETTINGS.dag_drive = 'C:';
        path(path,'C:\Programme\SMI\iView X SDK\include') %mac
        path(path,'C:\Programme\SMI\iView X SDK\lib')
        path(path,'C:\Programme\SMI\iView X SDK\bin')
        
        %if computer('arch') == 'win32'
        includename = 'iViewXAPI.h';
        dllname = 'iViewXAPI.dll';
        loadlibrary(dllname, includename);
        SETTINGS.ViewAPIlibrary = 'iViewXAPI';
        % else
        %includename = 'iViewXAPI.h';
        % dllname = 'iViewXAPI64.dll';
        %SETTINGS.ViewAPIlibrary = 'iViewXAPI64';
        % end
        
        Screen('Preference','Verbosity',1);
        Screen('Preference', 'SkipSyncTests', 1);
        
    case -3 % "DAG psychophysics"
        SETTINGS.whichScreen = 1;
        SETTINGS.screen_w_pix = 1920;
        SETTINGS.screen_h_pix = 1080;
        SETTINGS.screen_w_cm = 59.5;
        SETTINGS.screen_h_cm = 33;
        SETTINGS.ai = 0;
        SETTINGS.ao = 0;
        SETTINGS.use_digital_to_TDT = 0;
        SETTINGS.check_motion_jaw = 0;
        SETTINGS.check_motion_body = 0;
        SETTINGS.touchscreen = 0;
        SETTINGS.interface_with_scanner = 0;
        
        % I/O
        SETTINGS.AI_channels                            = [0 1 2 3]; % touch_x touch_y jaw_motion body_motion
        SETTINGS.Motion_detection_interface             = 'DAQ';%'Parallel'; % e.g. MD
        SETTINGS.GUI_coordinates                        = [0 20 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.ITI_GUI_coordinates                    = [800 20 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.DefaultFigurePosition                  = [1020 -700 600 600*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.sensor_pins                            = [11 13 10 12]; % sensor 1 2 3 4
        SETTINGS.pp.address_inp                         = hex2dec('379'); % e.g. sensors
        SETTINGS.pp.address_out_reward                  = hex2dec('378'); % e.g. reward
        SETTINGS.pp.address_out_TDT                     = hex2dec('378'); % e.g. TDT
        SETTINGS.TDT_interface                          = 'DAQ'; % e.g. TDT
        SETTINGS.touchscreen_calibration.y_gain         = -111;
        SETTINGS.touchscreen_calibration.y_offset       = 550;
        SETTINGS.touchscreen_calibration.x_gain         = 192;
        SETTINGS.touchscreen_calibration.x_offset       = 955;
        SETTINGS.touchscreen_calibration.x_threshold    = -5.2; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = -4.4; % lowest Voltage still different from not touched
        
        SETTINGS.BASE_PATH = 'C:';
        SETTINGS.DAQ_card = 'none';
        SETTINGS.serial_port = 'com1';
        SETTINGS.DAQSingleEnded = 0;
        SETTINGS.dag_drive = 'C:';
        
        Screen('Preference','Verbosity',1);
        Screen('Preference', 'SkipSyncTests', 1);
        
    case -2 % scanner UMG humans with mirror
        SETTINGS.whichScreen = 2;
        SETTINGS.screen_w_pix = 1024;
        SETTINGS.screen_h_pix = 768;
        SETTINGS.screen_w_cm = 6.2;
        SETTINGS.screen_h_cm = 4.65;
        SETTINGS.ai = 0;
        SETTINGS.ao = 0;
        SETTINGS.use_digital_to_TDT = 0;
        SETTINGS.check_motion_jaw = 0;
        SETTINGS.check_motion_body = 0;
        SETTINGS.touchscreen = 0;
        SETTINGS.interface_with_scanner = 0;
        
        % I/O
        SETTINGS.AI_channels                            = [0 1 2 3]; % touch_x touch_y jaw_motion body_motion
        SETTINGS.Motion_detection_interface             = 'DAQ';%'Parallel'; % e.g. MD
        SETTINGS.GUI_coordinates                        = [-1550 20 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.ITI_GUI_coordinates                    = [-750 20 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.DefaultFigurePosition                  = [1020 -700 600 600*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.sensor_pins                            = [11 13 10 12]; % sensor 1 2 3 4
        SETTINGS.pp.address_inp                         = hex2dec('379'); % e.g. sensors
        SETTINGS.pp.address_out_reward                  = hex2dec('378'); % e.g. reward
        SETTINGS.pp.address_out_TDT                     = hex2dec('378'); % e.g. TDT
        SETTINGS.TDT_interface                          = 'DAQ'; % e.g. TDT
        SETTINGS.touchscreen_calibration.y_gain         = -111;
        SETTINGS.touchscreen_calibration.y_offset       = 550;
        SETTINGS.touchscreen_calibration.x_gain         = 192;
        SETTINGS.touchscreen_calibration.x_offset       = 955;
        SETTINGS.touchscreen_calibration.x_threshold    = -5.2; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = -4.4; % lowest Voltage still different from not touched
        
        SETTINGS.BASE_PATH = 'C:';
        SETTINGS.DAQ_card = 'mcc';
        SETTINGS.serial_port = 'com1';
        SETTINGS.DAQSingleEnded = 0;
        SETTINGS.dag_drive = 'C:';
        
        Screen('Preference','Verbosity',1);
        Screen('Preference', 'SkipSyncTests', 1);
        
    case -1 % "DAG psychophysics"
        SETTINGS.whichScreen = 1;
        SETTINGS.screen_w_pix = 1600; % 1024;
        SETTINGS.screen_h_pix = 1200; %768;
        SETTINGS.screen_w_cm = 41;
        SETTINGS.screen_h_cm = 31;
        SETTINGS.ai = 0;
        SETTINGS.ao = 0;
        SETTINGS.use_digital_to_TDT = 0;
        SETTINGS.check_motion_jaw = 0;
        SETTINGS.check_motion_body = 0;
        SETTINGS.touchscreen = 0;
        SETTINGS.interface_with_scanner = 0;
        
        % I/O
        SETTINGS.AI_channels                            = [0 1 2 3]; % touch_x touch_y jaw_motion body_motion
        SETTINGS.Motion_detection_interface             = 'DAQ';%'Parallel'; % e.g. MD
        SETTINGS.GUI_coordinates                        = [-1550 20 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.ITI_GUI_coordinates                    = [-750 20 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.DefaultFigurePosition                  = [1020 -700 600 600*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.sensor_pins                            = [11 13 10 12]; % sensor 1 2 3 4
        SETTINGS.pp.address_inp                         = hex2dec('379'); % e.g. sensors
        SETTINGS.pp.address_out_reward                  = hex2dec('378'); % e.g. reward
        SETTINGS.pp.address_out_TDT                     = hex2dec('378'); % e.g. TDT
        SETTINGS.TDT_interface                          = 'DAQ'; % e.g. TDT
        SETTINGS.touchscreen_calibration.y_gain         = -111;
        SETTINGS.touchscreen_calibration.y_offset       = 550;
        SETTINGS.touchscreen_calibration.x_gain         = 192;
        SETTINGS.touchscreen_calibration.x_offset       = 955;
        SETTINGS.touchscreen_calibration.x_threshold    = -5.2; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = -4.4; % lowest Voltage still different from not touched
        
        SETTINGS.BASE_PATH = 'D:';
        SETTINGS.DAQ_card = 'none';
        SETTINGS.serial_port = 'com1';
        SETTINGS.DAQSingleEnded = 0;
        SETTINGS.dag_drive = 'D:';
        
        Screen('Preference','Verbosity',1);
        Screen('Preference', 'SkipSyncTests', 1);
        
    case 0  % scanner UMG monkeys
        SETTINGS.whichScreen = 2;
        SETTINGS.screen_w_pix = 1024;
        SETTINGS.screen_h_pix = 768;
        SETTINGS.screen_w_cm = 59.5;
        SETTINGS.screen_h_cm = 33;
        SETTINGS.ai = 1;
        SETTINGS.ao = 1;
        SETTINGS.use_digital_to_TDT = 0;
        SETTINGS.check_motion_jaw = 0;
        SETTINGS.check_motion_body = 0;
        SETTINGS.touchscreen = 0;
        SETTINGS.interface_with_scanner = 1;
        
        % I/O
        SETTINGS.AI_channels                            = [0 1 2 3]; % touch_x touch_y jaw_motion body_motion
        SETTINGS.Motion_detection_interface             = 'DAQ';%'Parallel'; % e.g. MD
        SETTINGS.GUI_coordinates                        = [-1550 20 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.ITI_GUI_coordinates                    = [-750 20 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.DefaultFigurePosition                  = [1020 -700 600 600*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.sensor_pins                            = [11 13 10 12]; % sensor 1 2 3 4
        SETTINGS.pp.address_inp                         = hex2dec('379'); % e.g. sensors
        SETTINGS.pp.address_out_reward                  = hex2dec('378'); % e.g. reward
        SETTINGS.pp.address_out_TDT                     = hex2dec('378'); % e.g. TDT
        SETTINGS.TDT_interface                          = 'DAQ'; % e.g. TDT
        SETTINGS.touchscreen_calibration.y_gain         = -111;
        SETTINGS.touchscreen_calibration.y_offset       = 550;
        SETTINGS.touchscreen_calibration.x_gain         = 192;
        SETTINGS.touchscreen_calibration.x_offset       = 955;
        SETTINGS.touchscreen_calibration.x_threshold    = -5.2; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = -4.4; % lowest Voltage still different from not touched
        
        SETTINGS.BASE_PATH = 'C:';
        SETTINGS.DAQ_card = 'mcc';
        SETTINGS.serial_port = 'com1';
        SETTINGS.DAQSingleEnded = 0;
        SETTINGS.dag_drive = 'C:';
        
        Screen('Preference','Verbosity',1);
        Screen('Preference', 'SkipSyncTests', 1);
        
    case 1
        % Screen settings
        SETTINGS.whichScreen                            = 1;
        SETTINGS.screen_w_pix                           = 1920;
        SETTINGS.screen_h_pix                           = 1080;
        SETTINGS.screen_w_cm                            = 59.5;
        SETTINGS.screen_h_cm                            = 33;
        SETTINGS.BG_COLOR                               = [0 0 0];   % screen background color
        SETTINGS.GUI_aspect_ratio                       = SETTINGS.screen_h_pix/SETTINGS.screen_w_pix;
        SETTINGS.GUI_coordinates                        = [800 -800 800 800*SETTINGS.GUI_aspect_ratio];
        SETTINGS.ITI_GUI_coordinates                    = [190 -600 700 700*SETTINGS.GUI_aspect_ratio];
        SETTINGS.DefaultFigurePosition                  = [190 -600 700 700*SETTINGS.GUI_aspect_ratio];
        
        % Touchscreen
        SETTINGS.touchscreen = 1;
        SETTINGS.touchscreen_calibration.y_gain         = -133; % Danial 20160204
        SETTINGS.touchscreen_calibration.y_offset       = 567;  % Danial 20160204
        SETTINGS.touchscreen_calibration.x_gain         = 171;  % Danial 20160204
        SETTINGS.touchscreen_calibration.x_offset       = 958;  % Danial 20160204
        SETTINGS.touchscreen_calibration.x_threshold    = -5.2; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = -3.8; % lowest Voltage still different from not touched
        
        % I/O
        SETTINGS.ai = 1;
        SETTINGS.ao = 1;
        SETTINGS.AI_channels                            = [0 1 2 3]; % touch_x touch_y jaw_motion body_motion
        SETTINGS.sensor_pins                            = [11 13 10 12]; % [sensor-left sensor-right jaw-motion body-motion]
        SETTINGS.pp.value_out_reward                    = 1; % 1 - parallel port output pin 2 for reward
        SETTINGS.DAQ_card                               = 'nidaq';
        SETTINGS.serial_port                            = 'com1';
        SETTINGS.DAQSingleEnded                         = 1;
        SETTINGS.interface_with_scanner                 = 0;
        SETTINGS.Motion_detection_interface             = 'DAQ';%'Parallel'; %'DAQ'; % e.g. MD
        
        % Original (broken) parallel port (behavioral client):
        SETTINGS.pp.address_inp                         = hex2dec('379'); % e.g. sensors
        SETTINGS.pp.address_out_reward                  = hex2dec('378'); % e.g. reward
        SETTINGS.pp.address_out_TDT                     = hex2dec('378'); % e.g. TDT
        
        % Parallel port (external card): CCB0 - output, CCC0 - input
        %         SETTINGS.pp.address_inp                         = hex2dec('CCC0'); % e.g. sensors
        %         SETTINGS.pp.address_out_reward                  = hex2dec('CCB0'); % e.g. reward
        %         SETTINGS.pp.address_out_TDT                     = hex2dec('CCC'); % e.g. TDT - not tested!
        
        % microstim settings
        SETTINGS.microstim_interface                    = 'Parallel'; %'Parallel' or 'DAQ';
        SETTINGS.pp.value_out_microstim                 = 16; %16 - parallel port output pin 6 for microstim trigger
        
        % TDT related settings
        SETTINGS.daq_digital_output_port_to_TDT         = 0;
        SETTINGS.use_digital_to_TDT                     = 1;
        SETTINGS.TDT_interface                          = 'DAQ'; % e.g. TDT
        
        % data paths
        SETTINGS.BASE_PATH                              = 'D:';
        SETTINGS.dag_drive = [filesep filesep 'fs02' filesep 'dag$'];
        
    case 2
        % Screen settings
        SETTINGS.whichScreen                            = 2;
        SETTINGS.screen_w_pix                           = 1920;
        SETTINGS.screen_h_pix                           = 1080;
        SETTINGS.screen_w_cm                            = 59.5;
        SETTINGS.screen_h_cm                            = 33;
        SETTINGS.BG_COLOR                               = [0 0 0];   % screen background color
        SETTINGS.GUI_aspect_ratio                       = SETTINGS.screen_h_pix/SETTINGS.screen_w_pix;
        SETTINGS.GUI_coordinates                        = [10 -700 1000 1000*SETTINGS.GUI_aspect_ratio];
        SETTINGS.ITI_GUI_coordinates                    = [1020 -700 600 600*SETTINGS.GUI_aspect_ratio];
        SETTINGS.DefaultFigurePosition                  = [1020 -700 600 600*SETTINGS.GUI_aspect_ratio];
        
        % Touchscreen
        SETTINGS.touchscreen = 1;
        SETTINGS.touchscreen_calibration.y_gain         = -113; % 20160331 Adan
        SETTINGS.touchscreen_calibration.y_offset       = 545;  % 20160331 Adan
        SETTINGS.touchscreen_calibration.x_gain         = 192;  % 20160331 Adan
        SETTINGS.touchscreen_calibration.x_offset       = 965;  % 20160331 Adan
        SETTINGS.touchscreen_calibration.x_threshold    = -4.5; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = -4.5; % lowest Voltage still different from not touched
        
        % I/O switches
        SETTINGS.ai                             = 1;
        SETTINGS.ao                             = 1;
        SETTINGS.use_digital_to_TDT             = 1;
        SETTINGS.check_motion_jaw               = 1;
        SETTINGS.check_motion_body          	= 0;
        SETTINGS.interface_with_scanner         = 0;
        SETTINGS.daq_digital_output_port_to_TDT = 1;
        
        % I/O connections configuration
        SETTINGS.AI_channels                            = [0 2 4 6]; % touch_x touch_y jaw_motion body_motion
        SETTINGS.sensor_pins                            = [10 12 11 13];
        SETTINGS.DAQ_card                               = 'nidaq';
        SETTINGS.DAQSingleEnded                         = 0;
        SETTINGS.serial_port                            = 'com1';
        SETTINGS.TDT_interface                          = 'DAQ'; % e.g. TDT
        SETTINGS.Motion_detection_interface             = 'DAQ';%'Parallel'; % e.g. MD
        
        % Parallel port connections configuration
        SETTINGS.pp.address_inp                         = hex2dec('379'); % e.g. sensors
        SETTINGS.pp.address_out_reward                  = hex2dec('378'); % e.g. reward
        SETTINGS.pp.address_out_TDT                     = hex2dec('378'); % e.g. TDT
        SETTINGS.pp.value_out_reward                    = 255; % 1 - parallel port output pin 2 for reward
        SETTINGS.pp.value_out_microstim                 = 16; %16 - parallel port output pin 6 for microstim trigger
        
        % Paths
        SETTINGS.BASE_PATH = 'D:';
        SETTINGS.dag_drive = [filesep filesep 'fs02' filesep 'dag$'];
        
    case 3
        % Screen settings
        SETTINGS.whichScreen                            = 1;
        SETTINGS.screen_w_pix                           = 1920;
        SETTINGS.screen_h_pix                           = 1080;
        %         SETTINGS.screen_w_cm = 59.5; %ACER
        %         SETTINGS.screen_h_cm = 33;   %ACER
        SETTINGS.screen_w_cm                            = 53;   %ASUS
        SETTINGS.screen_h_cm                            = 30;     %ASUS
        SETTINGS.BG_COLOR                               = [0 0 0];   % screen background color
        SETTINGS.GUI_aspect_ratio                       =  SETTINGS.screen_h_pix/SETTINGS.screen_w_pix;
        SETTINGS.GUI_coordinates                        = [1930 300 1000 1000*SETTINGS.GUI_aspect_ratio];
        SETTINGS.ITI_GUI_coordinates                    = [3020 300 600 600*SETTINGS.GUI_aspect_ratio];
        SETTINGS.DefaultFigurePosition                  = [2500 300 600 600*SETTINGS.GUI_aspect_ratio];
        
        % Touchscreen
        SETTINGS.touchscreen                            = 0;
        SETTINGS.touchscreen_calibration.y_gain         = 122;
        SETTINGS.touchscreen_calibration.y_offset       = -121;
        SETTINGS.touchscreen_calibration.x_gain         = -212;
        SETTINGS.touchscreen_calibration.x_offset       = 2131;
        SETTINGS.touchscreen_calibration.x_threshold    = 0.7; %-8.2; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = 0.7; % -8.2 lowest Voltage still different from not touched
        %         SETTINGS.touchscreen_calibration.y_gain         = -111;
        %         SETTINGS.touchscreen_calibration.y_offset       = 765;
        %         SETTINGS.touchscreen_calibration.x_gain         = 188;
        %         SETTINGS.touchscreen_calibration.x_offset       = 550;
        
        % I/O switches
        SETTINGS.ai                             = 1;
        SETTINGS.ao                             = 1;
        SETTINGS.use_digital_to_TDT             = 1;
        SETTINGS.daq_digital_output_port_to_TDT = 0;
        SETTINGS.check_motion_jaw               = 1;
        SETTINGS.check_motion_body          	= 1;
        SETTINGS.interface_with_scanner         = 0;
        
        % I/O connections configuration
        SETTINGS.AI_channels                            = [0 1 2 3]; % touch_x touch_y jaw_motion body_motion
        SETTINGS.sensor_pins                            = [10 11 12 13]; %sensor left, sensor right, jaw_motion, body_motion
        SETTINGS.DAQ_card                               = 'nidaq';
        SETTINGS.DAQSingleEnded                         = 1;
        SETTINGS.serial_port                            = 'com1';
        SETTINGS.TDT_interface                          = 'Parallel';%'DAQ'; % e.g. TDT
        SETTINGS.Motion_detection_interface             = 'Parallel';%'DAQ';%'DAQ'; % e.g. TDT
        SETTINGS.microstim_interface                    = 'DAQ';
        % I/O parallel port connections configuration
        SETTINGS.pp.address_inp                         = hex2dec('D051'); % e.g. sensors
        SETTINGS.pp.address_out_reward                  = hex2dec('D052'); % e.g. reward
        SETTINGS.pp.address_out_TDT                     = hex2dec('D050'); % e.g. TDT
        SETTINGS.pp.value_out_reward                    = 255; % 1 - parallel port output pin 2 for reward
        SETTINGS.pp.value_out_microstim                 = 16; %16 - parallel port output pin 6 for microstim trigger
                
        % Paths     
        SETTINGS.BASE_PATH = 'D:';
        %SETTINGS.dag_drive = [filesep filesep 'fs02' filesep 'dag$'];
        %SETTINGS.dag_drive = ['Z:\dag02']; % temporary
        SETTINGS.dag_drive = ['Y:']; % temporary 
        
        
        
        Screen('Preference','Verbosity',1);
        Screen('Preference', 'SkipSyncTests', 1);
        
    case 4 % scanner DPZ monkeys
        % Screen settings
        SETTINGS.whichScreen                        = 2;
        SETTINGS.screen_w_pix                       = 800;
        SETTINGS.screen_h_pix                       = 600;
        SETTINGS.screen_w_cm                        = 65; %53
        SETTINGS.screen_h_cm                        = 40.5; %39
        SETTINGS.GUI_coordinates                    = [574 288 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.ITI_GUI_coordinates                = [190 -600 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.DefaultFigurePosition              = [190 -600 700 700*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        
        % I/O
        SETTINGS.ai                                 = 0;
        SETTINGS.ao                                 = 0;
        SETTINGS.check_motion_jaw                   = 1;
        SETTINGS.check_motion_body                  = 0; % at the moment only checking of jaw motion possible
        SETTINGS.AI_channels                        = [0 1 2 3]; % [touch_x touch_y jaw_motion body_motion]
        SETTINGS.Motion_detection_interface         = 'Parallel'; %'Parallel' or 'DAQ';
        SETTINGS.sensor_pins                        = [13 15 11 12 10]; % [(sensor-left) (sensor-right) jaw-motion (body-motion) scanner-trigger] % pin 12 not so reliable on the hardware side!
        SETTINGS.pp.address_inp                     = hex2dec('D051'); % e.g. sensors
        SETTINGS.pp.address_out_reward              = hex2dec('D050'); % e.g. reward
        SETTINGS.pp.value_out_reward                = 4; % 4 - trigger output pin D2 for reward
        SETTINGS.DAQ_card                           = 'mcc';
        SETTINGS.serial_port                        = 'com4';
        SETTINGS.DAQSingleEnded                     = 1;
        
        % Scanner settings
        SETTINGS.interface_with_scanner             = 0; % 0 - no scanner interface, 1 - UMG (trigger as keyboard button press), 2 - DPZ (trigger through parallel port)
        SETTINGS.skip_volumes	= 4;
        SETTINGS.TR             = 2; % s
        SETTINGS.run_volumes	= 450; % number of volumes in one run
        
        % microstim settings
        SETTINGS.microstim_interface                = 'Parallel'; %'Parallel' or 'DAQ';
        SETTINGS.pp.value_out_microstim                = 16; %16 - use output pin D4 for microstim trigger
        
        % data paths
        SETTINGS.BASE_PATH = 'D:'; % computer
        SETTINGS.dag_drive = 'W:'; % server % [filesep filesep 'fs02' filesep 'akn$' filesep 'DAG']
        
        % not used in scanner setup
        SETTINGS.touchscreen                        = 0;
        SETTINGS.touchscreen_calibration.y_gain         = -133; % Danial 20160204
        SETTINGS.touchscreen_calibration.y_offset       = 567;  % Danial 20160204
        SETTINGS.touchscreen_calibration.x_gain         = 171;  % Danial 20160204
        SETTINGS.touchscreen_calibration.x_offset       = 958;  % Danial 20160204
        SETTINGS.touchscreen_calibration.x_threshold    = -5.2; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = -3.8; % lowest Voltage still different from not touched
        SETTINGS.TDT_interface                          = 'DAQ'; % e.g. TDT
        SETTINGS.use_digital_to_TDT                     = 0;
        SETTINGS.daq_digital_output_port_to_TDT         = 0;
        SETTINGS.pp.address_out_TDT                     = hex2dec('378'); % e.g. TDT
        
        %         SETTINGS.pins  = [11 10 12 13 15]; % parallel port pins
        %         SETTINGS.bits  = [7  6  5  4  3]; % bits when input comes through respective pin
        %         SETTINGS.n_bit = SETTINGS.bits(arrayfun(@(x) find(SETTINGS.pins==x),[10 12]));
        
    case 100 % Lukas computer :P
        SETTINGS.whichScreen = 1;
        SETTINGS.screen_w_pix = 1920;
        SETTINGS.screen_h_pix = 1080;
        SETTINGS.screen_w_cm = 59.5;
        SETTINGS.screen_h_cm = 33;
        SETTINGS.ai = 0;
        SETTINGS.ao = 0;
        SETTINGS.use_digital_to_TDT = 0;
        SETTINGS.check_motion_jaw = 0;
        SETTINGS.check_motion_body = 0;
        SETTINGS.touchscreen = 0;
        SETTINGS.interface_with_scanner = 0;
        
        % I/O
        SETTINGS.AI_channels                            = [0 2 4 6]; % touch_x touch_y jaw_motion body_motion
        SETTINGS.Motion_detection_interface             = 'DAQ';%'Parallel'; % e.g. MD
        SETTINGS.GUI_coordinates                        = [1960 0 1000 1000*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.ITI_GUI_coordinates                    = [2800 0 1000 1000*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.DefaultFigurePosition                  = [1020 -700 600 600*SETTINGS.screen_h_pix/SETTINGS.screen_w_pix];
        SETTINGS.sensor_pins                            = [11 13 10 12];
        SETTINGS.pp.address_inp                         = hex2dec('379'); % e.g. sensors
        SETTINGS.pp.address_out_reward                  = hex2dec('378'); % e.g. reward
        SETTINGS.pp.address_out_TDT                     = hex2dec('378'); % e.g. TDT
        SETTINGS.TDT_interface                          = 'DAQ'; % e.g. TDT
        SETTINGS.touchscreen_calibration.y_gain         = -111;
        SETTINGS.touchscreen_calibration.y_offset       = 550;
        SETTINGS.touchscreen_calibration.x_gain         = 192;
        SETTINGS.touchscreen_calibration.x_offset       = 955;
        SETTINGS.touchscreen_calibration.x_threshold    = -5.4; % lowest Voltage still different from not touched
        SETTINGS.touchscreen_calibration.y_threshold    = -4.4; % lowest Voltage still different from not touched
        
        SETTINGS.BASE_PATH = 'D:';
        SETTINGS.DAQ_card = 'mcc';
        SETTINGS.serial_port = 'com1';
        SETTINGS.DAQSingleEnded = 0;
        SETTINGS.dag_drive = 'D:';
        
        
end
