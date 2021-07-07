## Pacotes

using Pkg
Pkg.add("Interpolations")
Pkg.add("DataInterpolations")
Pkg.add("BarycentricInterpolation")
Pkg.add("Polynomials")
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("GR")
Pkg.add("PlotThemes")
##
using BarycentricInterpolation;
using Interpolations
using Polynomials
using DataInterpolations
using Plots
using DataFrames
using LaTeXStrings
using PlotThemes
using DelimitedFiles
using PyPlot;
py = PyPlot;
using PlotUtils
# using GR

# g = open("./data/al203.dat")

# open("./data/al203.dat") do f
#     for i in range(1, 4, step=1)
#         s = readline(f)
#         println("$s")
#         # println("$s = readline(f)")
#     end
# end

# # h = read(io,"./data/al203.txt")
# open("./data/al203.txt") do f
#     readlines(f)
# end

plotly()
# pgfplotsx()
# gr()
# Aluminio 203
al203_data=readdlm("./data/al203.txt", '\t', '\n')
al203_T, al203_l = al203_data[:,1],al203_data[:,2]

al203 = QuadraticSpline(al203_T, al203_l)
# theme()
Plots.plot(al203_T, al203_l, label="Aluminio 203")
# al203_p = GR.scatter(al203_T, al203_l, label="Al203", marker=:star)
plot!(xlabel = "Resistência")
plot!(ylabel = L"\textrm{Deformacao} \ \quad \frac{\Delta l}{l_0}", fontfamily="Computer Modern",)

##### Titanio
## Dados
# resistência termistor	deformação
# Ohm	
# 	Titânio
##
#####

titanio_data=readdlm("./data/titanio.txt", '\t', '\n')
titanio_T, titanio_l = titanio_data[:,1],titanio_data[:,2]

titanio = QuadraticSpline(titanio_T, titanio_l)
# close()
titanio_p = Plots.plot!(titanio_T, titanio_l, label="Titanio")
plot!(xlabel = "Resistência")
plot!(ylabel = L"\textrm{Deformacao} \ \quad \frac{\Delta l}{l_0}", fontfamily="Computer Modern")


##### 
## Dados
# resistência termistor	deformação
# Ohm	
# Teflon	Teflon
# ##
#####

teflon_data=readdlm("./data/ptfe.txt", '\t', '\n')
teflon_T, teflon_l = teflon_data[:,1],teflon_data[:,2]

# teflon = QuadraticSpline(teflon_T, teflon_l)
teflon_p = plot!(teflon_T, teflon_l, label="Teflon")
plot!(xlabel = "Resistência")
plot!(ylabel = L"\textrm{Deformacao} \ \quad \frac{\Delta l}{l_0}", fontfamily="Computer Modern")

# gr()
# plotly()
conj = plot!(titanio_p, al203_p, teflon_p, legend=false, grid=true)

plot(titanio_p, al203_p, teflon_p, conj,
     # layout=grid(3,1),
     grid = [true, true, true, true],
     legend=false,
     thickness_scaling = 0.5,
     title=["Titanio", "Aluminio 203", "Teflon", "Conjunto"],
     titleloc="center")

al203_p;titanio_p;teflon_p

plot(titanio_p, al203_p, teflon_p,
     legend=false,
     grid=true)
plot!(al203_p)
plot!(teflon_p)
# reuse=true)

## Aluminio 203 grid 
Plots.plot(al203_T, al203_l, label="Aluminio 203")
al203_l2=LagrangeInterpolation(al203_T,al203_l,2)
al203_l2_fit2 = fit(al203_T, al203_l, 2) # degree = length(xs) - 1
al203_l2_curve = map(al203_l2_fit2, al203_T)
plot!(al203_T, al203_l2_curve, label="Polinômio de segundo grau M.Q.")
plot!(legend=:bottomright, grid=true, xlabel = "Resistência", ylabel = L"\textrm{Deformacao} \ \quad \frac{\Delta l}{l_0}", fontfamily="Computer Modern")

## Titanio 203 grid al203_p;titanio_p;teflon_p
Plots.plot(titanio_T, titanio_l, label="Titânio")
titanio_l2=LagrangeInterpolation(titanio_T,titanio_l,2)
titanio_l2_fit2 = fit(titanio_T, titanio_l, 2) # degree = length(xs) - 1
titanio_l2_curve = map(titanio_l2_fit2, titanio_T)
plot!(titanio_T, titanio_l2_curve, label="Polinômio de segundo grau M.Q.")
plot!(legend=:bottomright, grid=true, xlabel = "Resistência", ylabel = L"\textrm{Deformacao} \ \quad \frac{\Delta l}{l_0}", fontfamily="Computer Modern")

## Teflon 203 grid al203_p;titanio_p;teflon_p 
Plots.plot(teflon_T, teflon_l, label="Teflon 203")
teflon_l2=LagrangeInterpolation(teflon_T,teflon_l,2)
teflon_l2_fit2 = fit(teflon_T, teflon_l, 2) # degree = length(xs) - 1
teflon_l2_curve = map(teflon_l2_fit2, teflon_T)
plot!(teflon_T, teflon_l2_curve, label="Polinômio de segundo grau M.Q.")
plot!(legend=:bottomright, grid=true, xlabel = "Resistência", ylabel = L"\textrm{Deformacao} \ \quad \frac{\Delta l}{l_0}", fontfamily="Computer Modern")


function error_calc(poli_data,exp_data)
    sum_diff = 0
    sum_diff_2 = 0
    for i in length(exp_data)
        sum_diff += abs(poli_data[i] - exp_data[i])
        sum_diff_2 += (poli_data[i]-exp_data[i])^2
    end
    mean_sum_diff = sum_diff/2
    mean_mod_sum_diff = sqrt(sum_diff_2)/length(exp_data)
    return mean_sum_diff, mean_mod_sum_diff
end

## Aluminio
al203_l2_curve
# Polynomial(-0.005020239(9) + 2.8813e-5(9)*x - 1.6e-8(9)*x^2)
error_calc(al203_l2_curve,al203_l)
# (+0.00011287853720118443, 1.980325214055867e-7)

## Titânio
titanio_l2_curve
# Polynomial(-6.152888e-3(8) + 3.8424e-5(8)*x - 1.6e-8(8)*x^2)
error_calc(titanio_l2_curve,titanio_l)
# (+4.771149020405853e-5, 8.240326460113736e-8)

## Teflon
teflon_l2_curve
# Polynomial(-6.24966e-4(9) + 3.580e-6(9)*x + 8e-9(9)*x^2)
error_calc(teflon_l2_curve,teflon_l)
# (+0.000254015769354435, 4.379582230248879e-7)



# al203_p
# f2 = fit(xs, ys, 2) # degree = 2


######### Tratamento diferenciado
##### pt 1000
## Dados
# T (°C)	R (Ohm)
##
#####

pt1000_data=readdlm("./data/pt1000.txt", '\t', '\n')
pt1000_T, pt1000_R = pt1000_data[:,2],pt1000_data[:,1]

plt = Plots
pt1000 = QuadraticSpline(pt1000_T, pt1000_l)
pt1000_p = Plots.plot(pt1000_T, pt1000_R, label="Pt1000")
plt.plot!(xlabel = "Temperatura (℃)")
plot!(ylabel = "Resistência (Ω)", fontfamily="Computer Modern")


## Platina 1000 
Plots.plot(pt1000_T, pt1000_R, label="Pt1000 203")
# pt1000_l2=LagrangeInterpolation(pt1000_T,pt1000_l,2)
pt1000_fit1 = fit(pt1000_T, pt1000_R, 1) # degree = length(xs) - 1
pt1000_curve = map(pt1000_l2_fit1, pt1000_T)
plot!(pt1000_T, pt1000_curve, label="Polinômio de primeiro grau M.Q.")
plot!(legend=:bottomright, grid=true, xlabel = "Resistência (Ω)", ylabel =  "Temperatura (℃)", fontfamily="Computer Modern")

## Platina 1000
pt1000_fit1
# Polynomial(-250.40657590986478 + 0.2515202918125208*x)
error_calc(pt1000_curve,pt1000_R)
# (1.4486439239547906, 0.009110968075187362)
