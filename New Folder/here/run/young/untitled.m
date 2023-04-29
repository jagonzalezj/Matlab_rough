clc
close all
clear all
d = dir('*.def1.txt');
for i = 1:length(d)
    i
    % Get data
    fname = d(i).name;
    A = importdata(fname);
    strain = A.data(:,1);
    stress = A.data(:,2:4);
    
    mar=['r-';'b-';'g-';'k-']

    % Generate plot
    %plot(strain,stress(:,1),'-or','LineWidth',2,'MarkerEdgeColor','r',...
     %           'MarkerFaceColor','r','MarkerSize',5),hold on
    %plot(strain,stress(:,2),'-ob','LineWidth',2,'MarkerEdgeColor','b',...
    %            'MarkerFaceColor','b','MarkerSize',5),hold on
    plot(abs(strain),abs(stress(:,3)),mar(i),'LineWidth',3),hold on


    % Export figure to tif file
    %exportfig(gcf,strrep(fname,'.def1.txt','.tif'),'Format','tiff',...
    %'Color','rgb','Resolution',300)
    %close(1)

end
    legend('flat sample','b=1.6','b=2')
    legend boxoff
    axis square
   % ylim([0 10])
    set(gca,'LineWidth',2,'FontSize',24,'FontWeight','normal','FontName','Times')
    set(get(gca,'XLabel'),'String','Strain','FontSize',32,'FontWeight','bold','FontName','Times')
    set(get(gca,'YLabel'),'String','Stress (GPa)','FontSize',32,'FontWeight','bold','FontName','Times')
    set(gcf,'Position',[1 1 round(1000) round(1000)])