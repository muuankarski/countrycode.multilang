library(devtools)
document()

countrycode_data = read.csv('data/countrycode_data.csv', stringsAsFactors=FALSE, na.strings='')
colnames(countrycode_data)[1] = 'country.name'
countrycode_data$iso2c[countrycode_data$country.name=='Namibia'] = 'NA'

# ---------------------------
# One way to merge new names
wiki_names = read.csv('data/wiki_names.csv', stringsAsFactors=FALSE, na.strings='')
## Create a new column country.name.russian.fao  for Russian language Fao statistical pocketbook
wiki_names$country.name.russian.fao <- wiki_names$country.name.russian
# (i) Instead of  “Республика Македония” there should be “Бывшая югославская Республика Македония”; 
wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Республика Македония"] <- "Бывшая югославская \nРеспублика Македония"
# (ii) instead of “Киргизия” there should be “Кыргызстан”; 
wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Киргизия"] <- "Кыргызстан"
# (iii) Instead of “Молдавия” there should be “Республика Молдова” 
wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Молдавия"] <- "Республика \nМолдова"
# (iv) Instead of “Белоруссия”there should be “Беларусь”; 
wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Белоруссия"] <- "Беларусь"
# (v) Instead of “Великобритания” there should be “Соединенное Королевство Великобритании и Северной Ирландии” (this is also indicated as short name, “Великобритания” is not an official name) ; 
wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Великобритания"] <- "Соединенное Королевство"
# (vi) Instead of “Республика Кипр” there should be “Кипр”; 
wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Республика Кипр"] <- "Кипр"
# (vii) Instead of “Россия” there should be “Росиийская Федерация”; 
wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Россия"] <- "Росиийская Федерация"
# (viii) Instead of “Туркмения” there should be “Туркменистан”; 
wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Туркмения"] <- "Туркменистан"
# Instead of “Чехия” there should be “Чешская Республика”;
wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Чехия"] <- "Чешская \nРеспублика"

wiki_names$country.name.russian.fao[wiki_names$country.name.russian.fao == "Чехия"] <- "Чешская \nРеспублика"




countrycode_data_new <- merge(countrycode_data,wiki_names,by="country.name",all.x=TRUE)
countrycode_data_new$country.name.english <- NULL
countrycode_data <- countrycode_data_new
# ---------------------------

countrycode_data$regex = iconv(countrycode_data$regex, to='UTF-8')
save(countrycode_data, file='data/countrycode_data.rda')


