function out = func_exhaustive_search(XU,YU, R_th, Pmax)
    %
    trials = 1e6; 
    %
    theta_vec = linspace(0.01,0.99,20);
    %
%     rangePmaxdB = -20:10:30;
%     PmaxdB_ = rangePmaxdB(randi([1 length(rangePmaxdB)],[1,1e5]));

    % pos_uav = csvread('data_pos_uav.csv');
    % ====================================================================
    %   System Parameters...
    % ====================================================================
        GCdB = 0; % dBi
        GFdB = 0; % dBi
        fc = 3; % GHz - carrier frequency
        waveLen = physconst('LightSpeed')/(fc*10^9);
        %
        etaLoSdB =1.6; etaLoS = db2pow(etaLoSdB);
        etaNLoSdB= 23; etaNLoS= db2pow(etaNLoSdB);
        %
        NPB = -144; % dBm/Hz
        BW = 20*10^6; % MHz
        noisePow = 10^(NPB/10)*BW; % mW
        %
%         R_th_C = 1.0;
%         R_th_E = 0.05;
        R_th_C = R_th(1); %1.0;
        R_th_E = R_th(2);
        % Initial location of nodes
        L = 25;
        % the FC is located as the origin
        XF = 0; YF = 0; ZF = 0;
        % the UE-C
        XC = -1.957;
        YC = 7.3266;
        ZC = 0;
        % the UE-E
        XE = -13.4888;
        YE = -18.8525;
        ZE = 0.2338;
        % the UAV 
%         XU = -6.6561;
%         YU = -7.6165;
        ZU = 6.7750;
        %% Large-Scale Fading
        % ------------- The G2G channel from CU-C to FC ------------- 
        dCF = sqrt( (XC-XF)^2+(YC-YF)^2+(ZC-ZF)^2 );
        LCF = db2pow( GCdB+GFdB-22.7-26*log10(fc)-36.7*log10(dCF) );

        % ------------- The G2A channels from CU-C to UAV ------------- 
        dCU = sqrt( (XC-XU)^2+(YC-YU)^2+(ZC-ZU)^2 );
        phiCU = 180/pi*asin( abs(ZC-ZU)/dCU );
        pCU = 1/(1+12.08*exp(-0.11*(phiCU-12.08)));
        LCULoS = (waveLen/(4*pi*dCU))^2/etaLoS;
        LCUNLoS= (waveLen/(4*pi*dCU))^2/etaNLoS;
        BCU = rand(1,trials) < pCU;
        LCU = LCULoS .*pCU + LCUNLoS.*(1-pCU);
        % ------------- The G2A channels from CU-E to UAV ------------- 
        dEU = sqrt( (XE-XU)^2+(YE-YU)^2+(ZE-ZU)^2 );
        phiEU = 180/pi*asin( abs(ZE-ZU)/dEU );
        pEU = 1/(1+12.08*exp(-0.11*(phiEU-12.08)));
        LEULoS = (waveLen/(4*pi*dEU))^2/etaLoS;
        LEUNLoS= (waveLen/(4*pi*dEU))^2/etaNLoS;
        BEU = rand(1,trials) < pEU;
        LEU = LEULoS .*pEU + LEUNLoS.*(1-pEU); 
        % ------------- The G2A channels from UAV to FC ------------- 
        dUF = sqrt( (XF-XU)^2+(YF-YU)^2+(ZF-ZU)^2 );
        phiUF = 180/pi*asin( abs(ZF-ZU)/dUF );
        pUF = 1/(1+12.08*exp(-0.11*(phiUF-12.08)));
        LUFLoS = (waveLen/(4*pi*dUF))^2/etaLoS;
        LUFNLoS= (waveLen/(4*pi*dUF))^2/etaNLoS;
        BUF = rand(1,trials) < pUF;
        LUF = LUFLoS .*pUF + LUFNLoS.*(1-pUF);
        %% Small-Scale Fading
        % ------------- The G2G channel from CU-C to FC ------------- 
        mCF = 5; OmgCF = 0.279; bCF = 0.251;
        Z = random('Nakagami',mCF,OmgCF,[1,trials]);
        gCF = random('Rician',Z,sqrt(bCF),[1,trials]);
        hCF2= gCF.^2 .* LCF; 
        % ------------- The G2A channels from CU-C to UAV ------------- 
        mCU = 3;
        gCULoS = sqrt(gamrnd(mCU,1/mCU,[1,trials]));
        gCUNLoS= sqrt(exprnd(1,[1,trials]));
        hCU2= gCULoS.^2 .* LCULoS .*(BCU)...
            + gCUNLoS.^2.* LCUNLoS.*(1-BCU);
        % ------------- The G2A channels from CU-E to UAV -------------
        mEU = 1;
        gEULoS = sqrt(gamrnd(mEU,1/mEU,[1,trials]));
        gEUNLoS= sqrt(exprnd(1,[1,trials]));
        hEU2= gEULoS.^2 .* LEULoS .*(BEU)...
            + gEUNLoS.^2.* LEUNLoS.*(1-BEU);
        % ------------- The G2A channels from UAV to FC ------------- 
        mUF = 5;
        gUFLoS = sqrt(gamrnd(mUF,1/mUF,[1,trials]));
        gUFNLoS= sqrt(exprnd(1,[1,trials]));
        hUF2= gUFLoS.^2 .* LUFLoS .*(BUF)...
            + gUFNLoS.^2.* LUFNLoS.*(1-BUF);
        %% Residual Interference Normalized Power
        xi = db2pow(-10);
        thCU2 = exprnd(xi,[1,trials]).*LCU;
        thCF2 = exprnd(xi,[1,trials]).*LCF;
        thUF2 = exprnd(xi,[1,trials]).*LUF;
        %%
        R_F_xC1 = @(PC) (1/2)*log2( 1+PC*hCF2/noisePow );
        R_ADMUC_U_xC1= @(PC,PE) (1/2)*log2( 1+(PC*hCU2)./(PE*hEU2+noisePow) );
        R_ADMUC_U_xE = @(PC,PE) (1/2)*log2( 1+(PE*hEU2)./(PC*thCU2+noisePow) );
        R_ADMUE_U_xE = @(PC,PE) (1/2)*log2( 1+(PE*hEU2)./(PC*hCU2+noisePow) );

        R_ADMFC_F_xC2= @(PC,PU) (1/2)*log2( 1+(PC*hCF2)./(PU*hUF2+noisePow) );
        R_ADMFC_F_hxE= @(PC,PU) (1/2)*log2( 1+(PU*hUF2)./(PC*thCF2+noisePow) );
        R_ADMFE_F_hxE= @(PC,PU) (1/2)*log2( 1+(PU*hUF2)./(PC*hCF2+noisePow) );
        R_ADMFE_F_xC2= @(PC,PU) (1/2)*log2( 1+(PC*hCF2)./(PU*thUF2+noisePow) );

        R_F_xC2 = @(PC) (1/2)*log2( 1+PC*hCF2/noisePow );
    % ====================================================================    
    theta1Opt = 0;
    theta2Opt = 0;
    throughputOpt = 0;
    % Exhaustive Search
    tic;
    for itheta1 = 1:length(theta_vec)
        theta1 = theta_vec(itheta1);
        for itheta2 = 1:length(theta_vec)
            theta2 = theta_vec(itheta2);

            PC1 = theta1*Pmax;
            PE1 = (1-theta1)*Pmax;

            PC2 = theta2*Pmax;
            PU2 = (1-theta2)*Pmax;
            %
            e0 = R_F_xC1(PC1) > R_th_C;
            e1 = hCU2 > hEU2;
            e2 = R_ADMUC_U_xC1(PC1,PE1) > R_th_C;
            e3 = R_ADMUC_U_xE(PC1,PE1) > R_th_E;
            e4 = hCU2 < hEU2;
            e5 = R_ADMUE_U_xE(PC1,PE1) > R_th_E;

            e6 = hCF2 > hUF2;
            e7 = R_ADMFC_F_xC2(PC2,PU2) > R_th_C;
            e8 = R_ADMFC_F_hxE(PC2,PU2) > R_th_E;
            e9 = hCF2 < hUF2;
            e10= R_ADMFE_F_hxE(PC2,PU2) > R_th_E;
            e11= R_ADMFE_F_xC2(PC2,PU2) > R_th_C;

            e12= R_F_xC2(PC2) > R_th_C;

            %% Simulation
            % Theorem 1:
            OP_U_xE = mean(((~e2)|(~e3))&(e1)) + mean((~e5)&(e4));
            OP_U2F_hXE = mean(((~e7)|(~e8))&(e6)) + mean((~e10)&(e9));

            OP_hxE_SIM = 1 - (1-OP_U_xE) * (1-OP_U2F_hXE);
            % Theorem 2:
            OP_UC2F_xC2 = mean((~e7)&(e6))+mean(((~e10)|(~e11))&(e9));
            OP_C2F_xC2 = mean((~e12));

            OP_xC2_SIM = (1-OP_U_xE)*OP_UC2F_xC2 + OP_U_xE*OP_C2F_xC2;
            % Theorem 3:
            OP_ADM_xC1_SIM = 1 - mean(e0);

            % System Throughput
            Throughput_ADM = R_th_E/2*( 1-OP_hxE_SIM )...
                + R_th_C/2*( 1-OP_xC2_SIM ) + R_th_C/2*( 1-OP_ADM_xC1_SIM );
            %
            if (throughputOpt < Throughput_ADM)
                throughputOpt = max(throughputOpt,Throughput_ADM);

                theta1Opt = theta1;
                theta2Opt = theta2;
            end
        end
    end
    toc;
    out = throughputOpt;
end