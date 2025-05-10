%% Init
% run('tapas_init.m')
% tapas_init

%% Example data
% tapas_download_example_data()
% direct download: https://www.tapas.tnu-zurich.com/examples_v6.1.0.zip

%% Load example data
%% HGF Toolbox Demo
%% Load binary input
% First, we will load the example binary inputs $u$ provided in the file example_binary_input.txt:

% u = load('HGF/example_binary_input.txt');
%% 
% The inputs are simply a time series of 320 0s and 1s. This is the input sequence 
% used in the task of Iglesias et al. (2013), _Neuron_, *80*(2), 519-530.

% scrsz = get(0,'ScreenSize');
% outerpos = [0.2*scrsz(3),0.7*scrsz(4),0.8*scrsz(3),0.3*scrsz(4)];
% figure('OuterPosition', outerpos)
% plot(u, '.', 'Color', [0 0.6 0], 'MarkerSize', 11)
% xlabel('Trial number')
% ylabel('u')
% axis([1, 320, -0.1, 1.1])
%% Find Bayes optimal parameter values
% Now let's use the fitModel function to find the 'Bayes optimal' perceptual 
% parameters for this dataset under the binary HGF model. By Bayes optimal we 
% mean the particular parameter values that produce the least cumulative Shannon 
% surprise for a given input sequence $u$. This means that an agent using this 
% parameter setting would experience the least possible surprise when exposed 
% to the given inputs under the given perceptual model.
% 
% The point of estimating the optimal parameter values is that we can use them 
% as prior means when fitting observed responses. If the agents whose response 
% we're observing are reasonably well able to perform their task, we may assume 
% that their parameter values are distributed around the optimal values.
% 
% We provide fitModel with four arguments.
%% 
% * The first argument, which would normally be the observed responses, is empty 
% (ie, []) here because the optimal parameter values are independent of any responses.
% * The second argument is the inputs _u._
% * The third argument is the perceptual model, _hgf_binary_ here. We need to 
% use the prefix 'tapas_' and the suffix '_config' in order to find the correct 
% configuration file
% * The fourth argument is the response model, _bayes_optimal_binary_ here. 
% Again we need to use the same prefix and suffix. In fact, bayes_optimal_binary 
% is a kind of pseudo-response model because instead of providing response probabilities 
% it simply calculates the Shannon surprise elicited by each new input given the 
% current perceptual state.
% * The fifth argument is the optimization algorithm to be used, _quasinewton_optim_ 
% here, which is a variant of the Broyden-Fletcher-Goldfarb-Shanno (BFGS) algorithm.

% bopars = tapas_fitModel([],...
%                          u,...
%                          'tapas_hgf_binary_config',...
%                          'tapas_bayes_optimal_binary_config',...
%                          'tapas_quasinewton_optim_config');
% 
% % [est, out] = tapas_fitModel(y, u, c_prc, c_obs);
% 
% % Simulate responses
% % Next, we simulate an agent's responses using the simModel function. To do that, we simply choose values for . Here, we take  and  . But in addition to the perceptual model hgf_binary, we now need a response model. Here, we take the unit square sigmoid model, unitsq_sgm, with parameter . The last argument is an optional seed for the random number generator.
% sim = tapas_simModel(u,...
%                      'tapas_hgf_binary',...
%                      [NaN 0 1 NaN 1 1 NaN 0 0 1 1 NaN -2.5 -6],...
%                      'tapas_unitsq_sgm',...
%                      5,...
%                      123456789);




%% 

%% 

%% 


% % 5) 파라미터 추정
% [est, out] = tapas_fitModel(y, u, c_prc, c_obs);


% % 6) 시뮬레이션: 추정 파라미터로부터 상태 추정 궤적 생성
% traj = tapas_simModel(u, ...
%                      'tapas_hgf_binary', est.prc_prc, ...
%                      'tapas_unitsq_sgm', est.prc_obs);
% % 7) 시각화: 각 레벨의 mu_hat, sigma_hat 궤적 그림
% %    함수 이름은 모델마다 다르며, 여기서는 categorical 타입 예시
% tapas_hgf_categorical_plotTraj(traj);   % 혹은 tapas_hgf_binary_plotTraj(traj)


% u = fifties; 
% est1 = tapas_fitModel([],...     %leave empty to sim responses
%                      u,...
%                     'tapas_hgf_binary_config',...
%                      'tapas_bayes_optimal_config',...
%                     'tapas_quasinewton_optim_config')

tapas_hgf_binary_plotTraj(est1)