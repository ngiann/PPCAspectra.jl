"""
    X, Y = loadspectra(;N=7506, bnd=NaN)

Load data from "A Spectral Model for Multimodal Redshift Estimation".
Argument N controls the number of spectra returned with N=7506 being the total available number.
If argumment bnd is specified, then the wavelengths will be scaled with in [-bnd, bnd]

Returns

- X is an array of arrays of wavelengths
- Y is an array of arrays of fluxes
"""
function loadspectra(;N=7506, bnd=NaN)

    @printf("Returning %d number of spectra of dimension 1000\n", N)
    
    lcpath = dirname(pathof(PPCASpectra))

    A = readdlm(lcpath*"/fluxes.csv", ',')[1:N,:]

    notinf(x) = isinf(x) == false

    if ~isnan(bnd)

        x = collect(LinRange(-abs(bnd), abs(bnd), 1000))
        
        X = [x[findall(notinf.(A[n,:]))] for n in 1:N]

        @printf("\t Wavelengths are in arbitrary units constrained on common grid between [%f,%f]\n",-abs(bnd),abs(bnd))


    else

        x = collect(LinRange(500.0, 10_400.0, 1000))
        
        X = [x[findall(notinf.(A[n,:]))] for n in 1:N]

        @printf("\t Wavelengths expressed in regular grid [500, 10400] of 1000 steps\n")

    end


    Y = [max.(filter(notinf, A[n,:]), 0.0) for n in 1:N]

    @printf("\t Negative values have been replaced by zero.\n")


    return X, Y

end