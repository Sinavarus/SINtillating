include("PhasePortraitV2.jl")

# Function for a dual repression system without cooperativity
# x1: range of x1 values (i.e. A values)
# x2: range of x2 values (i.e. R values)
# We use `@.` to apply the calculations across all rows.
# Note that model parameters are specified within the function
# Returns computed (dx1/dt, dx2/dt) over the range of (x1, x2)
function toggleMono(x1, x2)
    d1 = 2.0               #degradation rate const. for repressor 1
    d2 = 2.0               #degradation rate const. for repressor 2
    v1 = 1.0               #max generation rate of repressor 1
    v2 = 1.0               #max generation rate of repressor 2
    Ka1 = 4.0              #Association constant for repressor 1 - promot. 2
    Ka2 = 4.0              #Association constant for repressor 2 - promot. 1

    u = @. -d1*x1 + v1/(1+Ka2*x2) #eqn 11
    v = @. -d2*x2 + v2/(1+Ka1*x1)   #eqn 12

    return (u,v)
end

#Range of x1, x2 values
x1range = (0,1,15)          #Has the form (min, max, num points)
x2range = (0,1,15)          #Has the form (min, max, num points)
x₀ = ([0.9,0.35],)#[0.1, 0.0])  #initial state vectors; a common must be included after the first array
tspan=(0.0,30.0)             #time span

#Call the phaseplot functon to construct the phase portrait
phaseplot(toggleMono, x1range, x2range, xinit=x₀, t=tspan, clines=true,
        norm=true, scale=0.5)
