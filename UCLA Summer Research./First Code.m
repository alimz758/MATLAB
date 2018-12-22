clear all; close all; clc;

MH=[-9960.8611*1000/(4*pi)      -397.3354*1000;
    -7984.3444*1000/(4*pi)      -386.7742*1000;
    -6438.3562*1000/(4*pi)      -369.79*1000;
    -5420.7436*1000/(4*pi)      -346.3776*1000;
    -4559.6869*1000/(4*pi)      -299.4902*1000;
    -3502.9354*1000/(4*pi)      -203.5465*1000;
    -1154.5988*1000/(4*pi)      222.9949*1000;
    -587.0841*1000/(4*pi)       278.4313*1000;
    215.2642*1000/(4*pi)        310.3885*1000;
    1135.0294*1000/(4*pi)       335.9395*1000;
    3072.407*1000/(4*pi)        359.3028*1000;
    5479.4521*1000/(4*pi)       377.3078*1000;
    9843.4442*1000/(4*pi)       406.9417*1000;
    17181.51232*1000/(4*pi)     421.0031*1000];


periodocity= 2 * 10.^-5;
rad= 9 * 10.^-6;
volume = (4 *pi * rad^3)/3;
m=interp1(MH(:,1), MH(:,2),0);
moment= [0 0 volume*m ];
miu= 4*pi* 10.^-7;



H_o_total=[0 0 0]; %initial value for total mgnetic field


numberOfParticles= 3; %number of desried particles for the small array
H_in= zeros( numberOfParticles,numberOfParticles,numberOfParticles,3);


%the first three nested loop is for the origin
  for o_i = 1:numberOfParticles %x-axis
     for o_j=1:numberOfParticles %y-axis:
        for o_k=1:numberOfParticles %z-axis
            origin_vector= periodocity.*[o_i o_j o_k]; % locating the origin 
            
            for i = 1:numberOfParticles %x-axis
               for j=1:numberOfParticles %y-axis:
                  for k=1:numberOfParticles%z-axis 
                      if (o_i==i) && (o_j==j) && (o_k==k)%ignore origin_vector
                         continue;
                      else
                          r2= periodocity.*[i j k];  %in this case would be the distance

                          distance=origin_vector - r2;
                          
                          %just take 4 neighbors particles into the account
                          if abs(distance) > 4 * periodocity *[1 1 1]
                              continue;
                          else    
                            distanceX=distance(1);
                            distanceY=distance(2);
                            distanceZ=distance(3);

                            syms X Y Z
                            r(X,Y,Z) = [X Y Z];
                            magR(X,Y,Z)=sqrt(X^2+Y^2+Z^2);
                            unitR(X,Y,Z)=r./magR;
                            A(X,Y,Z)= miu * cross(moment,unitR)/ (4*pi* magR^2) ; %magnetic field portential formula
                            B(X,Y,Z)= curl(A, [X Y Z]); % finding B

                            Beval = eval(B(distanceX,distanceY,distanceZ));
                            
                            H_o = Beval / miu;
                            H_o_total = transpose(H_o) + H_o_total; % magnetic field for one particle due its neighbors

                          end
                      end
                  end
               end
            end
            
            H_in(o_i,o_j,o_k,:) = [0 0 1276320] - ([0 0 382896] .* [1/3 1/3 1/3]) + H_o_total;
            H_o_total=[0 0 0];
        end
     end
  end
  
  
  %total moment for all 27 particles
  moment=zeros(numberOfParticles,numberOfParticles,numberOfParticles,3);
   for i = 1:numberOfParticles %x-axis
        for j=1:numberOfParticles %y-axis:
           for k=1:numberOfParticles %z-axis d
               moment(i,j,k,:)= interp1(MH(:,1), MH(:,2), H_in(i,j,k,:));  
           end
        end
   end
   
