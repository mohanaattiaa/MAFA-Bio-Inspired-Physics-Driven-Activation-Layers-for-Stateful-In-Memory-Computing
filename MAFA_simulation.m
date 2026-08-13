clear; clc; close all;

% =========================================================================
% 1. SIMULATE MULTIPLE CYCLES TO ACHIEVE STEADY-STATE (Original MAFA Equation)
% =========================================================================
alpha1 = -2.5; alpha11 = -1.2; alpha111 = 4.5; kappa = 0.01; 

% Run for 3 full cycles to let the transient dynamics settle
num_cycles = 3;
time_steps = 2000 * num_cycles; 
t = linspace(0, num_cycles * 2 * pi, time_steps);
E_field = 6.0 * sin(t); 

recorded_E = zeros(1, time_steps);
recorded_P = zeros(1, time_steps);
P_state = 0.0; 

for step = 1:time_steps
    E_t = E_field(step);
    % Your proprietary MAFA Core Equation - Unchanged to preserve scientific integrity
    thermo_force = E_t - (alpha1 * P_state) - (alpha11 * P_state^3) - (alpha111 * P_state^5);
    P_next = P_state + kappa * thermo_force;

    if P_next > 1.0, y_t = 1.0;
    elseif P_next < -1.0, y_t = -1.0;
    else, y_t = P_next;
    end

    P_state = P_next;
    recorded_E(step) = E_t;
    recorded_P(step) = y_t;
end

% =========================================================================
% 2. DISCARD TRANSIENTS (EXTRACT FINAL CLOSED LOOP FOR ANIMATION)
% =========================================================================
steady_start = 2000 * (num_cycles - 1) + 1;
stable_E = recorded_E(steady_start:end);
stable_P = recorded_P(steady_start:end);
stable_t = t(steady_start:end) - t(steady_start); % Relative time starting from 0
N_frames = length(stable_E);

% Reference baselines
E_axis = linspace(-6, 6, 2000);
y_tanh = tanh(E_axis);
y_sigmoid = 1 ./ (1 + exp(-E_axis));

% =========================================================================
% 3. CONFIGURING HIGH-QUALITY VIDEO WRITER FOR SUPPLEMENTARY MATERIAL
% =========================================================================
video_filename = 'MAFA_HighEnd_Visualization.avi'; % Changed extension to .avi
v = VideoWriter(video_filename, 'Motion JPEG AVI'); % Changed to a globally compatible profile
v.FrameRate = 60;  % Smooth 60 frames per second
v.Quality = 100;   % Maximum presentation quality
open(v);


% =========================================================================
% 4. CREATING THE ADVANCED DUAL-PANEL INFOGRAPHIC INTERFACE
% =========================================================================
% Opening figure with modern cinematic 16:9 aspect ratio dynamically adjusted
fig = figure('Color', 'w', 'Units', 'normalized', 'Position', [0.1, 0.1, 0.75, 0.55]);

% --- Left Subplot: Real-Time Waveform Input Profile ---
subplot(1, 2, 1);
h_input_line = plot(NaN, NaN, 'Color', [0.12, 0.53, 0.89], 'LineWidth', 2); hold on;
h_input_head = plot(NaN, NaN, 'ko', 'MarkerFaceColor', [0.12, 0.53, 0.89], 'MarkerSize', 6);
grid on; ax1 = gca; ax1.GridLineStyle = ':'; ax1.GridAlpha = 0.4;
ax1.FontName = 'Helvetica'; ax1.FontSize = 10;
xlabel('Relative Time (s)', 'FontSize', 11);
ylabel('Input Excitation Field ($\hat{E}_t$)', 'Interpreter', 'latex', 'FontSize', 11);
title('Input Stimulus Real-Time Profile', 'FontSize', 12, 'FontWeight', 'bold');
xlim([0, 2*pi]); ylim([-6.5, 6.5]);

% --- Right Subplot: Functional Geometry Space (Hysteresis Tracking) ---
subplot(1, 2, 2);
plot(E_axis, y_tanh, '--', 'Color', [0.6 0.6 0.6], 'LineWidth', 1.2, 'DisplayName', 'Classical Tanh'); hold on;
plot(E_axis, y_sigmoid, ':', 'Color', [0.4 0.4 0.4], 'LineWidth', 1.2, 'DisplayName', 'Classical Sigmoid');

% Dynamic visual elements for the Proposed MAFA operator
h_loop = plot(NaN, NaN, 'k-', 'LineWidth', 2.5, 'DisplayName', 'Proposed MAFA (Hysteretic)');
h_loop_head = plot(NaN, NaN, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'DisplayName', 'Current State');
h_arrow = text(0, 0, '', 'FontSize', 15, 'FontWeight', 'bold', 'Color', 'r', 'HorizontalAlignment', 'center');

% Live Dashboard Telemetry
h_text_stats = text(-5.8, 0.85, '', 'FontName', 'Courier', 'FontSize', 9.5, ...
    'BackgroundColor', [0.96 0.96 0.96], 'EdgeColor', [0.8 0.8 0.8]);

grid on; ax2 = gca; ax2.GridLineStyle = ':'; ax2.GridAlpha = 0.4;
ax2.FontName = 'Helvetica'; ax2.FontSize = 10;
xline(0, '--', 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5, 'HandleVisibility', 'off');
yline(0, '--', 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5, 'HandleVisibility', 'off');
xlabel('Normalized Virtual Input ($\hat{E}_t$)', 'Interpreter', 'latex', 'FontSize', 11);
ylabel('Activation Output / State Response ($\hat{P}_t$)', 'Interpreter', 'latex', 'FontSize', 11);
title('Functional Geometry Comparison Matrix', 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'southeast', 'FontSize', 9);
xlim([-6.2, 6.2]); ylim([-1.1, 1.1]);

% =========================================================================
% 5. DYNAMIC SYNCHRONIZED VISUAL RENDERING LOOP
% =========================================================================
frame_stride = 5; % Performance optimizer (plots every 5 steps for smooth pace)

for i = 1:frame_stride:N_frames
    % 1. Update live input signal telemetry (Left Panel)
    set(h_input_line, 'XData', stable_t(1:i), 'YData', stable_E(1:i));
    set(h_input_head, 'XData', stable_t(i), 'YData', stable_E(i));
    
    % 2. Update MAFA hysteresis geometric path trajectory (Right Panel)
    set(h_loop, 'XData', stable_E(1:i), 'YData', stable_P(1:i));
    set(h_loop_head, 'XData', stable_E(i), 'YData', stable_P(i));
    
    % 3. Calculate dynamic physical direction tracking (Vector Orientation arrows)
    if i > 1
        dE = stable_E(i) - stable_E(i-1);
        if dE > 0
            set(h_arrow, 'Position', [stable_E(i), stable_P(i)+0.09], 'String', '\rightarrow');
        else
            set(h_arrow, 'Position', [stable_E(i), stable_P(i)-0.09], 'String', '\leftarrow');
        end
    end
    
    % 4. Refresh continuous overlay metric logs
    stats_string = sprintf(' TELEMETRY DASHBOARD\n -------------------\n TIME:  %.2fs\n INPUT: %+.2f\n STATE: %+.2f', ...
        stable_t(i), stable_E(i), stable_P(i));
    set(h_text_stats, 'String', stats_string);
    
    drawnow; % Instantly render the graphic buffer
    
    % Capture current graphical frame state and commit to MP4 stream
    frame = getframe(fig);
    writeVideo(v, frame);
end

% Ensure the absolute final frame closes cleanly and seamlessly
set(h_input_line, 'XData', stable_t, 'YData', stable_E);
set(h_loop, 'XData', stable_E, 'YData', stable_P);
set(h_arrow, 'String', ''); % Dissolve vector guide on rest state
writeVideo(v, getframe(fig));

% Finalize file streams and close assets cleanly
close(v);
hold off;
fprintf('🎉 SUCCESS: Scientific dynamic simulation video rendered flawlessly as: "%s"\n', video_filename);
