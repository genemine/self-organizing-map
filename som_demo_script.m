clear;

addpath('./melikerion_1.2.1/source')
% import data
[data,header,id,gene]=readdata('SRP010262.som');





method=3;  % can be 1, 2, or 3;
%+++ pretreat data
for i=1:size(data,1)
      if method ==1 
        data(i,2:end)=data(i,2:end)-mean(data(i,2:end));
      elseif method==2
        data(i,2:end)=(data(i,2:end)-mean(data(i,2:end)))/std(data(i,2:end));
      elseif method==3
        data(i,2:end)=(data(i,2:end)-mean(data(i,2:end)))/mean(data(i,2:end));
      end
end
%+++ set map dimension
mapdim=[7,7];

% reesults directory
RDIR = './demo_result/';





% Construct self-organizing map.
sm = somcreate(data,header,mapdim);
[sm, bmus, zi] = somtrain(sm, data);

% Save best-matching units and imputed inputs.
if ~isdir(RDIR); mkdir(RDIR); end
ascprint([RDIR 'bmus.txt'], [id bmus], {'ID', 'ROW', 'COLUMN'});
ascprint([RDIR 'imputed_inputs.txt'], [id zi], {'ID', header{:}});

% Map diagnostics.
somvisproto(sm,[],[], RDIR);
somvisquality(sm, data, id, RDIR);

% Estimate dynamic range and statistical significance. Set the number of
% simulations to zero for input variables.
xstats = somtest(sm, bmus, data, 0);

% Create map colorings (component planes). You should always combine
% statistics for all variables and use a single function call to create
% the colorings; this way the colors will be comparable between variables.
somvisplane(sm, bmus, [data], {header{:}}, [xstats], RDIR);



