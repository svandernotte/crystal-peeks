%%CRYSTAL/UPDATE Mise à jour de l'état du crystal
% Applique le taux de croissance pour une itération. Doit être suivi d'un
% appel de la méthode CHECK_COLLISIONS.
% 
%   objet.update(DT)
%   liste_objets.update(DT)
%
% DT : intervalle de temps pour une itération
%
% See also CRYSTAL CRYSTAL/CHECK_COLLISIONS

% -------------------------------------------------------------------------
% « LICENCE BEERWARE » (Révision 42):
% Sylvain Vandernotte <svandernott@yahoo.fr> a créé ce fichier le 20160408.
% Tant que vous conservez cet avertissement,vous pouvez faire ce que vous
% voulez de ce truc. Si on se rencontre un jour et que vous pensez que ce
% truc vaut le coup, vous pouvez me payer une bière en retour. 
% Sylvain Vandernotte 
% -------------------------------------------------------------------------

function update(cc, tStep)

for c = cc,
    
    if( all(c.r_fixed) ), continue ; end ; % crystal cannot grow anymore, no need to continue
    
    np = size(c.points,2) ;
    c.points(2,:) = c.points(2,:) ...
        + c.grow_rate.*tStep.*ones(1,np).*~c.r_fixed ;
    
    t = c.points(1,:) ;
    r = c.points(2,:) ;
    x = r.*cos(t) ;
    y = r.*sin(t) ;
    
    new_points = [] ;
    
    for i=1:np-1,
        Xi = [x(i) y(i)]' ;
        Xip1 = [x(i+1) y(i+1)]' ;
        
        if(norm(Xip1-Xi)>=c.max_segment_size), % then add a point between i and i+1
            new_points = [new_points ...
                [   sum(t([i i+1]))/2 ;...
                sum(r([i i+1]))/2 ]      ] ;
        end
    end
    
    if(~isempty(new_points))
        
        c.r_fixed = [c.r_fixed false(1,size(new_points,2))] ;
        c.points = [c.points new_points] ;
        
        [~, idx] = sort(c.points(1,:)) ;
        c.points = c.points(:,idx) ;
        c.r_fixed = c.r_fixed(:,idx) ;
        
    end
end

end