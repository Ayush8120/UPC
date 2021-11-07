clear all;
close all;
% underwater deep explosions
%h = 0.142302495*sqrt(E)
%h - full height of wave above level of undisturbed ocean
% small bodies - height of wave is proportional to Rp^1.5
%D - density
%V- velocity
%ADia - 
%Vimp - 
%CDia - 
%6.256 e-8 D^3(m) * v^2(Km/s) * Density(g/cm3) 
% 1 MT of TNT - 
v = 20; %km/s
%vSI = 20000
pho = 3.1; %might change
%phoSI = 3100
Dia = linspace(10,1200,120);
energy = 6.256e-8*(Dia.^3)*(v^2)*(pho); %Verified to be true

%energySI = pi*phoSI*(Dia.^3)*(vSI^2)/12;
%energy2 = 4.184e15*energySI
EAR = .9;

%book_formula(1000,energy)
%pratyush_formula(1000, energy)
%two(1000,energy, v, pho)
epsil = 0.15;
phow = 1020 % kg/m3
%g - acc due to gravity
g = 9.81;
%E - impact energy - Joules

three(1000, energy, 0.15 , phow, g)
%trial
function [tidal_height] = pratyush_formula(distance, energy, EAR)
%needs coversion to TNT ; this is wrong 
tidal_height = 10.9*((distance)^(-0.717))*((energy.*EAR).^0.495);
Dia = linspace(10,1200,120);

plot(Dia, tidal_height)
end

function [tidal_height] = book_formula(distance, energy, EAR)

tidal_height = 0.142302495*sqrt(energy.*EAR);
end



function [tidal_height] = two(distance, energy, v , pho)
%tidal height at a distance of 1000Km
%energy impact factor independent
Dia = linspace(10,1200,120);
tidal_height = 1.0081e-5*((Dia.^3)*(v^2)*(pho)).^0.54

plot(Dia, tidal_height)
end


function [run_up_height] = three(distance , energy , EAR, phow, g )
energy = energy.*(4.184e15); % converting to Joules 
dcavity = 3.84*(EAR/(phow*g))^0.25.*(energy.^0.25)

temp_2 = (dcavity.*3);
temp_2 = temp_2/(2*distance*1000);
temp = (1 + (1./temp_2)).^-1.53;
Adeep = dcavity.*temp
Dia = linspace(10,1200,120);
%plot(Adeep, Dia)
hdeep = 5000;
hup = 1.09* (Adeep.^0.8) .* (hdeep.^0.2)

%plot(Dia, hup);
%hold on 
plot(Dia, dcavity)
end


function [ans] = trial()
R = linspace(5,600,120);
phow = 1020
V = 20000
epsil = 0.15
dcavity = (((8*epsil*(V^2))/(9*phow*9.81))^(0.25))*((R).^0.75)
plot(R, dcavity)
hold on

temp_2 = (dcavity.*3);
temp_2 = temp_2/(2*1000*1000);
temp = (1 + (1./temp_2)).^-1.53;
Adeep = dcavity.*temp
Dia = linspace(10,1200,120);
%plot(Adeep, Dia)
hdeep = 5000;
hup = 1.09* (Adeep.^0.8) .* (hdeep.^0.2)
plot(Dia, hup)
end