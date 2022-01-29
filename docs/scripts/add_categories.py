import json

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        pass
 
    try:
        import unicodedata
        unicodedata.numeric(s)
        return True
    except (TypeError, ValueError):
        pass
 
    return False

lang = "fr"

inf = open("data/raw/categories.json")
ind = json.load(inf)
ind = ind[0]
categories = ind[lang]

inf = open("data/"+ lang + "/dictionary.json")
ind = json.load(inf)

counter = 0
for f in ind["family"]:
    print("----------------------- LVL " + str(counter) + " -----------------")
    print("------------------ ITEM :: " + f["name"].upper() + " ------------------")
    cnt = 0
    for c in categories:
        print(str(cnt) + " : " + c)
        cnt += 1

    val = 0
    ok = True
    while ok:
        value = input("Select index from 0 to " + str(len(categories)) + " : ")
        if is_number(value) and (int(value) < len(categories)) :
            val = int(value)
            ok = False
    
    f["category"] = {"id" : int(val)}
    counter += 1

outf = open("data/" + lang + "/dictionary_c.json", "w")
json.dump(ind, outf)

print("LEVEL COMPLETE")