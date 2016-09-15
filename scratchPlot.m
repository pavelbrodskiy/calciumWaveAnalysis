%% Clear the workspace
clearvars
close all
settings = prepareWorkspace();

        %--Distributions contain more information than boxplot can capture
        r = rand(1000,1);
        rn = randn(1000,1)*0.38+0.5;
        rn2 = [randn(500,1)*0.1+0.27;randn(500,1)*0.1+0.73];
        rn2=min(rn2,1);rn2=max(rn2,0);
        figure
        ah(1)=subplot(3,4,1:2);
        boxplot([r,rn,rn2])
        ah(2)=subplot(3,4,3:4);
        distributionPlot([r,rn,rn2],'histOpt',2); % histOpt=2 works better for uniform distributions than the default
        set(ah,'ylim',[-1 2])

        %--- additional options  

        data = [randn(100,1);randn(50,1)+4;randn(25,1)+8];
        subplot(3,4,5)

        %--- defaults
        distributionPlot(data); 
        subplot(3,4,6)

        %--- show density via custom colormap only, show mean/std,
        distributionPlot(data,'colormap',copper,'showMM',5,'variableWidth',false) 
        subplot(3,4,7:8)

        %--- auto-binwidth depends on # of datapoints; for small n, plotting the data is useful
        % note that this option requires the additional installation
        % of plotSpread from the File Exchange (link below)
        distributionPlot({data(1:5:end),repmat(data,2,1)},'addSpread',true,'showMM',false,'histOpt',2) 

        %--- show quantiles
        subplot(3,4,9),distributionPlot(randn(100,1),'showMM',6)

        %--- horizontal orientation
        subplot(3,4,10:11),
        distributionPlot({chi2rnd(3,1000,1),chi2rnd(5,1000,1)},'xyOri','flipped','histOri','right','showMM',0),
        xlim([-3 13])

        %--- compare distributions side-by-side (see also example below)
        % plotting into specified axes will throw a warning that you can
        % turn off using " warning off DISTRIBUTIONPLOT:ERASINGLABELS "
        ah = subplot(3,4,12);
        subplot(3,4,12),distributionPlot(chi2rnd(3,1000,1),'histOri','right','color','r','widthDiv',[2 2],'showMM',0)
        subplot(3,4,12),distributionPlot(chi2rnd(5,1000,1),'histOri','left','color','b','widthDiv',[2 1],'showMM',0)

        %--Use globalNorm to generate meaningful colorbar
        data = {randn(100,1),randn(500,1)};
        figure
        distributionPlot(data,'globalNorm',true,'colormap',1-gray(64),'histOpt',0,'divFactor',[-5:0.5:5])
        colorbar

        %--Use widthDiv to compare two series of distributions
        data1 = randn(500,5);
        data2 = bsxfun(@plus,randn(500,5),0:0.1:0.4);
        figure
        distributionPlot(data1,'widthDiv',[2 1],'histOri','left','color','b','showMM',4)
        distributionPlot(gca,data2,'widthDiv',[2 2],'histOri','right','color','k','showMM',4)

        %--Christmas trees!
          x=meshgrid(1:10,1:10);
          xx = tril(x);
          xx = xx(xx>0);
          figure
          hh=distributionPlot({xx,xx,xx},'color','g','addSpread',1,'histOpt',2,'showMM',0);
          set(hh{4}{1},'color','r','marker','o')
