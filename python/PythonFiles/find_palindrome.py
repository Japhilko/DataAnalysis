# Find palindrome
# Jan-Philipp Kolb
# Thu Oct 08 06:52:10 2020


word = "madam"
# test case 2
word = "madman" # uncomment this to test

hlenw = len(word)/2

info = hlenw.is_integer()

if info:
  midpoint=hlenw
else:
  halfi = str(hlenw)
  midpoint = int(halfi[:halfi.find(".")])
    

first_half = word[:midpoint+1]
sec_half =word[midpoint:]

is_palindrome = -1
 

if sec_half[::-1]==first_half: 
  is_palindrome = 0

print (is_palindrome)



# easier: https://www.geeksforgeeks.org/python-program-check-string-palindrome-not/
# https://stackoverflow.com/questions/50848764/split-string-into-two-parts-only
# https://stackoverflow.com/questions/21583758/how-to-check-if-a-float-value-is-a-whole-number
# https://www.datacamp.com/community/tutorials/python-if-elif-else?utm_source=adwords_ppc&utm_campaignid=898687156&utm_adgroupid=48947256715&utm_device=c&utm_keyword=&utm_matchtype=b&utm_network=g&utm_adpostion=&utm_creative=332602034349&utm_targetid=aud-392016246653:dsa-429603003980&utm_loc_interest_ms=&utm_loc_physical_ms=1004812&gclid=CjwKCAjwzvX7BRAeEiwAsXExo6WxsArgPBQL4dDRnFKPkHxysZnG-4Fe5xLIAAMp3VqQQivgAtqidRoC8msQAvD_BwE
