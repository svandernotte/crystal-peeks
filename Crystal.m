%% CRYSTAL PEEKS : Classe
% Sur une idée originale de Xavier Tradiff
% 
% 20160408
% Sylvain Vandernotte

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
        function plot(cc, varargin)
            
            for c = cc
                
                if(isempty(c.g_handle)), c.create_graphics(varargin{:}) ; end
                
                c.update_graphics() ;
            end
            
        end
        
        %%
        function create_graphics(c, varargin)
            
            c.g_handle = plot(0, 0, varargin{:})  ;
            
        end
        
        %%
        function update_graphics(c)
            
            if( all(c.r_fixed) ), return ; end ; % crystal cannot grow anymore, no need to continue
            
            [x, y] = c.get_cartesian_points() ;
            
            set(c.g_handle, 'xdata', x, 'ydata', y) ;
            
        end
        
        %%
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
        
        %%
        function [x, y] = get_cartesian_points(c)
            
            t = c.points(1,:) ;
            r = c.points(2,:) ;
            x = r.*cos(t) + c.position(1) ;
            y = r.*sin(t) + c.position(2) ;
            
        end
        
        %%
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
        
    end
    
end