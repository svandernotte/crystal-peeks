%%CRYSTAL/PLOT Affichage du crystal
% Affiche le crystal dans la figure courante. 
%
%   objet.plot('nom_option', valeur_option, ...)
%   liste_objets.plot('nom_option', valeur_option, ...) 
%
% Les options sont les options graphiques classiques de Matlab. Les options
% sont prises en comptes au premier appel de la méthode. Les appels ensuite
% ne font que rafraichir la structure des graphiques créés.
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

function plot(cc, varargin)

for c = cc
    
    if(isempty(c.g_handle)), c.g_handle = create_graphics(varargin{:}) ; end
    
    update_graphics(c) ;
    
end

end

%%
function handle = create_graphics(varargin)

handle = plot(0, 0, varargin{:})  ;

end

%%
function update_graphics(c)

if( all(c.r_fixed) ), return ; end ; % crystal cannot grow anymore, no need to continue

[x, y] = c.get_cartesian_points() ;

set(c.g_handle, 'xdata', x, 'ydata', y) ;

end