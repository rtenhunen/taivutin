# Taivutin
Taivutin conjugates Finnish nouns by initialising an object with the noun. The object finds the stem during init and you can call the case you want for the noun (or adjective).

# Why?
The stem of the finnish words may change between cases and thus currently most localizations suffer from rigid structures when they try to keep the nominative form. The goal is to avoid "Käyttäjä Matti jakoi kuvan käyttäjälle Maija" ("User Matti shared a photo to user Maija") and go for the natural "Matti jakoi kuvan Maijalle" ("Matti shared a photo to Maija").
When the nouns become objects they can have methods which return the appropriate cases.