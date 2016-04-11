%%CRYSTAL Classe pour la simulation d'un crystal PEEKS
%
% Le but est de simuler la croissance et l'évolution 
% des crystaux de type PEEKS (je ne sais pas si c'est 
% la bonne définition...) dans un environnement 2D restreint.
% Sur une idée originale de Xavier Tradif.
% 
% Constructeur : 
%  objet = Crystal('nom_option', valeur_option, ...) ;
%  
% Options : 
%  position :         position initiale [x y].' dans l'environnement ; default : [0 0].'
%
%  np_init :          nombre initial de points formant la frontière, default : 16
%
%  radius_init :      rayon initial du crystal, default : 1
%  
%  grow_rate :        taux de croissance initial, (i.e. augmentation du rayon 
%                     selon le temps) ; default : .5
%
%  max_segment_size : distance maximale entre deux points de la frontière, 
%                     contrôle la création de nouveaux points sur la frontière ;
%                     default : .2
%
% See also : CRYSTAL/PLOT CRYSTAL/UPDATE CRYSTAL/CHECK_COLLISIONS
%

% -------------------------------------------------------------------------
% « LICENCE BEERWARE » (Révision 42):
% Sylvain Vandernotte <svandernott@yahoo.fr> a créé ce fichier le 20160408.
% Tant que vous conservez cet avertissement,vous pouvez faire ce que vous
% voulez de ce truc. Si on se rencontre un jour et que vous pensez que ce
% truc vaut le coup, vous pouvez me payer une bière en retour. 
% Sylvain Vandernotte 
% -------------------------------------------------------------------------

classdef Crystal < hgsetget
    %%
    properties
        
        position % 2D
        
        points % polar
        np_init
        radius_init
        
        grow_rate
        max_segment_size
        
        r_fixed
        
        g_handle
        
    end
    
    %%
    methods
        %%
        function c = Crystal(varargin)
            
            % defaults
            c.np_init = 16 ;
            c.radius_init = 1 ;
            
            c.grow_rate = .5 ;
            c.max_segment_size = .2 ;
            
            c.position = [0;0] ;
            
            % Parsing user inputs
            for i=1:2:length(varargin)
                pn = varargin{i} ;
                pv = varargin{i+1} ;
                if isprop(c,pn),
                    set(c,pn,pv)
                end
            end
            
            % class vars
            c.points = [...
                linspace(0,2*pi,c.np_init) ;
                c.radius_init.*ones(1,c.np_init) ] ;
            
            c.r_fixed = false(1,c.np_init) ;
            
            
        end                
                
        
        %%
        function [x, y] = get_cartesian_points(c)
            
            t = c.points(1,:) ;
            r = c.points(2,:) ;
            x = r.*cos(t) + c.position(1) ;
            y = r.*sin(t) + c.position(2) ;
            
        end                
        
    end
    
end
