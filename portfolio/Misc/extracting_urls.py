page =('<div id="top_bin"><div id="top_content" class="width960">'
'<div class="udacity float-left"><a href="http://udacity.com">')
start_link = page.find('<a href="')
end_link = page.find('">')

url = page[start_link:end_link]
