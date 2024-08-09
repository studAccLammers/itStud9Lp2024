Sets
    p /p1*p3/
    s /s1*s2/
    t /t1*t5/
    TVM(t) /t2, t4/;

Parameters
    q_ps(p,s);

q_ps(p,s) = 1;

Variables
x_pst(p,s,t)
vQuali_ps(p,s);

Equations
    const_x_pst_smaller_q_ps_plus_v_quali_ps;
    
const_x_pst_smaller_q_ps_plus_v_quali_ps(p,s,t) ..
    x_pst(p,s,t) =l= q_ps(p,s) + vQuali_ps(p,s)  $ (not (t in TVM));