Sets
    X /x1, x2, x3/
    U /u1, u2, u3, u4/;

Variables
    xu(x,u)      'Variablen xi für jede Kombination aus X und U'
    y          'Variable y'
    z          'Zielfunktion';

Equation
    obj         'Zielfunktion'
    xu_positive
    y_lower
    y_upper
    sum_greater_100
    sum_smaller_106;

obj .. z =e= 5 * y * sum((X,U), xu(X,U));

xu_positive(X,U) .. xu(X,U) =g= 6;

y_lower .. y =g= 150;

y_upper .. y =l= 200;

sum_greater_100 .. sum((X,U), xu(X,U)) =g= 100;

sum_smaller_106 .. sum((X,U), xu(X,U)) =l= 106;

Model beispiel /all/;

Solve beispiel using minlp minimizing z;

Display xu.l, y.l, z.l;