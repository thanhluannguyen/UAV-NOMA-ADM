function out = func_throughput(e1,e4,e6,e9,R_F_xC1,R_ADMUC_U_xC1,R_ADMUC_U_xE,R_ADMUE_U_xE,...
        R_ADMFC_F_xC2, R_ADMFC_F_hxE, R_ADMFE_F_hxE, R_ADMFE_F_xC2, R_F_xC2,...
        R_th_C, R_th_E, Pmax, theta1, theta2)
    %
    PC1 = theta1*Pmax;
    PE1 = (1-theta1)*Pmax;

    PC2 = theta2*Pmax;
    PU2 = (1-theta2)*Pmax;
    %
    e0 = R_F_xC1(PC1) > R_th_C;
    e2 = R_ADMUC_U_xC1(PC1,PE1)> R_th_C;
    e3 = R_ADMUC_U_xE(PC1,PE1) > R_th_E;
    e5 = R_ADMUE_U_xE(PC1,PE1) > R_th_E;

    e7 = R_ADMFC_F_xC2(PC2,PU2) > R_th_C;
    e8 = R_ADMFC_F_hxE(PC2,PU2) > R_th_E;
    e10= R_ADMFE_F_hxE(PC2,PU2) > R_th_E;
    e11= R_ADMFE_F_xC2(PC2,PU2) > R_th_C;

    e12= R_F_xC2(PC2) > R_th_C;

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
    Throughput = R_th_E/2*( 1-OP_hxE_SIM )...
        + R_th_C/2*( 1-OP_xC2_SIM ) + R_th_C/2*( 1-OP_ADM_xC1_SIM );
    %
    out = Throughput;
    %
end