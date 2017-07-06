import csv
from operator import itemgetter
L1 = [('method7', 'method8', 45, ('complexity', 78)), ('method1', 'method2', 58, ('complexity', 78)),
('method10', 'method12', 55, ('complexity', 78))]


L2 = [('method7','method8', 55, ('data', 55)),('method5','method6', 45, ('complexity', 78)),
('method1','method2', 55,('complexity',78))]


headerString = ['Method1','Method2','Final Score','score 1','score 2','Metrixpp:numbers','Metrix++:cyclomatic','Metrixpp:maxindent','Metrixpp:code','Metrixpp:comments','Metrixpp:total','jarchitect:CyclomaticComplexity', 'jarchitect:NbMethodsCalled','jarchitect:NbParameters','jarchitect:NbVariables']


def mergeLists(L1,L2):
    lenL1 = len(L1)
    lenL2 = len(L2)

    finalList = []
    merged = {}
    matchlist = []
    for i in range(lenL1):
        for j in range(i+1,lenL2-1):
            if((L1[i][0] == L2[j][0] and L1[i][1] == L2[j][1]) or (L1[i][1] == L2[j][0] and L1[i][0] == L2[j][1])):
                #Merge only if two tuples have diff values other than first two values
                combinedList = [L1[i][0],L1[i][1],((L1[i][2] + L2[i][2])/2),L1[i][2],L2[i][2]]
                l1mets = []
                for met in L1[i][3:]:
                    l1mets.append(met[1])
                l2mets = []
                for met in L2[j][3:]:
                    l2mets.append(met[1])
                    
                combinedList += (l1mets)
                combinedList += (l2mets)
                
                #(tuple(set(L2[j]).union(set(L1[i]))))
                matchlist.append(combinedList)  
                
                
                merged[L1[i][0]+L1[i][1]] = 1
                merged[L1[i][1]+L1[i][0]] = 1
    print('Number of matched pairs')
    print(len(matchlist))
    for i in range(lenL1):
        if (L1[i][0]+L1[i][1]) not in merged.keys() and (L1[i][1]+L1[i][0]) not in merged.keys():
            l1mets = []
            for met in L1[i][3:]:
                l1mets.append(met[1])
            finalList.append(L1[i][:3]+[L1[i][2]]+['']+l1mets+['','','',''])

    for i in range(lenL2):
        
        if (L2[i][0]+L2[i][1]) not in merged.keys() and (L2[i][1]+L2[i][0]) not in merged.keys():
            l2mets = []
            for met in L2[j][3:]:
                l2mets.append(met[1])
            finalList.append(L2[i][:2]+[L2[i][2]]+['']+[L2[i][2]]+['','','','','','']+l2mets)
    l1 = sorted(matchlist,key=itemgetter(2))
    l2 = sorted(finalList,key=itemgetter(2))
    return l1+l2
	
def CombineAndExportData(L1, L2):
    finalList = mergeLists(L1,L2)
    truefinal = list()
    for i in finalList:
        truefinal.append(i)
    
    clear_file = "Results.csv"
    f = open(clear_file, "w")
    f.close()
    with open('Results.csv', 'w') as myFile:
        wr = csv.writer(myFile)
        wr.writerow(headerString)
        for value in truefinal:
            wr.writerow(value)
		
'''finalList = mergeLists(L1,L2)
with open('path.csv', 'w') as myFile:
    wr = csv.writer(myFile, dialect='excel')
    wr.writerow(finalList)'''
