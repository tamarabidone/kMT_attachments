clear all
close all
clc

konN=0.05;
koffN=0.25;

konS=0.16;
koffS=0.2;

konC=0.25;
koffC=0.4;

P=0.6;

figure
set (gcf, 'color', 'w');

  Tot_Rep=500;
      

num_N=1;
num_S=1;
num_C=1;

        
       
        
cas =0;


for koffN=0.00:0.1:0.4
    cas=cas+1;
    
     mat=zeros(Tot_Rep, 1000);
for rep=1:Tot_Rep
    
    ndc_80_pos(1:num_N)=1;
        ndc_80_status(1:num_N)=0;
        ska_pos=1;
        ska_status=0;
        cdt_pos=1;
        cdt_status=0;
complex_pos=1;
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
            complex_pos=mean(ndc_80_pos(ndc_80_status>0));
                
                end
            
                for nn=1:num_S
            if (ska_status==0)
                if (konS*0.01>rand)
                    ska_status=1;
                end
        
            else
                if (P>rand)
                    ska_pos =ska_pos+1;
                else
                    ska_pos =ska_pos-1;
                end
                if (koffS*0.01>rand)
                    ska_status=0;
                end       
            end

                end
                
              ndc_80_pos(1:num_N)=mean([complex_pos; ska_pos]);
    ska_pos=mean([complex_pos; ska_pos]);
    
                for nn=1:num_C
            if (cdt_status==0)
                if (konC*0.01>rand)
                    cdt_status=1;
                end
        
            else
                if (P>rand)
                    cdt_pos =cdt_pos+1;
                else
                    cdt_pos =cdt_pos-1;
                end
                if (koffC*0.01>rand)
                    cdt_status=0;
                end       
            end

                end
    
    ndc_80_pos(1:num_N)=mean([complex_pos; ska_pos; cdt_pos]);
    cdt_pos=mean([complex_pos; ska_pos;cdt_pos]);


mat(rep, time)=mat(rep,time)+(mean([mean(ndc_80_pos); ska_pos; cdt_pos])*4*1E-3);

        end
        
        
end
   
sq(cas, :)=mean(mat.^2);
plot(0.01:0.01:10, sq(cas,:), 'r', 'linewidth', cas);
hold on

end

% legend('\it{k_o_f_f_,_N_d_c_8_0} = 0.0 s^-^1','\it{k_o_f_f_,_N_d_c_8_0} = 0.05 s^-^1','\it{k_o_f_f_,_N_d_c_8_0} = 0.1 s^-^1', '\it{k_o_f_f_,_N_d_c_8_0} = 0.15 s^-^1', '\it{k_o_f_f_,_N_d_c_8_0} = 0.2 s^-^1')
% legend('\it{k_o_f_f_,_S_k_a} = 0.0 s^-^1','\it{k_o_f_f_,_S_k_a} = 0.05 s^-^1','\it{k_o_f_f_,_S_k_a} = 0.1 s^-^1', '\it{k_o_f_f_,_S_k_a} = 0.15 s^-^1', '\it{k_o_f_f_,_S_k_a} = 0.2 s^-^1')
% legend('\it{k_o_f_f_,_C_d_t_1} = 0.0 s^-^1','\it{k_o_f_f_,_C_d_t_1} = 0.05 s^-^1','\it{k_o_f_f_,_C_d_t_1} = 0.1 s^-^1', '\it{k_o_f_f_,_C_d_t_1} = 0.15 s^-^1', '\it{k_o_f_f_,_C_d_t_1} = 0.2 s^-^1')
% 
% legend boxoff
set (gca, 'linewidth', 4, 'fontsize', 30);
xlabel ('Time (s)', 'fontsize', 40);
ylabel ('MSD (\mum^2)', 'fontsize', 40);
axis([0 10 0 0.05])
%saveas(gcf,'Fig3B.pdf')

