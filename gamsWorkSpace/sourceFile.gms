$ontext
Die nachfolgenden Sets definieren Teilmengen der Gesamtmenge der Ärzte.
- P:        Gesamte Menge der Ärzte von p1 bis p20.
- PAP(P):   assistent( p1 bis p5).
- PSP(P):   senior(p6 bis p10).
- PCP(P):   chief (p11 bis p15).
- PHP(P):   head (p16 bis p20).
$offtext
Sets
    P             /p1*p20/
    PAP(P)        /p1*p5/
    PSP(P)        /p6*p10/
    PCP(P)        /p11*p15/
    PHP(P)        /p16*p20/;
    

$ontext
Die nachfolgenden Sets definieren verschiedene Schichten und Abwesenheiten im Department of Anesthesiology.
- S:        Gesamte Menge der Roster-Icons.
- S0:       "Off".
- S1:       Schichten.
- S2:       Abwesenheiten, die nicht zu S0 gehören.
- SFRWE:    Schichten, die am Freitag stattfinden und nach 20 Uhr enden.
- SBD:      Schichten mit Standby-Zeit.
- SFZA:     Schichten, die einen folgenden freien Tag auslösen.
- SRD:      Schichten, die an Feiertagen oder Wochenenden stattfinden und kompensiert werden.
$offtext
Sets
    S                   / OP, IO, AO, PM, ZD, Z4, Z4F, S1, BD1, BD3, RB3, RB4, IOP, A73, V93, A93, A91, IOPL, TBA, XBD, FW, UR, KR, A, UR0, HO, Off / 
    S0(S)               / Off /
    S1(S)               / OP, IO, AO, PM, ZD, Z4, Z4F, S1, BD1, BD3, RB3, RB4, IOP, A73, V93, A93, A91, IOPL, TBA /
    S2(S)               / XBD, FW, UR, KR, A, UR0, HO /
    SFRWE(S)            / Z4F, S1, A73, V93, A91 /
    SBD(S)              / S1, BD1, BD3, A73, V93, A91 /
    SFZA(S)             / S1, BD1, BD3, A73, V93, A91 /
    SRD(S)              / A73, IOP, IOPL /
    S_without_AO_TBA(S) / OP, IO, PM, ZD, Z4, Z4F, S1, BD1, BD3, RB3, RB4, IOP, A73, V93, A93, A91, IOPL, XBD, FW, UR, KR, A, UR0, HO, Off /
    S_AO_TBA(S)         / AO, TBA /
    S_strich(S)         / BD1, BD3 /;

$ontext
Die nachfolgenden Sets definieren die Tage für den Deinstplan in diesem Fall Oktober 2024.
- T        Gesamte Menge der Tage.
- TVM:     7 Tage des vorherigen Monats.
- TAM:     Actual Month.
- TFM:     Tage bis nächsten Dienstag des Folgemonats.
- J:       Wochentage.
- TWkdy_J: Zuordnung der Tage zu den Wochentagen.
- THD:     Gesetzliche Feiertage.
- TWD:     Enthält alle Tage, die nicht in T_RD sind
- TRD:     Tage, die entweder gesetzliche Feiertage oder Wochenenden sind
$offtext
Sets
    T               /t924*t930, t1001*t1031, t1101*t1105/
    TVM(T)          /t924*t930/
    TAM(T)          /t1001*t1031/
    TFM(T)          /t1101*t1105/
    J               /Mon, Tue, Wed, Thu, Fri, Sat, Sun/    
    TWkdy_J(T, J)
    THD(T)          /t1003, t1031/
    TRD(T)
    TWD(T);

* Zuweisung der Wochentage zu den Tagen im Set T
TWkdy_J('t924', 'Tue') = yes;
TWkdy_J('t925', 'Wed') = yes;
TWkdy_J('t926', 'Thu') = yes;
TWkdy_J('t927', 'Fri') = yes;
TWkdy_J('t928', 'Sat') = yes;
TWkdy_J('t929', 'Sun') = yes;

TWkdy_J('t930', 'Mon') = yes;
TWkdy_J('t1001', 'Tue') = yes;
TWkdy_J('t1002', 'Wed') = yes;
TWkdy_J('t1003', 'Thu') = yes;
TWkdy_J('t1004', 'Fri') = yes;
TWkdy_J('t1005', 'Sat') = yes;
TWkdy_J('t1006', 'Sun') = yes;

TWkdy_J('t1007', 'Mon') = yes;
TWkdy_J('t1008', 'Tue') = yes;
TWkdy_J('t1009', 'Wed') = yes;
TWkdy_J('t1010', 'Thu') = yes;
TWkdy_J('t1011', 'Fri') = yes;
TWkdy_J('t1012', 'Sat') = yes;
TWkdy_J('t1013', 'Sun') = yes;

TWkdy_J('t1014', 'Mon') = yes;
TWkdy_J('t1015', 'Tue') = yes;
TWkdy_J('t1016', 'Wed') = yes;
TWkdy_J('t1017', 'Thu') = yes;
TWkdy_J('t1018', 'Fri') = yes;
TWkdy_J('t1019', 'Sat') = yes;
TWkdy_J('t1020', 'Sun') = yes;

TWkdy_J('t1021', 'Mon') = yes;
TWkdy_J('t1022', 'Tue') = yes;
TWkdy_J('t1023', 'Wed') = yes;
TWkdy_J('t1024', 'Thu') = yes;
TWkdy_J('t1025', 'Fri') = yes;
TWkdy_J('t1026', 'Sat') = yes;
TWkdy_J('t1027', 'Sun') = yes;

TWkdy_J('t1028', 'Mon') = yes;
TWkdy_J('t1029', 'Tue') = yes;
TWkdy_J('t1030', 'Wed') = yes;
TWkdy_J('t1031', 'Thu') = yes;
TWkdy_J('t1101', 'Fri') = yes;
TWkdy_J('t1102', 'Sat') = yes;
TWkdy_J('t1103', 'Sun') = yes;

TWkdy_J('t1104', 'Mon') = yes;
TWkdy_J('t1105', 'Tue') = yes;

TRD(t) = THD(t) or TWkdy_J(t, 'Sat') or TWkdy_J(t, 'Sun');
TWD(t) = not TRD(t);

Sets
    W /w0*w6/
    wFull_w(W) /w1,w2,w3,w4,w5/;
    
Sets
    I(p,s,t) //
    R(p,s,t) //;

Parameters
    alpha_1     /1/
    alpha_2     /1/
    beta_1      /1/
    beta_2      /1/
    beta_3      /1/
    beta_4      /1/
    gamma_1     /1/
    gamma_2     /1/
    delta_1     /1/
    delta_2     /1/
    delta_3     /1/
    delta_4     /1/
    delta_5     /1/
    delta_6     /1/
    delta_7     /1/
    omega_1     /1/
    omega_2     /1/
    contract(P) / p1 45, p2 50, p3 55, p4 60, p5 42, p6 47, p7 48, p8 49, p9 51, p10 52, p11 44, p12 40, p13 46, p14 50, p15 56, p16 38, p17 37, p18 35, p19 29, p20 25 /
    q_ps(p,s)
    c_st(s,t)
    cSP_st(s,t)
    cCP_st(s,t)
    FMin
    r_pst(p,s,t)
    MMax;
    
 q_ps(p,s) = 1;
 c_st(s,t) = 3;
 cSP_st(s,t) = 2;
 cCP_st(s,t) = 2;
 FMin = 2;
 r_pst(p,s,t) = 0;
 MMax = 6;

Variables
    v_st(s,t)
    vBD_p(p)
    vBD_p(p)
    vWEyn_p(p)
    vWEmin_p(p)
    ot_p(p)
    bdMax
    bdMin
    vAdy_pw(p,w)
    vIOMax_pw(p,w)
    ot_p(p)
    ut_p(p)
    obj;
    
Binary Variables
    x_pst(p,s,t)
    z_pw(p,w)
    vQuali_ps(p,s)
    vSP_st(s,t)
    vCP_st(s,t)
    vreq1_pst(p,s,t)
    vreq0_pst(p,s,t)
    vStretch_p(p)
    vOff_pt(p,t)
    vWErow_pw(p,w)
    vIOPL_pt(p,t)
    vIO_pt(p,t);
















*Zielformel
Equations 
    mip;
    
mip .. obj =e=    alpha_1 * sum((p, s), vQuali_ps(p, s))
                + alpha_2 * sum((S_without_AO_TBA, t), v_st(S_without_AO_TBA, t))
                + beta_1 * sum((S_AO_TBA, t), v_st(S_AO_TBA, t))
                + beta_2 * sum((p, s, t), (vreq1_pst(p, s, t) + vreq0_pst(p, s, t)))
                + beta_3 * sum((p, t), vOff_pt(p, t))
                + beta_4 * sum(p, vBD_p(p))
                + gamma_1 * sum(p, (vWEyn_p(p) + vWEmin_p(p)))
                + gamma_2 * sum((s, t), (vSP_st(s, t) + vCP_st(s, t)))
                + delta_1 * sum((p, w), vWErow_pw(p, w))
                + delta_2 * sum(p$(contract(p) < 40), ot_p(p))
                + delta_3 * (bdMax - bdMin)
                + delta_4 * sum(p, vStretch_p(p))
                + delta_5 * sum((p, w), vAdy_pw(p, w))
                + delta_6 * sum((p, t), vIOPL_pt(p, t))
                + delta_7 * (sum((p, t), vIO_pt(p, t)) + sum((p, w), vIOMax_pw(p, w)))
                + omega_1 * sum((p, s2, t), x_pst(p, s2, t))
                + omega_2 * sum(p$(contract(p) >= 40), ot_p(p));
                




















*Subject to                 
Equations 
    const_a_2
    const_a_3
    const_a_4
    const_a_5
    const_a_6
    const_a_7
    const_a_8
    const_a_9
    const_a_10
    const_a_11;
    
*Dok Constraint A.2
const_a_2(p,t) .. sum(s, x_pst(p,s,t)) =e= 1;

*Dok Constraint A.3
const_a_3(p,s,t)$(not TVM(t)) .. x_pst(p,s,t) =l= (q_ps(p,s) + vQuali_ps(p,s));

*Dok Constraint A.4
const_a_4(p,s,t)$(S1(s) and not TVM(t)) .. x_pst(p,s,t) =l= q_ps(p,s) + vQuali_ps(p,s);

*Dok Constraint A.5
const_a_5(s,t)$(not TVM(t)) .. sum(p$(not PAP(p)), x_pst(p,s,t)) =g= cSP_st(s,t) - vSP_st(s,t);

*Dok Constraint A.6
const_a_6(s,t)$(not TVM(t)) .. sum(p$(PCP(p) or PHP(p)), x_pst(p,s,t)) =g= cCP_st(s,t) - vCP_st(s,t);

*Dok Constraint A.7
const_a_7(t)$(TWD(t) and not TVM(t)) .. sum((p,s)$(not PAP(p)), x_pst(p,s,t)) =g= FMin;

*Dok Constraint A.8
const_a_8(t)$(TRD(t) and not TVM(t)) .. sum((p)$(not PAP(p)),((1/2) * sum((s)$(SRD(s)), x_pst(p,s,t)) + sum((s)$(S_strich(s)), x_pst(p,s,t)))) =g= FMin;

*Dok Constraint A.9
const_a_9(p,s,t)$(I(p,s,t)) .. x_pst(p,s,t) =e= 1;

*Dok Constraint A.10
const_a_10(p,s,t)$(R(p,s,t)) .. x_pst(p,s,t) =e= r_pst(p,s,t) - vreq1_pst(p,s,t) + vreq0_pst(p,s,t);

*Dok Constraint A.11
Set
    T_minus_MMax(t,t);
    
Alias(t, tt);
T_minus_MMax(t,t) = no;
loop(t,
    loop(tt$(ord(tt) <= ord(t) and ord(tt) > ord(t) - MMax),
        T_minus_MMax(t,tt) = yes;
    );
);
const_a_11(p,t)$(not TVM(t)) .. sum((s,tt)$(T_minus_MMax(t,tt) and S1(s)), x_pst(p,s,tt)) =l= MMax + vStretch_p(p);






*Solve
Model optModel /mip, const_a_2/;
Solve optModel using mip minimizing obj;


*Output in File
file outputFileSimple / 'output_s.txt' /;

put outputFileSimple;

loop((p,s,t),
    if(x_pst.l(p,s,t) = 1,
        put p.tl:0, ' ', s.tl:0, ' ', t.tl:0 /;
    );
);

putclose outputFileSimple;



file outputFileTable / 'output_t.txt' /;

put outputFileTable;

* Print table header with t values
put 'p' @10;
loop(t, 
    put t.tl:10;
);
put /;

* Generate table rows
loop(p, 
    put p.tl:10 @10;
    loop(t, 
        if(sum(s, x_pst.l(p,s,t)) > 0,
            loop(s,
                if(x_pst.l(p,s,t) = 1,
                    put s.tl:10;
                );
            );
        else
            put "":10;
        );
    );
    put /;
);

putclose outputFileTable;