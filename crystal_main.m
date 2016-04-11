%% CRYSTAL PEEKS : Script test principal
% Simulation de la croissance d'une dizaine de cristaux de type PEEKS. 
% Script pour le test du fonctionnement de la classe CRYSTAL
%
% See also CRYSTAL

% -------------------------------------------------------------------------
% « LICENCE BEERWARE » (Révision 42):
% Sylvain Vandernotte <svandernott@yahoo.fr> a créé ce fichier le 20160408.
% Tant que vous conservez cet avertissement,vous pouvez faire ce que vous
% voulez de ce truc. Si on se rencontre un jour et que vous pensez que ce
% truc vaut le coup, vous pouvez me payer une bière en retour. 
% Sylvain Vandernotte 
% -------------------------------------------------------------------------

%% Ràz workspace, mais garde des points bloquants (breakpoints)
s=dbstatus;
save('myBreakpoints.mat', 's');
clear all
clear classes
load('myBreakpoints.mat');
dbstop(s);
delete('myBreakpoints.mat') ;
clc ;

%% Initialisation graphique et affichage des crystaux à t=0

figure(1) ; clf ; hold on

nc = 20 ;
for i=1:nc, 
    
    crystals(i) = Crystal(  'position', 5*(2.*rand(2,1)-1), ...
                            'radius_init', .001) ; %#ok
                        
   crystals(i).plot('color', rand(1,3), 'linewidth', 2) ;

end ;

axis equal ;
a = 10 ;
axis([-a a -a a]) ;


%% Résolution : croissance sur 5 secondes

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