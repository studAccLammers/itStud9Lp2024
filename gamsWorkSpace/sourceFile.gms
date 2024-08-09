$ontext
Die nachfolgenden Sets definieren Teilmengen der Gesamtmenge der Ärzte.
- P:        Gesamte Menge der Ärzte von p1 bis p20.
- PAP(P):   assistent( p1 bis p5).
- PSP(P):   senior(p6 bis p10).
- PCP(P):   chief (p11 bis p15).
- PHP(P):   head (p16 bis p20).
$offtext
Sets
    P      /p1*p20/
    PAP(P) /p1*p5/
    PSP(P) /p6*p10/
    PCP(P) /p11*p15/
    PHP(P) /p16*p20/;
    

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
    S       / OP, IO, AO, PM, ZD, Z4, Z4F, S1, BD1, BD3, RB3, RB4, IOP, A73, V93, A93, A91, IOPL, TBA, XBD, FW, UR, KR, A, UR0, HO, Off / 
    S0(S)   / Off /
    S1(S)   / OP, IO, AO, PM, ZD, Z4, Z4F, S1, BD1, BD3, RB3, RB4, IOP, A73, V93, A93, A91, IOPL, TBA /
    S2(S)   / XBD, FW, UR, KR, A, UR0, HO /
    SFRWE(S)/ Z4F, S1, A73, V93, A91 /
    SBD(S)  / S1, BD1, BD3, A73, V93, A91 /
    SFZA(S) / S1, BD1, BD3, A73, V93, A91 /
    SRD(S)  / A73, IOP, IOPL /;