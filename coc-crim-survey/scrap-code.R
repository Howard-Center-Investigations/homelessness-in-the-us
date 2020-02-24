## Scrapped code

## Analyze each state {.tabset}

### Alaska

* Alaska has one law against sleeping in public that is county-wide, the only county law in this criminal survey analysis
+ However, sitting, laying or camping in public is not allowed citywide
* There is no food sharing ban but there is a citywide law against begging
```{r}
alaska <- crim_survey %>%
  subset(state %in% "ak")

kable(alaska) %>%
  column_spec(3:ncol(alaska), border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "200px")
```

### California

```{r}
california <- crim_survey %>%
  subset(state %in% "ca")

kable(california) %>%
  column_spec (3:ncol(california),border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "500px")
```

### DC

```{r}
dc <- crim_survey %>%
  subset(state %in% "dc")

kable(dc) %>%
  column_spec (3:ncol(dc),border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "250px")
```

### Florida

```{r}
florida <- crim_survey %>%
  subset(state %in% "fl")

kable(florida) %>%
  column_spec (3:ncol(florida),border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "500px")
```

### Hawaii

```{r}

hawaii <- crim_survey %>%
  subset(state %in% "hi")

kable(hawaii) %>%
  column_spec (3:ncol(hawaii),border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "250px")
```

### Kentucky

```{r}
kentucky <- crim_survey %>%
  subset(state %in% "ky")

kable(kentucky) %>%
  column_spec (3:ncol(kentucky),border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "250px")
```

### Louisiana

* Currently not complete

```{r}

#louisiana <- crim_survey %>%
# subset(state %in% "la")

#kable(louisiana) %>%
# column_spec (3:ncol(louisiana),border_left = T, border_right = F) %>%
#kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
#scroll_box(height = "250px")
```

### Maryland

```{r}

maryland <- crim_survey %>%
  subset(state %in% "md")

kable(maryland) %>%
  column_spec (3:ncol(maryland),border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "250px")
```

### Massachusetts 

* Currently not complete

```{r}

#massachusetts <- crim_survey %>%
#  subset(state %in% "ma")

#kable(massachusetts) %>%
#  column_spec (3:ncol(massachusetts),border_left = T, border_right = F) %>%
#  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
#  scroll_box(height = "300px")
```

### New York

```{r}

new_york <- crim_survey %>%
  subset(state %in% "ny")

kable(new_york) %>%
  column_spec (3:ncol(new_york),border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "175px")
```

### North Carolina

```{r}

north_carolina <- crim_survey %>%
  subset(state %in% "nc")

kable(north_carolina) %>%
  column_spec (3:ncol(north_carolina),border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "250px")
```

### Oregon

```{r}

oregon <- crim_survey %>%
  subset(state %in% "or")

kable(oregon) %>%
  column_spec (3:ncol(oregon),border_left = T, border_right = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(height = "250px")
```