%%%%%Code to make length a multiple of periodicity%%%%%%%
periodocity= 2 * 10.^-5;
Num_Px= 50; 
Num_Py= 50;
Num_Pz= 7;
RxL = periodocity * Num_Px;
RyL = periodocity * Num_Py;
RzL = periodocity * Num_Pz;

load 'Data7.mat';

%Calculates small array dimensions to figure out how to store into large
BigArray = zeros(Num_Px,Num_Py, Num_Pz,3);
storage = size(moment);
Small_Array_X = fix(storage(1) / 2);
Small_Array_Y = fix(storage(2) / 2);
Small_Array_Z = fix(storage(3) / 2);
ZX = 1;
ZY = 1;
ZZ = 1;
%the first three nested loop is for the origincount = 1;
%Puts small array value in large array and updates small array position
%Based on the dimensions of small array
  for o_i = 1:Num_Px %x-axis
     for o_j=1:Num_Py %y-axis:
        for o_k=1:Num_Pz%z-axis
            origin_vector= periodocity.*[o_i o_j o_k];
            BigArray(o_i,o_j,o_k,:) = moment(ZX,ZY,ZZ,:);% locating the origin 
            if(o_k > Small_Array_Z && o_k < (Num_Pz - Small_Array_Z))
                
            elseif(o_k > (Num_Pz - Small_Array_Z))
                ZZ = ZZ + 1;
                %BigArray(o_i,o_j,o_k) = smallArray(ZX,ZY,ZZ);
            else
                ZZ = ZZ + 1;
                %BigArray(o_i,o_j,o_k) = smallArray(ZX,ZY,ZZ);
                
            end
        end
            ZZ = 1;
            if(o_j > Small_Array_Y && o_j < (Num_Py - Small_Array_Y ))
               
            elseif(o_j > (Num_Py - Small_Array_Y))
              ZY = ZY + 1;
            else
              ZY= ZY + 1;   
            end
     end
           ZZ = 1;
           ZY = 1;
           if(o_i > Small_Array_X && o_i < (Num_Px - Small_Array_X ))
           elseif(o_i > (Num_Px - Small_Array_X))
                ZX = ZX + 1;
           else
                 ZX= ZX + 1;
           end
  end
  largeData = BigArray;
  save('Data7.mat', 'largeData', 'moment');
