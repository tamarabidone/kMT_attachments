clear all
close all
clc

konN=0.05;
koffN=0.25;

konS=0.1;
koffS=0.2;
P=0.6;

figure
set (gcf, 'color', 'w');

  Tot_Rep=20;
      
        
for num_N=1:13
    num_S=num_N;
    count=0;
    for konS=0.0:0.05:0.2
        count=count+1;
        
        mat=zeros(Tot_Rep, 1000);
for rep=1:Tot_Rep
    
    ndc_80_pos(1:num_N)=1;
        ndc_80_status(1:num_N)=0;
        ska_pos(1:num_S)=1;
        ska_status(1:num_S)=0;
complex1_pos=1;
complex2_pos=1;
        for time=1:1:1000
    
    
    
                for nn=1:num_N
                    if (ndc_80_status(nn)==0)
                        if (konN*0.01>rand)
                            ndc_80_status(nn)=1;
                        end
        
    
                    else
                        if (P>rand)
                            ndc_80_pos(nn) =ndc_80_pos(nn)+1;
                        else
                            ndc_80_pos(nn) =ndc_80_pos(nn)-1;
                        end
                        
                        if (koffN*0.01>rand)
                            ndc_80_status(nn)=0;
                        end       
                    end
    
   
                end
    
                if (isnan(mean(ndc_80_pos(ndc_80_status>0)))==0)
            complex1_pos=mean(ndc_80_pos(ndc_80_status>0));
                
                end
            
                
               for ns=1:num_S
            if (ska_status(ns)==0)
                if (konS*0.01>rand)
                    ska_status (ns)=1;
                end
        
            else
                if (P>rand)
                    ska_pos(ns) =ska_pos(ns)+1;
                else
                    ska_pos(ns) =ska_pos(ns)-1;
                end
                if (koffS*0.01>rand)
                    ska_status(ns)=0;
                end       
            end

               end
    
               if (isnan(mean(ska_pos(ska_status>0)))==0)
            complex2_pos=mean(ska_pos(ska_status>0));
               end
               
               
               
               
               %positions update here
    ndc_80_pos(1:num_N)=mean([complex1_pos; complex2_pos]);
    ska_pos(1:num_N)=mean([complex1_pos; complex2_pos]);


mat(rep, time)=mat(rep,time)+(mean([mean(ndc_80_pos); mean(ska_pos)])*4*1E-3);

        end
end
   
sq=mean(mat.^2);
data(num_N, count)=sq(end);

end
end

data=(flipud(data));
[X,Y] = meshgrid(1:size(data,2), 1:size(data,1));

%// Define a finer grid of points
[X2,Y2] = meshgrid(1:0.01:size(data,2), 1:0.01:size(data,1));

%// Interpolate the data and show the output
outData = interp2(X, Y, data, X2, Y2, 'linear');
imagesc((outData./1));

%// Cosmetic changes for the axes

colorbar
ylabel ('# of Ndc80', 'fontsize', 38);
xlabel ('\it{k_o_n_,_S_k_a} (s^-^1)', 'fontsize', 38);
% xticks=0.5:3.5;
ylabels=({ '11','9', '7','5','3', '1'});
xlabels=({'0.05',' 0.1','0.15',' 0.2'});
set(gca,'XTickLabel', xlabels);
set(gca,'YTickLabel', ylabels);
caxis([0 0.4])
set (gca, 'linewidth', 4);
set (gca, 'fontsize', 32);
%saveas(gcf,'Fig2D_Ndc80_kska_on_per_10s_200rep.pdf')