import sys

whole = ""
with open(sys.argv[1]) as fp: #height_CAD.txt
    for line in fp:
        whole += line.rstrip()

whole = whole.split("Method = c")

whole = whole[1].split("Estimate = c")

method = whole[0]

whole = whole[1].split("`Std Error` = c")
estimate = whole[0]

whole = whole[1].split("`95% CI ` = c")
stderr = whole[0]

whole = whole[1].split("` ` = c")
ci_bot = whole[0]

whole = whole[1].split("`P-value` = c")
ci_top = whole[0]

whole = whole[1].split("row.names = c")
p = whole[0]


def split_strip(string):
    string = string.replace("(", "").replace(")", "").replace('"', '').split(",")
    for i in range(0, len(string)):
            string[i] = string[i].strip().replace(" ", "_")
    del string[-1]
    return string

def printout(lstring):
    toprint = ""
    for val in lstring:
        toprint += val + "\t"
    return toprint.rstrip()

#method
method = split_strip(method)
toprint = ""
for i in range(0, len(method)):
    if( i == 8 ):
            toprint += "MR-Egger_intercept\t"
    elif i == 10:
            toprint += "Penalized_MR-Egger_intercept\t"
    elif i == 12:
            toprint += "Robust_MR-Egger_intercept\t"
    elif i == 14:
            toprint += "Penalized_robust_MR-Egger_intercept\t"
    else:
        toprint += method[i] + "\t"
print("Method\t" + toprint.rstrip())

print("Estimate\t" + printout(split_strip(estimate)))
print("Stderr\t" + printout(split_strip(stderr)))
print("95CI_bottom\t" + printout(split_strip(ci_bot)))
print("95CI_top\t" + printout(split_strip(ci_top)))
print("P-value\t" + printout(split_strip(p)))

#p = split_strip(p)
#toprint = ""
#for val in p:
#    toprint += "{:.2e}".format(float(val)) + "\t"
#print("P-value\t" + toprint.rstrip())
