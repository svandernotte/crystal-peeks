%%CRYSTAL/CHECK_COLLISIONS Chevauchement des crystaux
% Vérifient si, après une mise à jour, deux crystaux dans la liste ne se
% chevauchent pas. Si oui, alors les points des deux frontières de chaque
% crystal seront figés et ne seront plus candidats à la croissance.
%
% liste_objets.check_collisions()
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

function check_collisions(cc)

nc = length(cc) ;

for i=1:nc,
    
    [xi, yi] = cc(i).get_cartesian_points() ;
    
    for j=i+1:nc,
        
        [xj, yj] = cc(j).get_cartesian_points() ;
        
        points_of_j_in_i = inpolygon(xj, yj, xi, yi) ;
        if( any(points_of_j_in_i) )
            cc(j).r_fixed(points_of_j_in_i) = true ;
            
            points_of_i_in_j = inpolygon(xi, yi, xj, yj) ;
            cc(i).r_fixed(points_of_i_in_j) = true ;
        end
        
    end
end

end