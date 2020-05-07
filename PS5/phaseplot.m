function a = phaseplot(odefun, xlimv, ylimv, xinit, T, varargin)
%PHASEPLOT   Phase plot for 2D dynamical systems
%
% PHASEPLOT('F', X1range, X2range) produces a quiver plot for the
% function 'F'.  X1range and X2range have the form [min, max, num]
% and specify the axis limits for the plot, along with the number
% of subdivisions in each axis, used to produce an quiver plot for
% the vector field.  
%
% The function 'F' should be the same for as used for ODE45.  Namely, it
% should be a function of the form dxdt = F(t,x) that accepts a state x of 
% dimension 2 and returns a derivative dxdt of dimension 2.
%
% PHASEPLOT('F', X1range, X2range, Xinit) produces a phase plot for
% the function 'F', consisting of the quiver plot plus stream lines.
% The streamlines start at the initial conditions listed in Xinit, 
% which should be a matrix whose rows give the desired inital
% conditions for x1 and x2.
%
% PHASEPLOT('F', X1range, X2range, boxgrid(X1range2, X2range2)) produces 
% a phase plot with stream lines generated at the edges of the rectangle
% defined by X1range2, X2range2.  These ranges are in the same form as
% X1range, X2range.
%
% PHASEPLOT('F', X1range, X2range, Xinit, T) produces a phase plot where
% the streamlines are simluted for time T (default = 50).
%
% PHASEPLOT('F', X1range, X2range, Xinit, T, P1, P2, ...) passes additional
% parameters to the function 'F', in the same way as ODE45.

% Written by Richard Murray, Fall 2002, based on a version by Kristi Morgansen
%
% 11 Oct 03, RMM: added parameters as additional arguments + dimen bug fix
%   * function now allows parameters in the same way as ODE45
%   * fixed bug with mesh dimensions caused by MATLAB length() behavior
%   * got completely frustrated with MATLAB as a psuedo-programming language

% Initialize the color grid
color = ['m', 'c', 'r', 'g', 'b', 'k', 'y'];

% Figure out the set of points for the quiver plot
[x1,x2] = meshgrid(xlimv(1):(xlimv(2)-xlimv(1))/xlimv(3):xlimv(2), ylimv(1):(ylimv(2)-ylimv(1))/ylimv(3):ylimv(2));

% Figure out if we have parameter arguments and create the required string
if (length(varargin) == 0)
  parms = '';
else
  parms = ', []';
  for (k = 1:length(varargin))
    parms = strcat(parms, sprintf(', %g', varargin{k}));
  end;
end;

% Now calculate the vector field at those points
[nr,nc] = size(x1);
for i = 1:nr
  for j = 1:nc
    eval(['dx(' num2str(i) ',' num2str(j) ',1:2) = ' ...
	odefun '(0, [' num2str(x1(i,j)) ' ' num2str(x2(i,j)) ']' parms ');']);
  end
end

% Plot the quiver plot
% clf; 
xy=quiver(x1,x2,dx(:,:,1),dx(:,:,2));
set(xy,'LineWidth',1);
a=gca; set(a,'DataAspectRatio',[1,1,1]);
set(a,'XLim',xlimv(1:2)); set(a,'YLim',ylimv(1:2));
xlabel('x_1'); ylabel('x_2','Rotation',0);

% See if we should also generate the streamlines
if (nargin < 4) return; end
  
% See if we were passed a simulation time
if (nargin < 5) T = 50; end

% Generate the streamlines for each initial condition
[nr, nc] = size(xinit);
for i = 1:nr
  [time, state] = ode45(odefun, [0 T], xinit(i,:), [], varargin{:});
  hold on;
  plot(state(:,1), state(:,2), color(mod(i-1, 7)+1));
end
set(a,'XLim',xlimv(1:2)); set(a,'YLim',ylimv(1:2));