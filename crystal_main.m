%% CRYSTAL PEEKS : Programme principal

s=dbstatus;
save('myBreakpoints.mat', 's');
clear all
clear classes
load('myBreakpoints.mat');
dbstop(s);
delete('myBreakpoints.mat') ;
clc ;

%%

figure(1) ; clf ; hold on

nc = 20 ;
for i=1:nc, 
    crystals(i) = Crystal(  'position', 5*(2.*rand(2,1)-1), ...
                            'radius_init', .001) ; %#ok
                        
   crystals(i).plot('color', rand(1,3)) ;

end ;


axis equal ;
a = 10 ;
axis([-a a -a a]) ;


%%

tStep = .01 ;
tEnd = 5 ;
tt = 0:tStep:tEnd ;
nt = length(tt) ;

for i=1:nt,
    
    crystals.update(tStep) ;
    
    crystals.check_collisions() ;
    
    crystals.plot() ;
    drawnow() ;
    
end