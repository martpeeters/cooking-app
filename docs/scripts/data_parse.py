import json

lang = "fr"

inf = open("data/raw/recipes_" + lang + ".json")
ind = json.load(inf)

ingredients = {}
nutrition = {}
family = {}
utensils = {}
tags = {}
cuisines = {}

for d in ind:
    for ing in d["ingredients"]:
        if ing["family"] is not None:
            family[ing["family"]["id"]] = {"name" : ing["family"]["name"],
                                           "imageLink" : ing["family"]["iconLink"]}
        ingredients[ing["id"]] = {"country" : ing["country"],
                                    "name" : ing["name"],
                                    "family" : {"id" :
                                                    "none" if ing["family"] is None else ing["family"]["id"]},
                                    "imageLink" : ing["imageLink"]}
    for nut in d["nutrition"]:
        nutrition[nut["type"]] = {"name" : nut["name"]}

    for ute in d["utensils"]:
        utensils[ute["id"]] = {"name" : ute["name"]}

    for tag in d["tags"]:
        tags[tag["id"]] = {"name" : tag["name"],
                             "imageLink" : tag["iconLink"]}

    for cui in d["cuisines"]:
        cuisines[cui["id"]] = {"name" : cui["name"],
                             "imageLink" : cui["iconLink"]}
famDic = {}
fam = []
cnt = 0
for key, value in family.items():
    value["id"] = cnt
    famDic[key] = cnt
    fam.append(value)
    cnt += 1

ingDic = {}
ing = []
cnt = 0
for key, value in ingredients.items():
    value["id"] = cnt
    if value["family"]["id"] != "none":
        value["family"]["id"] = famDic[value["family"]["id"]]
    ingDic[key] = cnt
    ing.append(value)
    cnt += 1

nutDic = {}
nut = []
cnt = 0
for key, value in nutrition.items():
    value["id"] = cnt
    nutDic[key] = cnt
    nut.append(value)
    cnt += 1

uteDic = {}
ute = []
cnt = 0
for key, value in utensils.items():
    value["id"] = cnt
    uteDic[key] = cnt
    ute.append(value)
    cnt += 1

tagDic = {}
tag = []
cnt = 0
for key, value in tags.items():
    value["id"] = cnt
    tagDic[key] = cnt
    tag.append(value)
    cnt += 1

cuiDic = {}
cui = []
cnt = 0
for key, value in cuisines.items():
    value["id"] = cnt
    cuiDic[key] = cnt
    cui.append(value)
    cnt += 1

inf2 = open("data/raw/categories.json")
ind2 = json.load(inf2)
ind2 = ind2[0]

categories = ind2[lang]
cate = []
cnt = 0
for c in categories:
    cate.append({"name" : c,
                      "id" : cnt})
    cnt += 1

dictionary = {"ingredients" : ing,
        "nutrition" : nut,
        "family" : fam,
        "utensils" : ute,
        "tags" : tag,
        "cuisines" : cui,
        "categories" : cate}

outf = open("data/" + lang + "/dictionary.json", "w")
json.dump(dictionary, outf)

recipes = []

cnt = 0
for d in ind:
    nutRecipes = []
    for n in d["nutrition"]:
        nutRecipes.append({"id" : nutDic[n["type"]],
                         "amount" : n["amount"],
                         "unit" : n["unit"]})

    ingRecipes = []
    for n in d["ingredients"]:
        ingRecipes.append({"id" : ingDic[n["id"]]})

    uteRecipes = []
    for n in d["utensils"]:
        uteRecipes.append({"id" : uteDic[n["id"]]})

    tagRecipes = []
    for n in d["tags"]:
        ingRecipes.append({"id" : tagDic[n["id"]]})

    cuiRecipes = []
    for n in d["cuisines"]:
        ingRecipes.append({"id" : cuiDic[n["id"]]})

    for n in d["yields"]:
        for ingr in n["ingredients"]:
            ingr["id"] = ingDic[ingr["id"]]

    steps = []
    for s in d["steps"]:
        sImages = []
        for sI in s["images"]:
            sImages.append({"imageLink" : sI["link"],
                            "caption" : sI["caption"]})


        sIngredients = []
        for sIngr in s["ingredients"]:
            sIngredients.append({"id" : ingDic[sIngr]})

        sUtensils = []
        for sU in s["utensils"]:
            sUtensils.append({"id" : uteDic[sU]})

        steps.append({"index" : s["index"],
                      "instructions" : s["instructions"],
                      "timers" : s["timers"],
                      "images" : sImages,
                      "ingredients" : sIngredients,
                      "utensils" : sUtensils
                      })

    recipes.append({"country" : d["country"],
                    "name" : d["name"],
                    "headline" : d["headline"],
                    "description" : d["description"],
                    "difficulty" : d["difficulty"],
                    "servingSize" : d["servingSize"],
                    "prepTime" : d["prepTime"],
                    "imageLink" : d["imageLink"],
                    "nutrition" : nutRecipes,
                    "ingredients" : ingRecipes,
                    "utensils" : uteRecipes,
                    "tags" : tagRecipes,
                    "cuisines" : cuiRecipes,
                    "yields" : d["yields"],
                    "steps" : steps
                    })
    cnt += 1

outf = open("data/" + lang + "/recipes.json", "w")
json.dump(recipes, outf)