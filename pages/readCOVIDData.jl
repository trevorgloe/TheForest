module readCData
using DataFrames
using CSV

function loadDeathData(filename::String)
        # read the contents of the text file and load it into a dataframe
        whole_file = read(filename, String)
        all_tokens = collect(eachsplit(whole_file, ['\t', '\n']))
        ncountries = Int(floor(length(all_tokens) / 5))
        # each country has 5 tokens, the country name, confirmed cases, deaths, case fatality percent, and deaths/100k population
        df = DataFrame()
        all_country = Vector{String}(undef, ncountries)
        all_cases = Vector{Int}(undef, ncountries)
        all_death = Vector{Int}(undef, ncountries)
        all_case_f = Vector{Float64}(undef, ncountries)
        all_death_per = Vector{Float64}(undef, ncountries)
        for i in 1:ncountries
                all_country[i] = all_tokens[5*(i-1)+1]
                all_cases[i] = parse(Int, replace(all_tokens[5*(i-1)+2], "," => ""))
                all_death[i] = parse(Int, replace(all_tokens[5*(i-1)+3], "," => ""))
                all_case_f[i] = parse(Float64, replace(all_tokens[5*(i-1)+4], "%" => ""))
                all_death_per[i] = parse(Float64, all_tokens[5*(i-1)+5])
        end
        df.country = all_country
        df.cases = all_cases
        df.deaths = all_death
        df.case_freq = all_case_f
        df.death_per100k = all_death_per
        return df
end

function loadGDPDataIntoDataFrame(df::DataFrame)
        # load the GDP data and add it to the dataframe
        GDP_data = DataFrame(CSV.File("pages/covid_data/API_NY.GDP.MKTP.CD_DS2_en_csv_v2_698274.csv"))
        # each row is a country, and each column is a year. Column 69 is 2024, so start at column 29 (1984) and go through each column
        year = 1984
        for col_idx in 29:69
                # display(year)
                col = GDP_data[3:end, col_idx]
                # the first two entries are not actual data so ignore them
                new_gdps = NaN * zeros(1, length(df[:, 1])) # this will store the data for df so it needs to match the size
                for (i, val) in enumerate(col)
                        if ismissing(val)
                                continue
                        end
                        # first get the index in df of the country
                        name = GDP_data[i+2, 1]
                        if name == "United States"
                                name = "US"
                        end
                        df_idx = findfirst(x -> x .== name, df[:, :country])
                        if isnothing(df_idx)
                                continue
                        end
                        # we got an actual index, so lets add that entry into the vector
                        new_gdps[df_idx] = val
                end
                colname = "GDP_" * string(year)
                df[!, colname] = vec(new_gdps)
                year += 1
        end
        # dont return anything because we are editing df in place
end

function getCountryFromCode(all_codes::DataFrame, ccode::String, df::DataFrame)
        # get the index for the country in the dataframe based on the country code
        # first get the country code data
        code_idx = findall(x -> x .== ccode, all_codes[:, "alpha-3"])
        return code_idx
end

function getAllCountryCodes()
        # returns a data frame for all the country codes
        codes = DataFrame(CSV.File("pages/covid_data/country_codes.csv"))
        return codes
end


export loadDeathData, getCountryFromCode, getAllCountryCodes, loadGDPDataIntoDataFrame

end
