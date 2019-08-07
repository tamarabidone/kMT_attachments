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

  Tot_Rep=1000;
      
for cas=1:3
    switch cas
        case 1
num_N=1;
num_S=0;
num_C=0;

        case 2
num_N=1;
num_S=1;
num_C=0;  

        case 3
num_N=1;
num_S=1;
num_C=1;
    end
        
        mat=zeros(Tot_Rep, 30000);
        
        
for rep=1:Tot_Rep
    
    ndc_80_pos(1:num_N)=1;
        ndc_80_status(1:num_N)=0;
        ska_pos(1:num_S)=1;
        ska_status(1:num_S)=0;
        cdt_pos(1:num_C)=1;
        cdt_status(1:num_C)=0;
complex1_pos=1;
complex2_pos=1;
complex3_pos=1;
F=0;
        for time=1:1:30000
    
    F=F+0.1*rand;
    
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
                        
        
                    end
    
   
                end


               
            
                for nn=1:num_S
            if (ska_status(nn)==0)
                if (konS*0.01>rand)
                    ska_status(nn)=1;
                end
        
            else
                if (P>rand)
                    ska_pos(nn) =ska_pos(nn)+1;
                else
                    ska_pos(nn)=ska_pos(nn)-1;
                end
                if (koffS*0.01>rand)
                    ska_status(nn)=0;
                end       
            end

                end
                



            
    
                for nn=1:num_C
            if (cdt_status==0)
                if (konC*0.01>rand)
                    cdt_status(nn)=1;
                end
        
            else
                if (P>rand)
                    cdt_pos (nn)=cdt_pos(nn)+1;
                else
                    cdt_pos(nn) =cdt_pos(nn)-1;
                end
                if (koffC*0.01>rand)
                    cdt_status(nn)=0;
                end       
            end

                end

        



B=length((ndc_80_status>0))+length((ska_status>0)+length((cdt_status>0)));

F=F/B;

koffN=(0.25*exp(F/3));
koffS=(0.2*exp(F/3));
koffC=(0.4*exp(F/3));

F=F*B;
            for nn=1:num_N
                    if (ndc_80_status(nn)==1)
                      if (koffN*0.01>rand)
                            ndc_80_status(nn)=0;
                        end 
                      end
             end

            for nn=1:num_S
                    if (ska_status(nn)==1)
                      if (koffS*0.01>rand)
                            ska_status(nn)=0;
                        end 
                      end
             end

            for nn=1:num_C
                    if (cdt_status(nn)==1)
                      if (koffC*0.01>rand)
                            cdt_status(nn)=0;
                        end 
                      end
             end

 if (isnan(mean(ndc_80_pos(ndc_80_status>0)))==0)
            complex1_pos=mean(ndc_80_pos(ndc_80_status>0));
                
                end
  if (isnan(mean(ska_pos(ska_status>0)))==0)
            complex2_pos=mean(ska_pos(ska_status>0));
                
                end
if (isnan(mean(cdt_pos(cdt_status>0)))==0)
            complex3_pos=mean(cdt_pos(cdt_status>0));
                
                end
    
      ndc_80_pos(1:num_N)=mean([complex1_pos; complex2_pos; complex3_pos]);
    ska_pos(1:num_S)=mean([complex1_pos; complex2_pos; complex3_pos]);
    cdt_pos(1:num_C)=mean([complex1_pos; complex2_pos; complex3_pos]);
mat(rep, time)=mat(rep,time)+(mean([complex1_pos; complex2_pos; complex3_pos])*4*1E-3);

        end
        
     
end
   
sq(cas, :)=mean(mat.^2);
dev(cas)=std(mat(:,end).^2);
data(cas)=sq(cas, end);

cas
end
figure


h=bar (data*1E6);
xtickangle(45)
xlabels=({'Ndc80', 'Ndc80-Ska','Ndc80-Ska-Cdt1'});
hold on
errorbar(1:3, data*1E6, dev*1E6, 'ok ', 'linewidth',2)
set(gca,'XTickLabel', xlabels);
set (gcf, 'color', 'w');
set (h,'Facecolor', [0.7 0.7 0.7]);
set (gca, 'linewidth', 4, 'fontsize', 30);
ylabel ('MSD (nm^2)', 'fontsize', 40);
pbaspect([2 1 1])
%saveas(gcf,'Fig4C_2.pdf')
