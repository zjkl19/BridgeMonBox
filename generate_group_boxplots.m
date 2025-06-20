function generate_group_boxplots(tStart, tEnd)
% BridgeMonBox —— 分组箱线图批量生成器（R2023b）
% -------------------------------------------------------------------------
% tStart, tEnd : datetime  指定分析时间范围（含边界）
% -------------------------------------------------------------------------
% 作者：ChatGPT  更新：2025-06-18

arguments
    tStart (1,1) datetime
    tEnd   (1,1) datetime
end
if tEnd <= tStart
    error("结束时间必须晚于开始时间");
end

dateTag = sprintf("%s-%s", datestr(tStart,"yyyymmdd"), datestr(tEnd,"yyyymmdd"));
runTag  = datestr(now,"yyyymmdd_HHMM");
%% 0.1  数据上下限过滤（逐点列出，先用默认值，可逐行修改） ================
% 全局默认
defaultStrainLow = -1e4;    % 应变下限 με
defaultStrainUp  =  1e4;    % 应变上限 με
defaultTiltLow   = -1;      % 倾角下限 °
defaultTiltUp    =  1;      % 倾角上限 °

fltLower = containers.Map();
fltUpper = containers.Map();

% —— 第一跨跨中 B ———————————————————————————————
fltLower('SB-1') = defaultStrainLow;   fltUpper('SB-1') = defaultStrainUp;
fltLower('SB-2') = defaultStrainLow;   fltUpper('SB-2') = defaultStrainUp;
fltLower('SB-3') = defaultStrainLow;   fltUpper('SB-3') = defaultStrainUp;
fltLower('SB-4') = defaultStrainLow;   fltUpper('SB-4') = defaultStrainUp;
fltLower('SB-5') = defaultStrainLow;   fltUpper('SB-5') = defaultStrainUp;
fltLower('SB-6') = defaultStrainLow;   fltUpper('SB-6') = defaultStrainUp;

% —— 12# 墩墩顶 C ———————————————————————————————
fltLower('SC-1') = defaultStrainLow;   fltUpper('SC-1') = defaultStrainUp;
fltLower('SC-2') = defaultStrainLow;   fltUpper('SC-2') = defaultStrainUp;
fltLower('SC-3') = defaultStrainLow;   fltUpper('SC-3') = defaultStrainUp;
fltLower('SC-4') = defaultStrainLow;   fltUpper('SC-4') = defaultStrainUp;
fltLower('SC-5') = defaultStrainLow;   fltUpper('SC-5') = defaultStrainUp;
fltLower('SC-6') = defaultStrainLow;   fltUpper('SC-6') = defaultStrainUp;

% —— 第二跨跨中 D ——————————————————————————————
fltLower('SD-1') = defaultStrainLow;   fltUpper('SD-1') = defaultStrainUp;
fltLower('SD-2') = defaultStrainLow;   fltUpper('SD-2') = defaultStrainUp;
fltLower('SD-3') = defaultStrainLow;   fltUpper('SD-3') = defaultStrainUp;
fltLower('SD-4') = defaultStrainLow;   fltUpper('SD-4') = defaultStrainUp;
fltLower('SD-5') = defaultStrainLow;   fltUpper('SD-5') = defaultStrainUp;
fltLower('SD-6') = defaultStrainLow;   fltUpper('SD-6') = defaultStrainUp;

% —— 13# 墩墩顶 E ———————————————————————————————
fltLower('SE-1') = defaultStrainLow;   fltUpper('SE-1') = defaultStrainUp;
fltLower('SE-2') = defaultStrainLow;   fltUpper('SE-2') = defaultStrainUp;
fltLower('SE-3') = defaultStrainLow;   fltUpper('SE-3') = defaultStrainUp;
fltLower('SE-4') = defaultStrainLow;   fltUpper('SE-4') = defaultStrainUp;
fltLower('SE-5') = defaultStrainLow;   fltUpper('SE-5') = defaultStrainUp;
fltLower('SE-6') = defaultStrainLow;   fltUpper('SE-6') = defaultStrainUp;

% —— 第三跨跨中 F ——————————————————————————————
fltLower('SF-1') = defaultStrainLow;   fltUpper('SF-1') = defaultStrainUp;
fltLower('SF-2') = defaultStrainLow;   fltUpper('SF-2') = defaultStrainUp;
fltLower('SF-3') = defaultStrainLow;   fltUpper('SF-3') = defaultStrainUp;
fltLower('SF-4') = defaultStrainLow;   fltUpper('SF-4') = defaultStrainUp;
fltLower('SF-5') = defaultStrainLow;   fltUpper('SF-5') = defaultStrainUp;
fltLower('SF-6') = defaultStrainLow;   fltUpper('SF-6') = defaultStrainUp;

% —— 14# 墩墩顶 G ———————————————————————————————
fltLower('SG-1') = defaultStrainLow;   fltUpper('SG-1') = defaultStrainUp;
fltLower('SG-2') = defaultStrainLow;   fltUpper('SG-2') = defaultStrainUp;
fltLower('SG-3') = defaultStrainLow;   fltUpper('SG-3') = defaultStrainUp;
fltLower('SG-4') = defaultStrainLow;   fltUpper('SG-4') = defaultStrainUp;
fltLower('SG-5') = defaultStrainLow;   fltUpper('SG-5') = defaultStrainUp;
fltLower('SG-6') = defaultStrainLow;   fltUpper('SG-6') = defaultStrainUp;

% —— 第四跨跨中 H ——————————————————————————————
fltLower('SH-1') = defaultStrainLow;   fltUpper('SH-1') = defaultStrainUp;
fltLower('SH-2') = defaultStrainLow;   fltUpper('SH-2') = defaultStrainUp;
fltLower('SH-3') = defaultStrainLow;   fltUpper('SH-3') = defaultStrainUp;
fltLower('SH-4') = defaultStrainLow;   fltUpper('SH-4') = defaultStrainUp;
fltLower('SH-5') = defaultStrainLow;   fltUpper('SH-5') = defaultStrainUp;
fltLower('SH-6') = defaultStrainLow;   fltUpper('SH-6') = defaultStrainUp;

% —— 塔中 L ————————————————————————————————————————
fltLower('SL-1')  = defaultStrainLow;  fltUpper('SL-1')  = defaultStrainUp;
fltLower('SL-2')  = defaultStrainLow;  fltUpper('SL-2')  = defaultStrainUp;
fltLower('SL-3')  = defaultStrainLow;  fltUpper('SL-3')  = defaultStrainUp;
fltLower('SL-4')  = defaultStrainLow;  fltUpper('SL-4')  = defaultStrainUp;
fltLower('SL-5')  = defaultStrainLow;  fltUpper('SL-5')  = defaultStrainUp;
fltLower('SL-6')  = defaultStrainLow;  fltUpper('SL-6')  = defaultStrainUp;
fltLower('SL-7')  = defaultStrainLow;  fltUpper('SL-7')  = defaultStrainUp;
fltLower('SL-8')  = defaultStrainLow;  fltUpper('SL-8')  = defaultStrainUp;
fltLower('SL-9')  = defaultStrainLow;  fltUpper('SL-9')  = defaultStrainUp;
fltLower('SL-10') = defaultStrainLow;  fltUpper('SL-10') = defaultStrainUp;

% —— 塔底 K ————————————————————————————————————————
fltLower('SK-1')  = defaultStrainLow;  fltUpper('SK-1')  = defaultStrainUp;
fltLower('SK-2')  = defaultStrainLow;  fltUpper('SK-2')  = defaultStrainUp;
fltLower('SK-3')  = defaultStrainLow;  fltUpper('SK-3')  = defaultStrainUp;
fltLower('SK-4')  = defaultStrainLow;  fltUpper('SK-4')  = defaultStrainUp;
fltLower('SK-5')  = defaultStrainLow;  fltUpper('SK-5')  = defaultStrainUp;
fltLower('SK-6')  = defaultStrainLow;  fltUpper('SK-6')  = defaultStrainUp;
fltLower('SK-7')  = defaultStrainLow;  fltUpper('SK-7')  = defaultStrainUp;
fltLower('SK-8')  = defaultStrainLow;  fltUpper('SK-8')  = defaultStrainUp;
fltLower('SK-9')  = defaultStrainLow;  fltUpper('SK-9')  = defaultStrainUp;
fltLower('SK-10') = defaultStrainLow;  fltUpper('SK-10') = defaultStrainUp;
fltLower('SK-11') = defaultStrainLow;  fltUpper('SK-11') = defaultStrainUp;
fltLower('SK-12') = defaultStrainLow;  fltUpper('SK-12') = defaultStrainUp;

% —— 桥塔倾角 T ————————————————————————————————————
fltLower('Q1-Z') = defaultTiltLow;     fltUpper('Q1-Z') = defaultTiltUp;
fltLower('Q1-H') = defaultTiltLow;     fltUpper('Q1-H') = defaultTiltUp;
fltLower('Q2-Z') = defaultTiltLow;     fltUpper('Q2-Z') = defaultTiltUp;
fltLower('Q2-H') = defaultTiltLow;     fltUpper('Q2-H') = defaultTiltUp;

% —— 单点收紧示例（可按需添加）—————————————
% fltLower('SB-4') = -500;  fltUpper('SB-4') = 800;
% fltLower('Q1-Z') = -0.05; fltUpper('Q1-Z') = 0.05;


% ============ 2) 倾角测点列表 ============================================
tiltKeys = {'Q1-Z','Q1-H','Q2-Z','Q2-H'};

for k = 1:numel(tiltKeys)
    fltLower(tiltKeys{k}) = defaultTiltLow;
    fltUpper(tiltKeys{k}) = defaultTiltUp;
end

% —— 若需对单个测点收紧范围，可在此追加覆写行 ——
% fltLower('SB-4') = -500;   fltUpper('SB-4') = 800;
% fltLower('Q1-Z') = -0.05;  fltUpper('Q1-Z') = 0.05;

%% 0.  修正量（基准值，默认全 0，可自行修改）===============================
corrMap = containers.Map();

% —— 第一跨跨中 B ———————————————————————————————
corrMap('SB-1') = 0;
corrMap('SB-2') = 0;
corrMap('SB-3') = 0;
corrMap('SB-4') = 0;
corrMap('SB-5') = 0;
corrMap('SB-6') = 0;

% —— 12# 墩墩顶 C ———————————————————————————————
corrMap('SC-1') = 0;
corrMap('SC-2') = 0;
corrMap('SC-3') = 0;
corrMap('SC-4') = 0;
corrMap('SC-5') = 0;
corrMap('SC-6') = 0;

% —— 第二跨跨中 D ——————————————————————————————
corrMap('SD-1') = 0;
corrMap('SD-2') = 0;
corrMap('SD-3') = 0;
corrMap('SD-4') = 0;
corrMap('SD-5') = 0;
corrMap('SD-6') = 0;

% —— 13# 墩墩顶 E ———————————————————————————————
corrMap('SE-1') = 0;
corrMap('SE-2') = 0;
corrMap('SE-3') = 0;
corrMap('SE-4') = 0;
corrMap('SE-5') = 0;
corrMap('SE-6') = 0;

% —— 第三跨跨中 F ——————————————————————————————
corrMap('SF-1') = 0;
corrMap('SF-2') = 0;
corrMap('SF-3') = 0;
corrMap('SF-4') = 0;
corrMap('SF-5') = 0;
corrMap('SF-6') = 0;

% —— 14# 墩墩顶 G ———————————————————————————————
corrMap('SG-1') = 0;
corrMap('SG-2') = 0;
corrMap('SG-3') = 0;
corrMap('SG-4') = 0;
corrMap('SG-5') = 0;
corrMap('SG-6') = 0;

% —— 第四跨跨中 H ——————————————————————————————
corrMap('SH-1') = 0;
corrMap('SH-2') = 0;
corrMap('SH-3') = 0;
corrMap('SH-4') = 0;
corrMap('SH-5') = 0;
corrMap('SH-6') = 0;

% —— 塔中 L ————————————————————————————————————————
corrMap('SL-1') = 0;
corrMap('SL-2') = 0;
corrMap('SL-3') = 0;
corrMap('SL-4') = 0;
corrMap('SL-5') = 0;
corrMap('SL-6') = 0;
corrMap('SL-7') = 0;
corrMap('SL-8') = 0;
corrMap('SL-9') = 0;
corrMap('SL-10') = 0;

% —— 塔底 K ————————————————————————————————————————
corrMap('SK-1')  = 0;
corrMap('SK-2')  = 0;
corrMap('SK-3')  = 0;
corrMap('SK-4')  = 0;
corrMap('SK-5')  = 0;
corrMap('SK-6')  = 0;
corrMap('SK-7')  = 0;
corrMap('SK-8')  = 0;
corrMap('SK-9')  = 0;
corrMap('SK-10') = 0;
corrMap('SK-11') = 0;
corrMap('SK-12') = 0;

% —— 桥塔倾角 T ————————————————————————————————————
corrMap('Q1-Z') = -1.422;    %2022-08-02
corrMap('Q1-H') = -1.185;    %2022-08-02
corrMap('Q2-Z') = -1.796;    %2022-10-01
corrMap('Q2-H') = -0.507;    %2022-10-01
%% 1. 组定义、阈值、ylim ----------------------------------------------------
[groupDef, limitTab, ylimDict] = localGroupAndLimits();

%% 2. 读取 Excel（强制列类型为 double，"--"→NaN） ------------------------
sheetNm = "传感器监测数据报表";
opts    = detectImportOptions("data.xlsx", Sheet=sheetNm,VariableNamingRule="preserve");

% 采集时间列
opts = setvartype(opts, "SamplingTime",  "datetime");
opts = setvaropts(opts, "SamplingTime",  InputFormat="yyyy-MM-dd HH:mm:ss");

% 所有传感器列
sensorVars = opts.VariableNames(2:end);           % 第 2 列开始
opts = setvartype(opts, sensorVars, "double");    % 强制 double
opts = setvaropts(opts, sensorVars, TreatAsMissing="--");

T = readtable("data.xlsx", opts);

% 截取时间段
T = T(T.SamplingTime >= tStart & T.SamplingTime <= tEnd, :);
if isempty(T)
    warning("时间段 %s ~ %s 内无数据！", string(tStart), string(tEnd));
    return
end

%% 3. 创建输出文件夹 -------------------------------------------------------
outDir = fullfile("results", runTag);
if ~isfolder(outDir),  mkdir(outDir);  end

%% 4. 遍历分组绘图 ---------------------------------------------------------
statsXls = fullfile(outDir, sprintf('Stats_%s_%s.xlsx', dateTag, runTag));
if isfile(statsXls)            % 旧文件可能存在，删除重建
    delete(statsXls);
end
for g = 1:numel(groupDef)
    gName   = groupDef(g).name;
    members = groupDef(g).members;

    [dataMat, idxOK] = localExtract(T, members);
    if isempty(dataMat)
        warning("组 %s 在所选时间段无有效数据，跳过。", gName);
        continue
    end
    % === 应用“修正量” ===================================================
    if ~isempty(dataMat)
        corrVec = zeros(1, size(dataMat,2));           % 默认 0
        presentMask = ismember(members, T.Properties.VariableNames);
        labels      = members(presentMask);            % 与 dataMat 列对应
        limRows     = limitTab(strcmp(limitTab.Group, gName), :);  % ★提前放这
        for k = 1:numel(labels)
            if isKey(corrMap, labels{k})
                corrVec(k) = corrMap(labels{k});
            end
        end
        dataMat = dataMat + corrVec;                   % 行向量广播到所有行
        % === 数据上下限过滤（超限→NaN） ================================
        for c = 1:size(dataMat,2)
            lb = fltLower(labels{c});
            ub = fltUpper(labels{c});
            outMask = dataMat(:,c) < lb | dataMat(:,c) > ub;
            dataMat(outMask, c) = NaN;
        end
        % === 统计特征并写入 Excel ==========================================
        statTab = table('Size',[numel(labels) 9], ...
            'VariableTypes', repmat("double",1,9), ...
            'VariableNames', {'Count','Mean','Std','Min','Q1','Median','Q3','Max','IQR'}, ...
            'RowNames', labels);

        for c = 1:numel(labels)
            vec = dataMat(:,c);                        % 一列数据
            vec = vec(~isnan(vec));                    % 忽略 NaN
            if isempty(vec), continue; end

            statTab.Count (c) = numel(vec);
            statTab.Mean  (c) = mean(vec);
            statTab.Std   (c) = std(vec);
            prc = prctile(vec,[0 25 50 75 100]);
            statTab.Min   (c) = prc(1);
            statTab.Q1    (c) = prc(2);
            statTab.Median(c) = prc(3);
            statTab.Q3    (c) = prc(4);
            statTab.Max   (c) = prc(5);
            statTab.IQR   (c) = prc(4) - prc(2);
        end
        % === 按量纲四舍五入 ==========================================
        if strcmp(limRows.Unit{1}, 'με')          % 应变
            statTab{:,:} = round(statTab{:,:});   % 0 位小数
        else                                       % 倾角
            statTab{:,:} = round(statTab{:,:}, 3);% 3 位小数
        end
        % 将表写入 Excel，以组名做工作表
        writetable(statTab, statsXls, 'Sheet', gName, 'WriteRowNames', true);

    end
    % ---------- 绘图（boxplot + whisker=100） ----------------------------
    fig = figure(Visible="off", Position=[100 100 600 300]);

    % ① 画箱线图
    boxplot(dataMat, 'Whisker', 100, 'Symbol','');  hold on

    % ② X 轴显示真实测点编号
    presentMask = ismember(members, T.Properties.VariableNames);
    labels      = members(presentMask);
    
    set(gca, 'XTick', 1:numel(labels), ...
        'XTickLabel', labels, ...
        'XTickLabelRotation', 30, ...
        'TickLabelInterpreter', 'none');

    % ③ 叠加黄色 / 红色阈值线（每个测点单独，线段只跨箱体宽度）
    
    halfLen = 0.30;                       % 半宽度 → 总宽 0.60
    for k = 1:numel(labels)
        sName = labels{k};
        thr   = limRows(strcmp(limRows.Sensor, sName), :);

        % 黄色上下限（实线）
        line([k-halfLen k+halfLen], [thr.YellowLower thr.YellowLower], ...
            'Color',[0.929 0.694 0.125],'LineStyle','-');
        line([k-halfLen k+halfLen], [thr.YellowUpper thr.YellowUpper], ...
            'Color',[0.929 0.694 0.125],'LineStyle','-');

        % 红色上下限（实线）
        line([k-halfLen k+halfLen], [thr.RedLower thr.RedLower], ...
            'Color',[1 0 0],'LineStyle','-');
        line([k-halfLen k+halfLen], [thr.RedUpper thr.RedUpper], ...
            'Color',[1 0 0],'LineStyle','-');
    end

    % ④ y 轴标签
    if strcmp(limRows.Unit{1}, 'με')
        ylabel("应变（με）");
    else
        ylabel("倾角（°）");
    end

    % ⑤ 标题 & ylim
    title(sprintf("组 %s  %s — %s", gName, ...
        datestr(tStart,"yyyy-mm-dd"), datestr(tEnd,"yyyy-mm-dd")));

    if isKey(ylimDict, gName)
        ylim(ylimDict(gName));
    end
    % === 设定步长 + 刻度标签格式 ============================================
    yL = ylim;                                  % 当前 y 轴范围
    if strcmp(limRows.Unit{1}, 'με')            % —— 应变
        step = 100;                             % 100 με 一格
        yticks(ceil(yL(1)/step)*step : step : floor(yL(2)/step)*step);
        ytickformat('%.0f');                    % 刻度标签取整
    else                                         % —— 倾角
        step = 0.02;                            % 0.02° 一格
        yticks(ceil(yL(1)/step)*step : step : floor(yL(2)/step)*step);
        ytickformat('%.3f');                    % 保留 3 位小数
    end
    hold off


    % --------- 保存：PNG / EMF / FIG ------------------------------------
    base = sprintf("Box_%s_%s_%s", gName, dateTag, runTag);
    exportgraphics(fig, fullfile(outDir, base+".png"), Resolution=300);
    exportgraphics(fig, fullfile(outDir, base+".emf"), Resolution=300);
    fig.Visible = 'on';                      % ← ★新增：写 .fig 前先设可见
    savefig(fig, fullfile(outDir, base+".fig"));
    close(fig);
    fprintf("✓ %s.[png|emf|fig]\n", base);
end
fprintf("全部完成！输出目录：%s\n", outDir);
end
%% ========================================================================
function [groupDef, limitTab, ylimDict] = localGroupAndLimits()
% -------------------- 分组 ------------------------------------------------
groupDef = struct( ...
    "name", {'B','C','D','E','F','G','H','L','K','T'}, ...
    "members", { ...
    {'SB-1','SB-2','SB-3','SB-4','SB-5','SB-6'}, ...
    {'SC-1','SC-2','SC-3','SC-4','SC-5','SC-6'}, ...
    {'SD-1','SD-2','SD-3','SD-4','SD-5','SD-6'}, ...
    {'SE-1','SE-2','SE-3','SE-4','SE-5','SE-6'}, ...
    {'SF-1','SF-2','SF-3','SF-4','SF-5','SF-6'}, ...
    {'SG-1','SG-2','SG-3','SG-4','SG-5','SG-6'}, ...
    {'SH-1','SH-2','SH-3','SH-4','SH-5','SH-6'}, ...
    {'SL-1','SL-2','SL-3','SL-4','SL-5','SL-6','SL-7','SL-8','SL-9','SL-10'}, ...
    {'SK-1','SK-2','SK-3','SK-4','SK-5','SK-6','SK-7','SK-8','SK-9','SK-10','SK-11','SK-12'}, ...
    {'Q1-Z','Q1-H','Q2-Z','Q2-H'} });

% ------------------ 阈值表（68 行） -------------------------------------
limitCell = { ...
    % Group Sensor  YL   YU   RL    RU    Unit
    'B','SB-1', -113, 226, -170, 338, 'με';
    'B','SB-2', -113, 226, -170, 338, 'με';
    'B','SB-3', -113, 226, -170, 338, 'με';
    'B','SB-4', -113, 226, -170, 338, 'με';
    'B','SB-5', -193, 107, -290, 160, 'με';
    'B','SB-6', -193, 107, -290, 160, 'με';

    'C','SC-1', -126,  65, -188,  97, 'με';
    'C','SC-2', -126,  65, -188,  97, 'με';
    'C','SC-3', -126,  65, -188,  97, 'με';
    'C','SC-4', -126,  65, -188,  97, 'με';
    'C','SC-5', -115,  88, -172, 132, 'με';
    'C','SC-6', -115,  88, -172, 132, 'με';

    'D','SD-1', -126,  95, -188, 142, 'με';
    'D','SD-2', -126,  95, -188, 142, 'με';
    'D','SD-3', -126,  95, -188, 142, 'με';
    'D','SD-4', -126,  95, -188, 142, 'με';
    'D','SD-5',  -81, 272, -121, 408, 'με';
    'D','SD-6',  -81, 272, -121, 408, 'με';

    'E','SE-1', -126, 149, -188, 223, 'με';
    'E','SE-2', -126, 149, -188, 223, 'με';
    'E','SE-3', -126, 149, -188, 223, 'με';
    'E','SE-4', -126, 149, -188, 223, 'με';
    'E','SE-5', -164, 149, -247, 223, 'με';
    'E','SE-6', -164, 149, -247, 223, 'με';

    'F','SF-1', -126,  95, -188, 142, 'με';
    'F','SF-2', -126,  95, -188, 142, 'με';
    'F','SF-3', -126,  95, -188, 142, 'με';
    'F','SF-4', -126,  95, -188, 142, 'με';
    'F','SF-5',  -81, 272, -121, 408, 'με';
    'F','SF-6',  -81, 272, -121, 408, 'με';

    'G','SG-1', -126,  65, -188,  97, 'με';
    'G','SG-2', -126,  65, -188,  97, 'με';
    'G','SG-3', -126,  65, -188,  97, 'με';
    'G','SG-4', -126,  65, -188,  97, 'με';
    'G','SG-5', -115,  88, -172, 132, 'мет';
    'G','SG-6', -115,  88, -172, 132, 'με';

    'H','SH-1', -113, 226, -170, 338, 'με';
    'H','SH-2', -113, 226, -170, 338, 'με';
    'H','SH-3', -113, 226, -170, 338, 'με';
    'H','SH-4', -113, 226, -170, 338, 'με';
    'H','SH-5', -193, 107, -290, 160, 'με';
    'H','SH-6', -193, 107, -290, 160, 'με';

    'L','SL-1', -136,  44, -204,  66, 'με';
    'L','SL-2', -136,  37, -204,  56, 'με';
    'L','SL-3', -136,  66, -204,  98, 'με';
    'L','SL-4', -136,  72, -204, 108, 'με';
    'L','SL-5', -136,  66, -204,  98, 'με';
    'L','SL-6', -136,  44, -204,  66, 'με';
    'L','SL-7', -136,  37, -204,  56, 'με';
    'L','SL-8', -136,  66, -204,  98, 'με';
    'L','SL-9', -136,  72, -204, 108, 'με';
    'L','SL-10',-136,  66, -204,  98, 'με';

    'K','SK-1', -136,  37, -204,  55, 'με';
    'K','SK-2', -136,  31, -204,  47, 'με';
    'K','SK-3', -136,  31, -204,  46, 'με';
    'K','SK-4', -136,  41, -204,  61, 'με';
    'K','SK-5', -136,  46, -204,  69, 'με';
    'K','SK-6', -136,  42, -204,  62, 'με';
    'K','SK-7', -136,  37, -204,  55, 'με';
    'K','SK-8', -136,  31, -204,  47, 'με';
    'K','SK-9', -136,  31, -204,  46, 'με';
    'K','SK-10',-136,  41, -204,  61, 'με';
    'K','SK-11',-136,  46, -204,  69, 'με';
    'K','SK-12',-136,  42, -204,  62, 'με';

    'T','Q1-Z', -0.038,  0.038, -0.057, 0.057, '°';
    'T','Q1-H', -0.038,  0.038, -0.057, 0.057, '°';
    'T','Q2-Z', -0.038,  0.038, -0.057, 0.057, '°';
    'T','Q2-H', -0.038,  0.038, -0.057, 0.057, '°';
    };
limitTab = cell2table(limitCell, 'VariableNames', ...
    {'Group','Sensor','YellowLower','YellowUpper','RedLower','RedUpper','Unit'});

% ------------------ ylim 字典 -------------------------------------------
ylimDict = containers.Map;
ylimDict('B') = [-500  500];   % 第一跨跨中
ylimDict('C') = [-500  500];   % 12# 墩墩顶
ylimDict('D') = [-500  500];   % 第二跨跨中
ylimDict('E') = [-500  500];   % 13# 墩墩顶
ylimDict('F') = [-500  500];   % 第三跨跨中
ylimDict('G') = [-500  500];   % 14# 墩墩顶
ylimDict('H') = [-500  500];   % 第四跨跨中
ylimDict('L') = [-300  300];   % 塔中
ylimDict('K') = [-300  300];   % 塔底
ylimDict('T') = [-0.10 0.10];  % 所有倾角

end
%% ------------------------------------------------------------------------
function [yMat, idxOK] = localExtract(T, members)
% 提取列并确保返回 double 数组（字符串 → NaN）
[tf, idx] = ismember(members, T.Properties.VariableNames);
idxOK     = idx(tf);
if isempty(idxOK)
    yMat = [];
    return
end
% 直接取表内容
raw = T{:, idxOK};
% 已强制列类型为 double，但保险：若混入 cell → str2double
if isnumeric(raw)
    yMat = raw;
else
    nR = height(T); nC = numel(idxOK); yMat = NaN(nR, nC);
    for k = 1:nC
        col = raw(:,k);
        yMat(:,k) = str2double(col);
    end
end
end
