
L1 = [('method7', 'method8', 45, ('complexity', 78)), ('method1', 'method2', 58, ('complexity', 78)),
('method10', 'method12', 55, ('complexity', 78))]


L2 = [('method7','method8', 55, ('data', 55)),('method5','method6', 45, ('complexity', 78)),
('method1','method2', 55,('complexity',78))]


def mergeLists(L1,L2):
    lenL1 = len(L1)
    lenL2 = len(L2)

    finalList = []
    merged = {}
    for i in range(lenL1):
        for j in range(lenL2):
            if(L1[i][:2] == L2[j][:2]):
                #Merge only if two tuples have diff values other than first two values
                finalList.append((tuple(set(L2[j]).union(set(L1[i])))))
                merged[L1[i][:2]] = 1

    for i in range(lenL1):
        if L1[i][:2] not in [tuple(j) for j in merged.keys()]:
            finalList.append(L1[i])

    for i in range(lenL2):
        if L2[i][:2] not in [tuple(j) for j in merged.keys()]:
            finalList.append(L2[i])

    return finalList

finalList = mergeLists(L1,L2)
with open('path.csv', 'w') as myFile:
    wr = csv.writer(myFile, dialect='excel')
    wr.writerow(finalList)
