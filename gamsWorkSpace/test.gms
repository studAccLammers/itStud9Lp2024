Sets
    X /x1, x2, x3/;

Variables
    xi(X)      'Variablen xi für jedes Element in X'
    y          'Variable y'
    z          'Zielfunktion';
    
Binary Variables
    use(X);

Equation
    obj         'Zielfunktion'
    xi_positive
    y_lower
    y_upper
    sum_greater_100
    sum_smaller_106;

obj .. z =e= 5 * y * sum(X, xi(X));

xi_positive(X) .. xi(X) =g= 6;

y_lower .. y =g= 150;

y_upper .. y =l= 200;

sum_greater_100 .. sum(X, xi(X)) =g= 100;

sum_smaller_106 .. sum(X, xi(X)) =l= 106;

Model beispiel /all/;

Solve beispiel using minlp minimizing z;

Display xi.l, y.l, z.l;