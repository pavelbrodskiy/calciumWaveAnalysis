% This script takes all of the information needed to generate figures and
% calls other scripts that make those figures. To use, just uncomment the
% relevant line in the "Make figures" section and run the script. The
% figures can be found in: /Output/#dateAndTime#/figureName.png

%% Clear the workspace
clearvars
close all
settings = prepareWorkspace();

%% Parameter declaration (Migrate to here. Currently described in each module)
% keepCat = categorical({'control'});

%% Initialization
[labels, category, catFinal] = getLabels(settings);

%% Get data
structMaps = getSpatialMaps(labels, settings); % Spatial map
pouchSizes = getPouchSizes(labels, settings);
axesMat = getAxes(labels, settings);

for i = 1:length(labels)
    load([settings.thruMask labels{i}, '.mat'])
    maskMat{i} = rotMask;
end
    
settings.outRough = [settings.outRough settings.uniqueIdentifier filesep];
mkdir(settings.outRough);

%% Make figures
close all
% isoSurfaces = figIsosurfaces(settings, category, labels);
% PSDComparison = figComparePSDs(settings, labels, catFinal, tableToCategories({'Fig4_GraphLite'}, settings));
% eigenmodeAnalysis = eigenmodeReport(labels, settings);
% reportMetadata = generateReport(structMaps, settings, catFinal, labels, unique(catFinal));
% mapCutoffs = imgSpatialMap(structMaps, settings, catFinal', unique(catFinal)');
% controlCutoffs = imgSpatialMap(structMaps, settings, catFinal', categorical({'control'}), [-inf,(13:2:21)*10^3, inf], pouchSizes);
% reportMetadata = generateReport(structMaps, settings, catFinal, labels, unique(catFinal));
% dataIP3RFig = graphsFromSpreadsheet(structMaps, 'IP3R_Graph', catFinal, settings);
% dataControlFig = figControlComposites(structMaps, labels, settings, catFinal);
% dataHhFig = graphsFromSpreadsheet(structMaps, 'Fig4_Graph', catFinal, settings);
% dataAllSpatialMaps2 = figAllComposites(structMaps, settings, category);
% dataRawVsComposite = figCompareRawAndComposite(structMaps, settings, catFinal, '1320 ptc RNAi', labels);
% dataAllSpatialMaps1 = figAllComposites(structMaps, settings, catFinal);
% mapCutoffs = imgSpatialMap(structMaps, settings, catFinal, cats);
% dataSmoRNAiSizeFig = figSizeBinComposites(structMaps, labels, settings, category, categorical({'smo-'}));
% dataSmoSpatialMaps1 = figSmoComposites(structMaps, settings, catFinal);
% dataRawVsComposite1 = figCompareRawAndComposite(structMaps, settings, catFinal, '429 smo RNAi', labels);
% dataRawVsComposite2 = figCompareRawAndComposite(structMaps, settings, catFinal, '430 smo RNAi', labels);
% dataRawVsComposite3 = figCompareRawAndComposite(structMaps, settings, catFinal, '431 smo RNAi', labels);
% dataRawVsComposite4 = figCompareRawAndComposite(structMaps, settings, category, 'smo CA', labels);
% dataRawVsComposite5 = figCompareRawAndComposite(structMaps, settings, category, 'smo-', labels);

activeCats = categorical({'control','430 smo RNAi','Bl46022 smo CA'})';
settings.AP = spatialCutoffs(axesMat, maskMat, settings, false);
graphData = figCompareAP(structMaps, 'SmoCompareAP', catFinal, activeCats, settings);

% % % settings.AP = spatialCutoffs(axesMat, maskMat, settings, true);
% % % metadata.threeRegions = graphRawData(structMaps, 'Fig4_Graph_Strip', catFinal, tableToCategories({'Fig4_GraphLite','IP3R_Graph'}, settings), settings);
% % % metadata.threeRegionsControl = graphRawData(structMaps, 'Fig3_Graph_Strip', catFinal, categorical({'control'}), settings, [-inf,(13:2:19)*10^3, inf], pouchSizes);
% % % settings.AP = spatialCutoffs(axesMat, maskMat, settings, false);
% % % metadata.twoRegions = graphRawData(structMaps, 'Fig4_Graph', catFinal, tableToCategories({'Fig4_GraphLite','IP3R_Graph'}, settings), settings);
% % % metadata.twoRegionsControl = graphRawData(structMaps, 'Fig3_Graph', catFinal, categorical({'control'}), settings, [-inf,(13:2:21)*10^3, inf], pouchSizes);
% % % metadata.scatter = graphSsRegression(structMaps, 'ControlScatter', catFinal, categorical({'control'}), settings, pouchSizes);
% % % save([settings.outRough 'metadata.mat'], 'metadata')

% settings.fieldNames = {'AmpNorm','PeakRate'}';
% settings.AP = spatialCutoffs(axesMat, maskMat, settings, true);
% metadata.threeRegions = graphRawData(structMaps, 'Smo1', catFinal, activeCats, settings);
% metadata.scatter = graphSsRegression(structMaps, 'Smo2', catFinal, activeCats, settings, pouchSizes);
% save([settings.outRough 'metadata.mat'], 'metadata')


return























% Future modules:
% Statistical analysis
% Graphs for multiple categories
% Graphs for control data
cats = unique(catFinal);
for i = 1:length(cats)
    dataRawVsComposite = figCompareRawAndComposite(structMaps, settings, catFinal, char(cats(i)), labels);
    disp(['n = ' num2str(sum(catFinal==cats(i))), ', ', char(cats(i))]);
end

% %%
% sizes = getPouchSizes(labels, settings);
% 
% gAll = eigenmodeAnalysis.G;
% eigenStack = eigenmodeAnalysis.Eigenstack;
% 
% [~, idx] = sort(sizes);
% gAll = gAll(idx);
% eigenStack = eigenStack(idx);
% 
% subplot(7,6,1);
% plot(gAll{1}(:,1),gAll{1}(:,2))
% xlabel('1st Eigenmode')
% ylabel('2nd Eigenmode')
% 
% for i = 1:length(gAll)
%     g = gAll{i};
%     subplot(7,6,i+2);
%     plot3(g(:,1),g(:,2),g(:,3))
%     
%     rotate3d
% %     axis off
% end
% return
% print('-fillpage','FillPageFigure','-dpdf')
% %%
% close all
% for i = 1:37
%     tmp = eigenStack{i};
%     eigenStack{i} = tmp(:,:,1);
% end
% a = padStack(eigenStack);
% for i = 38:42
%     a{i} = a{1} * 0;
% end
% tmp = [a{1} * 0, a{1} * 0, cat(2,a{1:5})];
% for i = 6:7:length(gAll)
%     tmp = cat(1,tmp, cat(2, a{i:(i+6)}));
% end
% tmp(isnan(tmp)) = 0;
% imshow(tmp,prctile(tmp(:),[1,99]))
% % for i = 1:length(gAll)
% %     tmpStack = eigenStack{i};
% %     subplot(7,6,i+2);
% %     imshow(tmpStack(:,:,1), []);
% % end
% print('-fillpage','FillPageFigure2','-dpdf')
% 
% close all
% 
% 
% return








%% Make graphs
close all
figure
subplot(2,2,1)
scatter(dataControlFig.discSize, dataControlFig.medianArray{1})
% regstats(dataControlFig.discSize, dataControlFig.medianArray{1},'quadratic', 'rsquare')
subplot(2,2,2)
scatter(dataControlFig.discSize, dataControlFig.medianArray{2})
% regstats(dataControlFig.discSize, dataControlFig.medianArray{2},'quadratic', 'rsquare')
subplot(2,2,3)
scatter(dataControlFig.discSize, dataControlFig.medianArray{3})
axis([-inf, inf, 0, 200])
% regstats(dataControlFig.discSize, dataControlFig.medianArray{3},'quadratic', 'rsquare')
subplot(2,2,4)
scatter(dataControlFig.discSize, dataControlFig.medianArray{4})
% regstats(dataControlFig.discSize, dataControlFig.medianArray{4},'quadratic', 'rsquare')


%% Figure 2C: graphs of summary stats in control by pouch size
if doFigure2C
    roundCutoffs = roundsd(cutoffs,2);
    sizeRanges{1} = ['< ' num2str(roundCutoffs(1)) '\mum^2'];
    for i = 2:(length(cutoffs))
        sizeRanges{i} = [num2str(roundCutoffs(i - 1)) ' to ' num2str(roundCutoffs(i))  '\mum^2'];
    end
    sizeRanges{end + 1} = ['> ' num2str(roundCutoffs(end)) '\mum^2'];
    
    sizeRanges = categorical(sizeRanges);
    
    pIN.controlLabel = sizeRanges(round(sizeBins/2));
    pIN.textAngle = 90;
    pIN.signifiganceCutoffs = [0.05, 0.01, 0.005];
    pIN.colorList = {'black','red','blue','green','magenta','cyan','yellow'};
    pIN.normalize = false;
    pIN.tTest = false;
    pIN.reSort = false;
    pIN.supercategories = [];
    pIN.labels = cellstr(char(sizeRanges));
    pIN.listN = false;
    
    for i = 1:length(fieldNames)
        close all
        for k = unique(catSizeBin)
            imageArray = {controlStructMaps.(fieldNames{i})};
            imageArray([catSizeBin ~= k]) = [];
            means{k} = cellMean(imageArray);
        end
        
        hFig = figureBarGraph(sizeRanges, means, pIN);
        ylabel(fieldLabels{i});
        
        set(gcf, 'PaperPositionMode', 'auto');
        print([settings.outRough, settings.uniqueIdentifier, fieldNames{i}, 'ControlGraph.png'],'-dpng','-r300');
        close;
    end
end

%% Figure 3A: graphs of summary stats by gene
if doFigure3A
    [catList, cadIdx] = unique(category);
    
    pIN.controlLabel = 'control';
    pIN.textAngle = 90;
    pIN.signifiganceCutoffs = [0.05, 0.01, 0.005];
    pIN.colorList = {'black','red','blue','green','magenta','cyan','yellow'};
    pIN.normalize = true;
    pIN.tTest = false;
    pIN.reSort = true;
    pIN.supercategories = superCategories(cadIdx);
    pIN.labels = cellstr(char(catList));
    pIN.listN = true;
    
    for i = 1:length(fieldNames)
        close all
        imageArray = {structMapsReduced.(fieldNames{i})};
        medianArray = cellMean(imageArray);
        clear medians
        for j = unique(category)
            means{j} = medianArray(category == j);
        end
        
        hFig = figureBarGraph(catList, means, pIN);
        ylabel(['Relative ' fieldLabels{i}]);
        
        set(gcf, 'PaperPositionMode', 'auto');
        print([settings.outRough, settings.uniqueIdentifier, fieldNames{i}, 'GenotypeGraph.png'],'-dpng','-r300');
        close;
    end
end

%% Figure S1: array of all raw spatial maps
if doFigureS1
    i = 1;
    
    % Color maps
    maps = settings.colorMap;
    mapOrder = {maps.amp, maps.freq, maps.WHM, maps.dtyCyc, maps.basal};
    
    % Make figure
    [figures, intensityCutoffs] = maps2RGB(structMapsReduced, mapOrder, fieldNames);
    imshow(figures);
    imwrite(figures, [settings.outRough, settings.uniqueIdentifier, 'AllFigureBodyRaw.png']);
    
    scaleBar = figures * 0;
    scaleBar(10:20,10:(10+scaleBarPixels),:) = 255;
    imwrite(scaleBar, [settings.outRough, settings.uniqueIdentifier, 'ScaleBar3.png']);
end