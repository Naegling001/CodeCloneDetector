import wordlist
import sys

def isBallNum(s):
    '''Detects if s is in the format of a ball number, e.g. '0.3' or '19.6\''''
    parts = s.split(".")
    if len(parts) != 2:
        return False
    if not (parts[0].isdigit() and parts[1].isdigit()):
        return False
    if int(parts[1]) <= 6:
        return True
    return False

def manual():
    global exe, shortform, longform, commentary, message, isout, method
    exe = input("Exec? ")
    shortform = input("Short form? ")
    longform = input("Long form? ")
    commentary = input("Commentary? ")
    message = input("Message? ")
    if isout:
        method = input("Method? ")
        getfhcase()

def finaloutput():
    global exe, shortform, longform, commentary, message, isout, method
    global fhisdiff, fhexe, fhshortform, fhlongform, fhcommentary, fhmessage
    rcommentary = replace(commentary)
    if isout:
        if fhisdiff:
            rfhcommentary = replace(fhcommentary)
            return "11\n" + (("%s\n" * 11) % (exe, shortform, longform,
                                              rcommentary, message, method,
                                              fhexe, fhshortform, fhlongform,
                                              rfhcommentary, fhmessage))
        else:
            return "6\n" + (("%s\n" * 6) % (exe, shortform, longform,
                                            rcommentary, message, method))
    else:
        return "5\n" + (("%s\n" * 5) % (exe, shortform, longform, rcommentary,
                                           message))
    pass

def replace(s):
    global toreplace
    ans = ""
    for token in s.split():
        word = token
        while not (word == '' or word[0].isalnum()):
            word = word[1:]
        while not (word == '' or word[-1].isalnum()):
            word = word[:-1]
        if word.endswith("'s"):
            word = word[:-2]
        if token in toreplace:
            if toreplace[token] != "-":
                ans += toreplace[token] + " "
        elif word in toreplace:
            if toreplace[word] != "-":
                ans += token.replace(word, toreplace[word]) + " "
        else:
            ans += token + " "
    return ans[:-1]
        

def getfhcase():
    global fhisdiff, fhexe, fhshortform, fhlongform, fhcommentary, fhmessage
    fhisdiff = input("Is no ball different? ").lower()
    while fhisdiff not in ["yes", "no"]:
        fhisdiff = input("Yes or no: ").lower()
    fhisdiff = True if fhisdiff == "yes" else False
    if fhisdiff:
        fhexe = input("Free hit exec? ")
        fhshortform = input("Free hit short form? ")
        fhlongform = input("Free hit long form? ")
        fhcommentary = input("Free hit commentary? ")
        fhmessage = input("Free hit message? ")
        

fin = open("toparse.txt")
fout = open("allballs.txt", mode="a")
fballtypes = open("balltypes.txt")
ftempwordlist = open("tempwordlist.txt")

try:
    balltypes = eval(fballtypes.read())
    assert type(balltypes) == dict
    fballtypes.close()
    tempwordlist = eval(ftempwordlist.read())
    assert type(tempwordlist) == list
    ftempwordlist.close()
    # dictionary taking longform -> (exec, shortform, message)

    line = None
    while line != "":
        line = fin.readline()
        if isBallNum(line.strip()):
            toreplace = dict()
            ball = fin.readline().strip()
            sys.stderr.write(ball + "\n")
            parts = ball.split(", ")
            (bowler, striker) = parts[0].split(" to ")
            toreplace[bowler] = "[b]"
            toreplace[striker] = "[s]"
            longform = parts[1]
            commentary = ", ".join(parts[2:])
            isout = False
            if longform == "OUT":
                isout = True
                print(fin.readline(), end='') # method
            if longform in balltypes:
                (exe, shortform, message) = balltypes[longform]
            else:
                exe = input("Exec? ")
                if exe == "manual":
                    manual()
                else:
                    shortform = input("Short form? ")
                    message = input("Message? ")
                    if isout:
                        method = input("Method? ")
                        getfhcase()
                    else:
                        balltypes[longform] = (exe, shortform, message)
            for token in commentary.split() + (method.split() if isout else []):
                word = token
                while not (word == '' or word[0].isalnum()):
                    word = word[1:]
                while not (word == '' or word[-1].isalnum()):
                    word = word[:-1]
                if word.endswith("'s"):
                    word = word[:-2]
                if not (wordlist.isWord(word) or word.lower() in tempwordlist
                        or word in toreplace or word == ''
                        or word[0].isdigit()):
                    replacement = input("Replace \"%s\" with? " % word)
                    if replacement.lower() == "add perm":
                        wordlist.addWord(word.lower())
                    elif replacement.lower() == "add":
                        tempwordlist.append(word.lower())
                    elif replacement.lower() != "ignore":
                        toreplace[word] = replacement
            sys.stderr.write(finaloutput())
            command = input("Anything else? ").lower()
            while command not in ["no", "end"]:
                if command == "change":
                    lf = input("Long form? ")
                    e = input("Exec? ")
                    if e == "none":
                        balltypes.pop(lf, None)
                    else:
                        sf = input("Short form? ")
                        m = input("Message? ")
                        balltypes[lf] = (e, sf, m)
                elif command == "manual":
                    manual()
                elif command == "remove word":
                    word = input("Word? ")
                    wordlist.remove(word)
                elif command == "exec":
                    exe = input("Change exec to? ")
                elif command == "shortform":
                    shortform = input("Change short form to? ")
                elif command == "message":
                    message = input("Change message to? ")
                elif command == "commentary":
                    commentary = input("Change commentary to? ")
                elif command == "replace":
                    orig = input("Replace what? ")
                    replacement = input("With what? ")
                    toreplace[orig] = replacement
                elif command == "remove replacement":
                    orig = input("Which replacement? ")
                    toreplace.pop(orig, None)
                elif command == "remove ball type":
                    lf = input("Long form? ")
                    toreplace.pop(lf, None)
                elif command == "print output":
                    sys.stderr.write(finaloutput())
                elif command == "print toreplace":
                    print(toreplace)
                elif command != "no":
                    print("Invalid command")
                command = input("Anything else? ").lower()
            fout.write(finaloutput())
            print()
            if command == "end":
                break
finally:
    fballtypes = open("balltypes.txt", mode="w")
    fballtypes.write(str(balltypes))
    fballtypes.close()
    ftempwordlist = open("tempwordlist.txt", mode="w")
    ftempwordlist.write(str(tempwordlist))
    ftempwordlist.close()
    remaining = fin.read()
    fin.close()
    fin = open("toparse.txt", mode="w")
    fin.write(remaining)
    fout.close()
    
        


# "change" changes balltypes entry. Say "none" to remove entry
# "manual" takes manual entry
# "remove word" removes accidentally added word
# "exec" changes exe
# "shortform" changes shortform
# "message" changes message
# "replace" adds to toreplace
# "remove replacement" removes from toreplace
# "remove ball type" removes a ball type
# "print output" prints final output
# "print toreplace" prints toreplace
# "no" ends
