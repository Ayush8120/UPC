rho_i = 5000 ; % impactor density in kg/m^3
L_0 = 500 ; % impactor diamater in m
v_0 = 17000 ; % impactor velocity in m/s
r = 2*10^3 ; % distance from impact in m
Phi_ignition_1Mt = 0.1 ; % ignition factor in Mt
rho_t = 2000 ; % target density in kg/m^3
E = 10^18 ; %kinetic energy/impact energy in J
%% factors
eta = 0.001 ; % luminous efficiency
p_x = 75000 ; % pressure at crossover point in Pa
r_x = 290 ; % crossover point in m
P_0 = 100000 ; % ambient pressure in Pa
c_0 = 330 ; % speed of sound (air) in m/s
g_E = 9.81 ; % gravitational acceleration in m/s
epsilon = 0.15 ; % fraction of impact energy conv. into wave energy
rho_water = 1020 ; % water density in kg/m^3
h_deep = 3688 ; % ocean depth in m
%% kinetic energy = impact energy (atmospheric entry is neglected)
% (calculate only if E is not given)
E = pi/12 *rho_i *L_0^3 *v_0^2 ;
%% fireball and thermal radiation
% fireball radius
R_f = 0.002* E^(1/3) ;
% thermal exposure
Phi = eta *E /2 /3.14 /r^2 ;
% ignition
Phi_ignition_E = Phi_ignition_1Mt *(E)^(1/6) ;
Phi = Phi_ignition_E;

%% airblast
% overpressure
p = E^(1/3)/10^4 *p_x *r_x /4 /r *(1+3*( E^(1/3)/10^4 *r_x /r )^1.3 ) ;
% wind peak velocity
u = 5 *p /7 /P_0 *c_0 /(1 +6*p/(7*P_0))^(0.5) ;
%% cratering
%crater diameter
D_fr = 1.8 *rho_t^(-1/3) *E^(1/4) *g_E^(-0.22) ;
%% seismic effects
% seismic wave energy
E_w = 10^(-4) *E ;
% magnitude
M_L = 0.67 *log10(E_w)-5.87 ;
if r<60000
M_eff = M_L - 0.0238*r *10^(-3) ;
elseif 60000 <= r < 700000
M_eff = M_L -0.0048*r*10^(-3) -1.1644 ;
else
M_eff = M_L -1.66 *log10(r*10^(-3)) -6.399 ;
end
%% water impacts
% cavity depth
d_cavity = 3.84* (epsilon /rho_water /g_E *E)^(1/4) ;
% wave amplitude
A_deep = d_cavity *(1+ 2*r/3/d_cavity)^(-1.53) ;
% run-up
h_up = 1.09 *A_deep.^(4/5) *h_deep^(1/5) ;
% run-in
h_in = 10 *sqrt(g_E *h_up) *(3/2 *d_cavity)^0.375 ;