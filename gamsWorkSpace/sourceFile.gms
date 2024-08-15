$ontext
Die nachfolgenden Sets definieren Teilmengen der Gesamtmenge der Ärzte. Ausgelesen aus Excel.
- P:        Gesamte Menge der Ärzte von p1 bis p20.
- PAP(P):   assisten.
- PSP(P):   senior.
- PCP(P):   chief.
- PHP(P):   head.
$offtext
$call gdxxrw inputData.xlsx output=qualification.gdx par=pData rng=Sheet1!A1

Parameter
    pData(*, *)

$gdxin qualification.gdx
$load pData
$gdxin

Sets
    P       /p1*p1000/
    ActualP(P)
    PAP(P)
    PSP(P)
    PCP(P)
    PHP(P);

PAP(P) = yes$pData(P, 'PAP');
PSP(P) = yes$pData(P, 'PSP');
PCP(P) = yes$pData(P, 'PCP');
PHP(P) = yes$pData(P, 'PHP');
ActualP(P) = PAP(P) or PSP(P) or PCP(P) or PHP(P);
    

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
    S_AO_TBA(S)         / AO, TBA /
    S_BD1_BD3(S)        / BD1, BD3 /
    S_A73_S1(S)         / A73, S1 /
    S_A(S)              / A /
    S_XBD(S)            / XBD /
    S_IOP(S)            / IOP /
    S_IOPL(S)           / IOPL /
    S_A73(S)            / A73/
    S_IO(S)             / IO /
    S_HO(S)             / HO /;

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

$call gdxxrw inputData.xlsx output=monthCategory.gdx par=tData rng=Sheet3!A1

Parameter
    tData(*, *)

$gdxin days.gdx
$load tData
$gdxin

$call gdxxrw inputData.xlsx output=monthCategory.gdx par=tMonthCatData rng=Sheet5!A1

Parameter
    tMonthCatData(*, *)

$gdxin monthCategory.gdx
$load tMonthCatData
$gdxin

$call gdxxrw inputData.xlsx output=firstT.gdx par=firstTData rng=Sheet6!A1

Parameter
    firstTData(*, *)

$gdxin firstT.gdx
$load firstTData
$gdxin

$call gdxxrw inputData.xlsx output=holidayT.gdx par=holidayTData rng=Sheet7!A1

Parameter
    holidayTData(*, *)

$gdxin holidayT.gdx
$load holidayTData
$gdxin

$offOrder

Sets
    T               /t0101*t0131, t0201*t0229, t0301*t0331, t0401*t0430, t0501*t0531, t0601*t0630, t0701*t0731, t0801*t0831, t0901*t0930, t1001*t1031, t1101*t1130, t1201*t1231/
    actualT(T)
    TVM(T)         
    TAM(T)          
    TFM(T)         
    J               /Mon, Tue, Wed, Thu, Fri, Sat, Sun/
    tMonthCat       /TVM, TAM, TFM/
    THD(T)
    T_first(T)   
    TWkdy_J(T, J)
    TRD(T)
    TWD(T)
    TRD_without_first(T)
    TWD_without_first(T);

actualT(T) =  yes$(sum(j,tData(T,J)) > 0);
TVM(T) =  yes$(sum(tMonthCat,tMonthCatData(T,'TVM')) > 0);
TAM(T) =  yes$(sum(tMonthCat,tMonthCatData(T,'TAM')) > 0);
TFM(T) =  yes$(sum(tMonthCat,tMonthCatData(T,'TFM')) > 0);

* Zuweisung der Wochentage zu den Tagen im Set T
TWkdy_J(T, J) = tData(T,J);

* Setzen Sie T_first mit dem ersten tatsächlichen Element
T_first(T) = yes$(firstTData(T,'first') > 0);
THD(T) = yes$(holidayTData(T,'THD') > 0);
TRD(T) = THD(t) or TWkdy_J(t, 'Sat') or TWkdy_J(t, 'Sun');
TWD(T) = actualT(T) and  not TRD(t);
TRD_without_first(T) = TRD(t) and not T_first(t);
TWD_without_first(T) = TWD(t) and not T_first(t);

$call gdxxrw inputData.xlsx output=weeks.gdx par=wData rng=Sheet4!A1

Parameter
    wData(*, *)

$gdxin weeks.gdx
$load wData
$gdxin

Sets
    W /w0*w10/
    actualW(W)
    w_without_w0(W)
    w_w0(W)
    w_w1(W)
    w_w2_to_end_minus_one(W)
    wFull(W)
    TWeek_W(T, W);
    
actualW(W) =  yes$(sum(t,wData(T,W)) > 0);

w_w0(W) = yes$(actualW(W) and ord(W) = 1);    
w_w1(W) = yes$(actualW(W) and ord(W) = 2);
w_w2_to_end_minus_one(W) = yes$(actualW(W) and ord(W) >= 3 and ord(W) <= card(actualW) - 1);
wFull(W) = yes$(actualW(W) and ord(W) > 1 and ord(W) < card(actualW));
w_without_w0(W) = actualW(W) and not w_w0(W);


*Zuweisung der Wochentage zu den Wochen im Set W
TWeek_W(T,W) = wData(T,W);

Sets
    I(p,s,t) //
    R(p,s,t) //;

Parameters
    alpha_1     /0.75/
    alpha_2     /0.85/
    beta_1      /0.7/
    beta_2      /0.6/
    beta_3      /0.6/
    beta_4      /0.7/
    gamma_1     /0.7/
    gamma_2     /0.85/
    delta_1     /0.7/
    delta_2     /0.6/
    delta_3     /0.7/
    delta_4     /0.8/
    delta_5     /0.5/
    delta_6     /0.85/
    delta_7     /0.7/
    omega_1     /0.4/
    omega_2     /0.5/
    contractInputData(*,*)
    contract(P)
    q_ps(p,s)
    c_st(s,t)
    cSP_st(s,t)
    cCP_st(s,t)
    FMin
    r_pst(p,s,t)
    MMax
    nBD(p)
    BDMaxParam(p)
    BDDays
    AMin_pw(p,w)
    k0_p(p)
    lEnd
    nWE_p(p)
    KMin
    hStdrd_s(s)
    hTimeAcc_p(p)
    HTimeAccParam
    OTMax_p(p)
    hLegal_s(s)
    HMax_p(p)
    L26W_p(p)
    h26Wacc_p(p)
    f0_p(p);
    
$call gdxxrw inputData.xlsx output=contract.gdx par=contractInputData rng=Sheet2!A1

$gdxin contract.gdx
$load contractInputData
$gdxin

Contract(P) = contractInputData(P, 'Contract');

 q_ps(p,s) = 1;
 c_st(s,t) = 1;
 cSP_st(s,t) = 1;
 cCP_st(s,t) = 1;
 FMin = 1;
 r_pst(p,s,t) = 0;
 MMax = 6;
 nBD(p) = 1;
 BDMaxParam(p) = 50;
 BDDays = 1;
 AMin_pw(p,w) = 0;
 k0_p(p) = 0;
 lEnd = 6;
 nWE_p(p) = 1;
 KMin = 1;
 hStdrd_s(s) = 6;
 hTimeAcc_p(p) = 0;
 HTimeAccParam = 60 * 4;
 OTMax_p(p) = 80;
 hLegal_s(s) = 8;
 HMax_p(p) = 60;
 f0_p(p) = 0;
 
* Quartal with 13 Weeks
 L26W_p(p) = 13;
 h26Wacc_p(p) = 550;


Variables
    ot_p(p)
    ut_p(p)
    obj;

Integer Variables
    bdMin
    bdMax
    v_st(s,t)
    vSP_st(s,t)
    vCP_st(s,t)
    vBD(p)
    vAdy_pw(p,w)
    vWEyn_p(p)
    vWEmin_p(p)
    vIOMax_pw(p,w);

Binary Variables
    x_pst(p,s,t)
    z_pw(p,w)
    vQuali_ps(p,s)
    vreq1_pst(p,s,t)
    vreq0_pst(p,s,t)
    vStretch_p(p)
    vOff_pt(p,t)
    vWErow_pw(p,w)
    vIOPL_pt(p,t)
    vIO_pt(p,t);

















Equations 
    mip;
    
mip .. obj =e=    alpha_1 * sum((p, s)$(ActualP(p)), vQuali_ps(p, s))
                + alpha_2 * sum((s, t)$(not S_AO_TBA(s)), v_st(s, t))
                + beta_1 *  sum((s, t)$(S_AO_TBA(s)), v_st(s, t))
                + beta_2 *  sum((p, s, t)$(ActualP(p)), (vreq1_pst(p, s, t) + vreq0_pst(p, s, t)))
                + beta_3 *  sum((p, t)$(ActualP(p)), vOff_pt(p, t))
                + beta_4 *  sum((p)$(ActualP(p)), vBD(p))
                + gamma_1 * sum((p)$(ActualP(p)), (vWEyn_p(p) + vWEmin_p(p)))
                + gamma_2 * sum((s, t), (vSP_st(s, t) + vCP_st(s, t)))
                + delta_1 * sum((p, w)$(ActualP(p)), vWErow_pw(p, w))
                + delta_2 * sum(p$(ActualP(p) and contract(p) < 40), ot_p(p))
                + delta_3 * (bdMax - bdMin)
                + delta_4 * sum(p$(ActualP(p)), vStretch_p(p))
                + delta_5 * sum((p, w)$(ActualP(p)), vAdy_pw(p, w))
                + delta_6 * sum((p, t)$(ActualP(p)), vIOPL_pt(p, t))
                + delta_7 * (sum((p, t)$(ActualP(p)), vIO_pt(p, t)) + sum((p, w), vIOMax_pw(p, w)))
                + omega_1 * sum((p, s, t)$(ActualP(p) and S2(s)), x_pst(p, s, t))
                + omega_2 * sum(p$(ActualP(p) and contract(p) >= 40), ot_p(p));
                




















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
    const_a_11
    const_a_12
    const_a_13
    const_a_14
    const_a_15
    const_a_16
    const_a_17
    const_a_18
    const_a_19
    const_a_20
    const_a_21
    const_a_22
    const_a_23
    const_a_24
    const_a_25
    const_a_26
    const_a_27
    const_a_28
    const_a_29
    const_a_30
    const_a_31
    const_a_32
    const_a_33
    const_a_34
    
    const_a_35
    const_a_36
    const_a_37
    const_a_38
    const_a_39
    const_a_40
    
    const_a_42a
    const_a_42b
    
    const_a_43a
    const_a_43b
    const_a_43c
    const_a_43d
    const_a_43e
    const_a_43f
    const_a_43g
    const_a_43h
    const_a_43i
    const_a_43j
    
    const_a_44
    const_a_45;
    
Alias(t, tt);
    
*Dok Constraint A.2
const_a_2(p,t)$(ActualP(p)) .. sum(s, x_pst(p,s,t)) =e= 1;

*Dok Constraint A.3
const_a_3(p,s,t)$(ActualP(p) and not TVM(t)) .. x_pst(p,s,t) =l= (q_ps(p,s) + vQuali_ps(p,s));

*Dok Constraint A.4
const_a_4(s,t)$(S1(s) and not TVM(t)) .. sum((p)$(ActualP(p)), x_pst(p,s,t)) =e= c_st(s,t) - v_st(s,t);

*Dok Constraint A.5
const_a_5(s,t)$(not TVM(t)) .. sum(p$(ActualP(p) and not PAP(p)), x_pst(p,s,t)) =g= cSP_st(s,t) - vSP_st(s,t);

*Dok Constraint A.6
const_a_6(s,t)$(not TVM(t)) .. sum(p$(ActualP(p) and PCP(p) or PHP(p)), x_pst(p,s,t)) =g= cCP_st(s,t) - vCP_st(s,t);

*Dok Constraint A.7
const_a_7(t)$(TWD(t) and not TVM(t)) .. sum((p,s)$(ActualP(p) and S_A73_S1(s) and not PAP(p)), x_pst(p,s,t)) =g= FMin;

*Dok Constraint A.8
Alias(s, ss);
const_a_8(t)$(TRD(t) and not TVM(t)) .. sum((p)$(ActualP(p) and not PAP(p)),((1/2) * sum((s)$(SRD(s)), x_pst(p,s,t)) + sum((ss)$(S_BD1_BD3(ss)), x_pst(p,ss,t)))) =g= FMin;

*Dok Constraint A.9
const_a_9(p,s,t)$(ActualP(p) and I(p,s,t)) .. x_pst(p,s,t) =e= 1;

*Dok Constraint A.10
const_a_10(p,s,t)$(ActualP(p) and R(p,s,t)) .. x_pst(p,s,t) =e= r_pst(p,s,t) - vreq1_pst(p,s,t) + vreq0_pst(p,s,t);

*Dok Constraint A.11
Set
    T_minus_MMax_to_t(t,t);
    
Alias(t, tMinusMMaxToT);
T_minus_MMax_to_t(t,t) = no;
loop(t,
    loop(tMinusMMaxToT$(ord(tMinusMMaxToT) <= ord(t) and ord(tMinusMMaxToT) >= ord(t) - MMax),
        T_minus_MMax_to_t(t,tMinusMMaxToT) = yes;
    );
);
const_a_11(p,t)$(ActualP(p) and not TVM(t)) .. sum((s,tMinusMMaxToT)$(T_minus_MMax_to_t(t,tMinusMMaxToT) and S1(s)), x_pst(p,s,tMinusMMaxToT)) =l= MMax + vStretch_p(p);

*Dok Constraint A.12
const_a_12(p)$(ActualP(p)) .. sum((s,t)$(SBD(s) and TAM(t)), x_pst(p,s,t)) =g= bdMin * nBD(p);

*Dok Constraint A.13
const_a_13(p)$(ActualP(p)) .. sum((s,t)$(SBD(s) and TAM(t)), x_pst(p,s,t)) =l= bdMax;

*Dok Constraint A.14
const_a_14(p)$(ActualP(p)) .. sum((s,t)$(SBD(s) and TAM(t)), x_pst(p,s,t)) =l= BDMaxParam(p) * nBD(p) + vBD(p);

*Dok Constraint A.15
Set
    T_minus_BDDays_to_minus_one(t,t);
Alias(t, tMinusBDDaysToMinusOne);
T_minus_BDDays_to_minus_one(t,t) = no;
loop(t,
    loop(tMinusBDDaysToMinusOne$(ord(tMinusBDDaysToMinusOne) < ord(t) and ord(tMinusBDDaysToMinusOne) >= ord(t) - BDDays),
        T_minus_BDDays_to_minus_one(t,tMinusBDDaysToMinusOne) = yes;
    );
);
const_a_15(p,t,tMinusBDDaysToMinusOne)$(ActualP(p) and T_minus_BDDays_to_minus_one(t,tMinusBDDaysToMinusOne) and not TVM(t)) .. 1 - sum((s)$(SBD(s)), x_pst(p,s,t)) =g= sum((ss)$(SBD(ss)), x_pst(p,ss,tMinusBDDaysToMinusOne));


*Dok Constraint A.16
const_a_16(p,s,w)$(ActualP(p) and w_without_w0(w) and S_A(s)) .. sum((t)$(TWD(t) and TWeek_W(t,w)), x_pst(p,s,t)) =g= AMin_pw(p,w) - vAdy_pw(p,w);

*Dok Constraint A.17
Set
    intersection_TWD_TAM(T);
    
intersection_TWD_TAM(t) = TWD(t) and TAM(t);

const_a_17(p,s)$(ActualP(p) and S_A(s)) .. sum((t)$(TWD(t) and TAM(t)), x_pst(p,s,t)) =g= abs((1-(contract(p)/40)) * card(intersection_TWD_TAM))

*Dok Constraint A.18
Set
    T_minus_One(t,t);
Alias(t, tMinusOne);
T_minus_One(t,t) = no;
loop(t,
    loop(tMinusOne$(ord(tMinusOne) = ord(t) - 1),
        T_minus_One(t,tMinusOne) = yes;
    );
);
const_a_18(p,ss,t,tMinusOne)$(ActualP(p) and S0(ss) and TRD_without_first(t) and T_minus_One(t,tMinusOne)) .. sum((s)$(SFZA(s)), x_pst(p,s,tMinusOne)) =l= x_pst(p,ss,t);

*Dok Constraint A.19
const_a_19(p,ss,t,tMinusOne)$(ActualP(p) and S_XBD(ss) and TWD_without_first(t) and T_minus_One(t,tMinusOne)) .. sum((s)$(SFZA(s)), x_pst(p,s,tMinusOne)) =e= x_pst(p,ss,t);

*Dok Constraint A.20
const_a_20(p,s,t)$(ActualP(p) and S_XBD(s) and TRD(t)) .. x_pst(p,s,t) =e= 0;

*Dok Constraint A.21
Set
    T_minus_Five_and_Six(t,t);
Alias(t, tMinusFiveAndSix);
T_minus_Five_and_Six(t,t) = no;
loop(t,
    loop(tMinusFiveAndSix$((ord(tMinusFiveAndSix) = ord(t) - 5) or (ord(tMinusFiveAndSix) = ord(t) - 6)),
        T_minus_Five_and_Six(t,tMinusFiveAndSix) = yes;
    );
);
const_a_21(p,s,ss,t,tMinusFiveAndSix)$(ActualP(p) and S0(s) and S_IOP(ss) and TWkdy_J(t, 'Fri') and not TVM(t) and T_minus_Five_and_Six(t,tMinusFiveAndSix)) .. x_pst(p,s,t) =g= x_pst(p,ss,tMinusFiveAndSix) - vOff_pt(p,t);

*Dok Constraint A.22
Set
    T_minus_Five(t,t);
Alias(t, tMinusFive);
T_minus_Five(t,t) = no;
loop(t,
    loop(tMinusFive$(ord(tMinusFive) = ord(t) - 5),
        T_minus_Five(t,tMinusFive) = yes;
    );
);

Set
    T_minus_Four(t,t);
Alias(t, tMinusFour);
T_minus_Four(t,t) = no;
loop(t,
    loop(tMinusFour$(ord(tMinusFour) = ord(t) - 4),
        T_minus_Four(t,tMinusFour) = yes;
    );
);
const_a_22(p,s,ss,t,tMinusFive, tMinusFour)$(ActualP(p) and S0(s) and S_IOP(ss) and TWkdy_J(t, 'Thu') and not TVM(t) and T_minus_Five(t, tMinusFive) and T_minus_Four(t,tMinusFour)) .. x_pst(p,s,t) =g= x_pst(p,ss,tMinusFive) + x_pst(p,ss,tMinusFour) - 1 - vOff_pt(p,t);

*Dok Constraint A.23
Set
    T_minus_Two(t,t);
Alias(t, tMinusTwo);
T_minus_Two(t,t) = no;
loop(t,
    loop(tMinusTwo$(ord(tMinusTwo) = ord(t) - 2),
        T_minus_Two(t,tMinusTwo) = yes;
    );
);
const_a_23(p,s,ss,t,tMinusTwo)$(ActualP(p) and S0(s) and S_A73(ss) and (TWkdy_J(t, 'Mon') or TWkdy_J(t, 'Tue')) and not (TVM(t)) and T_minus_Two(t,tMinusTwo)) .. x_pst(p,s,t) =g= x_pst(p,ss,tMinusTwo) - vOff_pt(p,t);

*Dok Constraint A.24
const_a_24(p,w,t)$(ActualP(p) and w_without_w0(w) and (TWeek_W(t,w) and (TWkdy_J(t, 'Sat') or TWkdy_J(t, 'Sun')))) .. z_pw(p,w) =g= sum((s)$(S1(s)), x_pst(p,s,t));

*Dok Constraint A.25
const_a_25(p,w,t)$(ActualP(p) and w_without_w0(w) and (TWeek_W(t,w) and TWkdy_J(t, 'Fri'))) .. z_pw(p,w) =g= sum((s)$(SFRWE(s)), x_pst(p,s,t));

*Dok Constraint A.26
const_a_26(p,w)$(ActualP(p) and w_without_w0(w)) .. z_pw(p,w) =l= sum((s,t)$(S1(s) and (TWeek_W(t,w) and (TWkdy_J(t, 'Sat') or TWkdy_J(t, 'Sun')))), x_pst(p,s,t)) + sum((ss,t)$(SFRWE(ss) and (TWeek_W(t,w) and TWkdy_J(t, 'Fri'))), x_pst(p,ss,t));

*Dok Constraint A.27
const_a_27(p,w)$(ActualP(p) and w_w0(w)) .. z_pw(p,w) =e= k0_p(p);

*Dok Constraint A.28
const_a_28(p)$(ActualP(p)) .. sum((w)$(w_without_w0(w)), z_pw(p,w)) =l= lEnd * nWE_p(p) + vWEyn_p(p);

*Dok Constraint A.29
const_a_29(p)$(ActualP(p)) .. sum((w)$(wFull(w)), z_pw(p,w)) =l= card(wFull) - KMin + vWEmin_p(p);

*Dok Constraint A.30
Set
    W_minus_One(w,w);
Alias(w, wMinusOne);
W_minus_One(w,w) = no;
loop(w,
    loop(wMinusOne$(ord(wMinusOne) = ord(w) - 1),
        W_minus_One(w,wMinusOne) = yes;
    );
);
const_a_30(p,w, wMinusOne)$(ActualP(p) and w_without_w0(w) and W_minus_One(w,wMinusOne)) .. z_pw(p,w) + z_pw(p,wMinusOne) =l= 1 + vWErow_pw(p,w);

*Dok Constraint A.31
const_a_31(p)$(ActualP(p)) .. sum((s,t)$(TAM(t)), hStdrd_s(s) * x_pst(p,s,t)) =e= (contract(p)/5) * card(intersection_TWD_TAM) - ut_p(p) + ot_p(p);

*Dok Constraint A.32
const_a_32(p)$(ActualP(p)) .. hTimeAcc_p(p) - ut_p(p) + ot_p(p) =l= HTimeAccParam * contract(p);

*Dok Constraint A.33
const_a_33(p)$(ActualP(p)) .. ot_p(p) =l= OTMax_p(p);

*Dok Constraint A.34
const_a_34(p,w)$(ActualP(p) and w_without_w0(w)) .. sum((s,t)$(TWeek_W(t,w)), hLegal_s(s) * x_pst(p,s,t)) =l= HMax_p(p);

*Dok Constraint A.35
const_a_35(p)$(ActualP(p)) .. (1/L26W_p(p)) * (h26Wacc_p(p) + sum((w,s,t)$(WFull(w) and TWeek_W(t,w)), hLegal_s(s) * x_pst(p,s,t))) =l= h26Wacc_p(p) * contract(p);

*Dok Constraint A.36
Set
    T_plus_One_to_Five(t,t);
Alias(t, tPlusOneToFive);
T_plus_One_to_Five(t,t) = no;
loop(t,
    loop(tPlusOneToFive$(ord(tPlusOneToFive) > ord(t) and ord(tPlusOneToFive) <= ord(t) + 5),
        T_plus_One_to_Five(t,tPlusOneToFive) = yes;
    );
);
const_a_36(p,s,ss,t,tPlusOneToFive)$(ActualP(p) and S_IOPL(s) and S_IOP(ss) and T_plus_One_to_Five(t, tPlusOneToFive)) .. x_pst(p,s,t) =l= x_pst(p,ss,tPlusOneToFive);


*Dok Constraint A.37
Set
    T_plus_Six(t,t);
Alias(t, tPlusSix);
T_plus_Six(t,t) = no;
loop(t,
    loop(tPlusSix$(ord(tPlusSix) = ord(t) + 6),
        T_plus_Six(t,tPlusSix) = yes;
    );
);
const_a_37(p,s,ss,t, tPlusSix)$(ActualP(p) and S_IOPL(s) and S_A73(ss) and T_plus_Six(t, tPlusSix)) .. x_pst(p,s,t) =l= x_pst(p,ss,tPlusSix) + vIOPL_pt(p,tPlusSix);

*Dok Constraint A.38
Set
    T_plus_One(t,t);
Alias(t, tPlusOne);
T_plus_One(t,t) = no;
loop(t,
    loop(tPlusOne$(ord(tPlusOne) = ord(t) + 1),
        T_plus_One(t,tPlusOne) = yes;
    );
);
const_a_38(p,s,t,tPlusOne)$(ActualP(p) and S_IO(s) and (TWkdy_J(t, 'Mon') or TWkdy_J(t, 'Tue') or TWkdy_J(t, 'Wed') or TWkdy_J(t, 'Thu')) and T_plus_One(t, tPlusOne)) .. x_pst(p,s,t) =l= x_pst(p,s,tPlusOne) + vIO_pt(p,t);

*Dok Constraint A.39
Set
    T_plus_Three(t,t);
Alias(t, tPlusThree);
T_plus_Three(t,t) = no;
loop(t,
    loop(tPlusThree$(ord(tPlusThree) = ord(t) + 3),
        T_plus_Three(t,tPlusThree) = yes;
    );
);
const_a_39(p,s,t,tPlusThree)$(ActualP(p) and S_IO(s) and TWkdy_J(t, 'Fri') and T_plus_Three(t, tPlusThree)) .. x_pst(p,s,t) =l= x_pst(p,s,tPlusThree) + vIO_pt(p,t);

*Dok Constraint A.40
Set
    T_Week_W_Minus_One_W(t,w,w);
Alias(w, tWeekWMinusOneW);
T_Week_W_Minus_One_W(t, w, w) = no;
loop((t,w),
    loop(tWeekWMinusOneW$(ord(tWeekWMinusOneW) = ord(w) - 1),
        T_Week_W_Minus_One_W(t,w,tWeekWMinusOneW) = yes;
    );
);
const_a_40(p,s,w,tWeekWMinusOneW)$(ActualP(p) and S_IO(s)) .. sum((t)$(TWeek_W(t,w)), x_pst(p,s,t)) + sum((tt)$(T_Week_W_Minus_One_W(tt,w,tWeekWMinusOneW)), x_pst(p,s,tt)) =l= 4 + vIOMax_pw(p,w);

*Dok Constraint A.41 constraint already defined in variable declaration

*Dok Constraint A.42
const_a_42a(p)$(ActualP(p)) .. ot_p(p) =g= 0;
const_a_42b(p)$(ActualP(p)) .. ut_p(p) =g= 0;

*Dok Constraint A.43 - integer constraint already defined in variable declaration
const_a_43a .. bdMin =g= 0;
const_a_43b .. bdMax =g= 0;
const_a_43c(s,t) .. v_st(s,t) =g= 0;
const_a_43d(s,t) .. vSP_st(s,t) =g= 0;
const_a_43e(s,t) .. vCP_st(s,t) =g= 0;
const_a_43f(p)$(ActualP(p)) .. vBD(p) =g= 0;
const_a_43g(p,w)$(ActualP(p)) .. vAdy_pw(p,w) =g= 0;
const_a_43h(p)$(ActualP(p)) .. vWEyn_p(p) =g= 0;
const_a_43i(p)$(ActualP(p)) .. vWEmin_p(p) =g= 0;
const_a_43j(p,w)$(ActualP(p)) .. vIOMax_pw(p,w) =g= 0;

*Dok Constraint A.44
const_a_44(p,s,w, tWeekWMinusOneW)$(ActualP(p) and S_HO(s) and w_w2_to_end_minus_one(w)) .. sum((ss, tt)$(SRD(ss) and (T_Week_W_Minus_One_W(tt,w,tWeekWMinusOneW) and TWD(tt))), x_pst(p,ss,tt)) =l= sum((t)$(TWeek_W(t,w) and TWD(t)), x_pst(p,s,t));

*Dok Constraint A.45
const_a_45(p,s,w)$(ActualP(p) and  S_HO(s) and w_w1(w)) .. f0_p(p) =l= sum((t)$(TWeek_W(t,w) and TWD(t)), x_pst(p,s,t));






















*Solve
option mip = CPLEX;
option optcr = 0.01; 
Model optModel /all/;
Solve optModel using mip minimizing obj;
























display x_pst.l;


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