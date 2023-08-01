function loadspectra(;N=7506, bnd=1)

    @printf("Returning %d number of spectra of dimension 1000\n", N)
    
    lcpath = dirname(pathof(PPCASpectra))

    A = readdlm(lcpath*"/fluxes.csv", ',')[1:N,:]

    notinf(x) = isinf(x) == false

    
    x = collect(LinRange(-abs(bnd), abs(bnd), 1000))
    
    X = [x[findall(notinf.(A[n,:]))] for n in 1:N]

    @printf("\t Wavelengths are in arbitrary units constrained on common grid between [%f,%f]\n",-abs(bnd),abs(bnd))

    Y = [max.(filter(notinf, A[n,:]), 0.0) for n in 1:N]

    @printf("\t Negative values have been replaced by zero.\n")


    return X, Y

end