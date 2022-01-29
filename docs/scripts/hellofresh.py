import requests
import json


headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:63.0) Gecko/20100101 Firefox/63.0',
    'Accept': 'application/json, text/plain, */*',
    'Accept-Language': 'en-US,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate, br',
    'Referer': 'https://www.hellofresh.com/recipes/quick-meals-collection',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NDM4MzI2NjMsImp0aSI6IjRlMjk0OGE2LTQxZjMtNDcxMi05NGQ1LTQ3MzQ2MGVhOGFkNiIsImlhdCI6MTU0MTIwMjkyMCwiaXNzIjoic2VuZiJ9.j9APBmXxpsTjREPxw4qL8uR-S31AbGYruIji5961QyQ',
    'Origin': 'https://www.hellofresh.com',
    'Connection': 'keep-alive',
    'DNT': '1',
    'TE': 'Trailers',
    'Pragma': 'no-cache',
    'Cache-Control': 'no-cache'
}

flag = False
data_final = {}

maxAmount = 10
total = 20
iRange = int(total / maxAmount)
en_lang = "&locale=en-US&country=us"
fr_lang = "&locale=fr-FR&country=fr"

for i in range(1, iRange + 1):
    bl_url = "https://gw.hellofresh.com/api/recipes/search?offset=" + str((i-1) * maxAmount) + "&limit=" + str(maxAmount) + "&max-prep-time=1000" + en_lang
    response = requests.get(bl_url, headers=headers)
    data = response.json()
    print("IM AT " + str(i) + " RESPONSE " + str(response))
    if i == 1:
        data_final = data["items"]
    else:
        for j in range(0, len(data["items"])):
            flag = False
            for df in data_final:
                if df["name"] == data["items"][j]["name"]:
                    flag = True
                    break
            if flag == False:
                data_final.append(data["items"][j])

print(len(data_final))

out = open('recipes.json', 'w')
json.dump(data_final, out)



