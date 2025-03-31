
## import team sheet

df_team <- arrow::read_parquet(
  "https://rinpharma.github.io/data-pipelines/output/processed_team.parquet"
)

## build team qmd
df_team <- df_team |>
  dplyr::mutate(id = gsub("\\s+", "-", tolower(name))) |>
  dplyr::mutate(lastname = gsub(".*\\s", "", name)) |>
  dplyr::mutate(avatar = dplyr::if_else(file.exists(paste0("images/people/", id, ".jpg")),
    paste0("images/people/", id, ".jpg"),
    "images/people/generic.jpg"
  )) |>
  dplyr::arrange(lastname)

qmd_people <- glue::glue_data(df_team,
  '    
      - name: {name}
        id: {id}
        avatar: {avatar}
        affiliation: {role}
        linkedin: {linkedin}
        github: {github}
  ', .na = ""
) |> glue::glue_collapse(sep = "\n")

## build complete qmd
qmd <- glue::glue(
  '
  ---
  title: Team
  listing: 
    template: ejs/people.ejs
    contents:
  {qmd_people}
  ---
  '
)

## write output
cat(qmd, file = "people.md", sep = "\n")
