function [ok] = add_path_to_suitesparse()
     % http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.5.5.tar.gz

    addpath ../SuiteSparse/KLU/MATLAB -END       
    addpath ../SuiteSparse/AMD/MATLAB -END       
    addpath ../SuiteSparse/BTF/MATLAB -END   
    addpath ../SuiteSparse/CXSparse/MATLAB/CSparse -END

end

