add_path_to_suitesparse();

A = load('case14.mat');
 
poolobj = parpool(2);

[Z,lu_factors] = compute_coefficients(A);

[V] = calculate_thevenin(A,Z,lu_factors);

delete(poolobj);
