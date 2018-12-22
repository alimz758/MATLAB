clear all; close all; clc;

load 'Data7.mat';
periodocity= 2 * 10.^-5;

miu= 4*pi* 10.^-7;

numberOfParticles_x= 50; %number of desried particles for the x-axis
numberOfParticles_y=50; %number of desried particles for the y-axis
numberOfParticles_z=7;  %number of desried particles for the z-axis
moment= BigArray;
%point above surface
o_i=25*10^-6; %x
o_j=25*10^-6;%y
o_k=141*10^-6;%z

Btotal=[0 0 0];%initial value of Btotal

  
            point= [o_i o_j o_k]; % locating the point above the surface 
           
            for i = 1:numberOfParticles_x %x-axis
               for j=1:numberOfParticles_y %y-axis:
                  for k=1:numberOfParticles_z %z-axis 
                      
                          r2= periodocity.*[(i-0.5) (j-0.5) (k-0.5)];  %in this case would be the distance

                          distance=point - r2;
                          
                          
                          
                            distanceX=distance(1);
                            distanceY=distance(2);
                            distanceZ=distance(3);

                            syms X Y Z
                            r(X,Y,Z) = [X Y Z];
                            magR(X,Y,Z)=sqrt(X^2+Y^2+Z^2);
                            unitR(X,Y,Z)=r./magR;
                            A(X,Y,Z)= miu * cross(moment(i,j,k,3),unitR)/ (4 * pi * magR^2) ; %magnetic field portential formula
                            B(X,Y,Z)= curl(A, [X Y Z]); % finding B

                            Beval = eval(B(distanceX,distanceY,distanceZ));
                            Btotal=Beval+Btotal;
          
                  end
               end
            end
            
   
  
 
   
   
  
