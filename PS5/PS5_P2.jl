include("PhasePortraitV2.jl")

# Function for a dual repression system without cooperativity
# x1: range of x1 values (i.e. A values)
# x2: range of x2 values (i.e. R values)
# We use `@.` to apply the calculations across all rows.
# Note that model parameters are specified within the function
# Returns computed (dx1/dt, dx2/dt) over the range of (x1, x2)
function toggleMono(Ca, Cr)

    Ror = 1
    Rr = 100
    Roa = 100
    Ra = 5000
    da = 30

    u = @. -da*Ca + (Roa+Ra*(Ca^2))/(1+Ca^2+Cr^2) #eqn 1
    v = @. -Cr + (Ror+Rr*(Ca^2))/(1+Ca^2)   #eqn 2

    return (u,v)
end

#Range of Ca, Cr values
Carange = (0,200,15)          #Has the form (min, max, num points)
Crrange = (0,100,15)          #Has the form (min, max, num points)
x₀ = ([1.0,10.0],)  #initial state vectors; a common must be included after the first array
tspan=(0.0,30.0)             #time span

#Call the phaseplot functon to construct the phase portrait
phaseplot(toggleMono, Carange, Crrange, xinit=x₀, t=tspan, clines=true,
        norm=true, scale=1)
