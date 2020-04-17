%FX_DECON_DEMO: Demo for FX decon
%
%
%     -------------------------------------------
%         A demo showing how one can eliminate
%     random noise with FX - Decon (Canales method)
%
%                M.D.Sacchi, SeismicLab
%      -------------------------------------------
%
% FX deconvolution fits a linear prediction model
% (often called an autoregressive model) to 
% spatial data in the FX domain. The modeled data
% (data generated by the auto-regression) is the output
% of the process.
% 
% This demo uses the following SeismicLab functions:
%
%               readsegy.m
%               fx_decon.m
%               wigb.m
%               clip.m
%               seismic.m
%

clear all
close all;

% Read data 

  [D,H]=readsegy('data_with_noise.su');

  dtsec = H(1).dt/1000/1000;
  [nt,nx] = size(D);

  lf = 15;        % Operator length
  flow = 1;       % Min freq to process
  fhigh=120;      % Max freq to process
  mu = 0.01;      % trade-off parameter

% Apply FX filter

  D1 = fx_decon(D,dtsec,lf,mu,flow,fhigh);

% Display data before FX decon, after FX decon and estimated noise

  figure(1); 
  imagesc([1:1:3*nx],[0:1:nt-1]*dtsec,clip([D,D1,D-D1],50,50));
  colormap(seismic(1));

% Display as wiggles

  figure(2); 
  wigb([D,D1,D-D1],1,[1:1:3*nx],[0:1:nt-1]*dtsec);
  
