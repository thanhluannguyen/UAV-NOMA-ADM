function [Trace_X,Trace_Y] = Move2Waypoint(Leg,Velovity,dirMovement,X0,Y0,X1,Y1)
    %
    X_1 = X0;
    Y_1 = Y0;
    %
    X = [X0];
    Y = [Y0];
    %
    while Leg > sqrt((X_1-X0)^2+(Y_1-Y0)^2)
        X_2 = X_1 + Velovity.*cos(dirMovement);
        Y_2 = Y_1 + Velovity.*sin(dirMovement);
        %
        X_1 = X_2; 
        Y_1 = Y_2;
        %
        X = [X, X_1];
        Y = [Y, Y_1];
    end
    %
    X(end) = X1; Y(end) = Y1;
    %
    Trace_X = X;
    Trace_Y = Y;
    %
end