##########
using Pkg
Pkg.add("Interpolations")
Pkg.add("DataInterpolations")
Pkg.add("BarycentricInterpolation")
Pkg.add("Polynomials")
Pkg.add("Plots")

##
using BarycentricInterpolation
using Interpolations
using Polynomials
using DataInterpolations
using Plots
# using Pkg
# Pkg.add("XLSX")
# import XLSX
# XLSX.openxlsx("incanter-plots/data/CondTerm-dados.xlsx", enable_cache=false) do f
#   sheet = f["Sheet1"]
#   for r in XLSX.eachrow(sheet)
  
#     # r is a `SheetRow`, values are read 
#     # using column references
#     rn = XLSX.row_number(r) # `SheetRow` row number
#     v1 = r[1]    # will read value at column 1
#     v2 = r[2]# will read value at column 2
#     v3 = r["B"]
#     v4 = r[3]
#     println("v1=$v1, v2=$v2, v3=$v3, v4=$v4")
#   end
# end

# xf = XLSX.openxlsx("incanter-plots/data/CondTerm-dados.xlsx", enable_cache=false, mode="rw")
# sh = xf["Sheet1"]
# sh[:]

Pkg.add("CSV")
Pkg.add("DataFrames")
import CSV
using DataFrames;
f = CSV.read("dadosTerm.csv", header=true) |> DataFrame


############# Teflon
f[1,1] # Teflon

## untill 1942,
f[2,1] # 1.5A

# The data is being transformed in Missing or String types, so we need to parse.
# https://discourse.julialang.org/t/how-to-parse-vector-array-of-string/1494/2
# [parse(Float64, x) for x in ["122.3","433.2"]] 

function parse_vec(vec, coll, n)
    [parse(Float64, x) for x in f[4:n, coll]]
end

# Parsing the first two collumns of Time (min) and Temperature (ºC).
Teflon1_5A_T = parse_vec(f,1,1941)
Teflon1_5A_Temp = parse_vec(f,2,1941) 
T1_5A = QuadraticSpline(Teflon1_5A_T, Teflon1_5A_Temp)

T1_5A_p = scatter(Teflon1_5A_T, Teflon1_5A_Temp, label="Teflon 1.5A")
plot!(T1_5A)


## untill 1004
# f[2,3] # 2.0A
Teflon2A_T = parse_vec(f,3,1003)
Teflon2A_Temp = parse_vec(f,4,1003) 
T2A = QuadraticSpline(Teflon2A_T, Teflon2A_Temp)


T2A_p = scatter(Teflon2A_T, Teflon2A_Temp, label="Teflon 2A")
plot!(T2A_p)
plot!(T2A)


## untill 757
#f[2,5] # 2.5A
Teflon2_5A_T = parse_vec(f,5,1003)
Teflon2_5A_Temp = parse_vec(f,6,1003) 
T2_5A = QuadraticSpline(Teflon2_5A_T, Teflon2_5A_Temp)


T2_5A_p = scatter(Teflon2_5A_T, Teflon2_5A_Temp, label="Teflon 2.5A")
plot!(T2_5A_p)
plot!(T2_5A)

######## Argamassa de Rejunte (de Revestimento)
## until row 1681
## until row 849
## until row 1263


############### Fibra de vidro
## untill row 3438
## untill row 2131
## untill row 1483

############## Resina stycast 10% AIN
## untill row 2706
## untill row 2706
## untill row 2038
#i


