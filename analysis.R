# [Termite body and head analysis]
# Title: Determining differences in body size variability between pseudergate and true worker species in termites
# Author: [Mary Goldman] 
# Date: [2026-09-04]

# Install and import packages 

{
  library(dplyr)
  library(tidyr)
  library(ggplot2)
}

# load dataset

{
  dm = read.csv("data_fmt/Dataset_R.csv")
}

# Find standard deviation
{
    result <- dm %>%
      group_by(Species) %>%
      summarise(
        sd_f_head = sd(f_head, na.rm = TRUE),
        sd_m_head = sd(m_head, na.rm = TRUE),
        sd_f_body = sd(f_body, na.rm = TRUE),
        sd_m_body = sd(m_body, na.rm = TRUE)
       )
}

# View by SD By species

{
  print(result)
}

#Prepare variation table

{
    result <- dm %>%
       group_by(Species, Development) %>%
       summarise(
          sd_f_head = sd(f_head, na.rm = TRUE),
          sd_m_head = sd(m_head, na.rm = TRUE),
          sd_f_body = sd(f_body, na.rm = TRUE),
          sd_m_body = sd(m_body, na.rm = TRUE),
          .groups = "drop"
         )
}

{
    result_long <- result %>%
      pivot_longer(
        cols = c(sd_f_head, sd_m_head, sd_f_body, sd_m_body),
        names_to = "measure",
        values_to = "variation"
       ) %>%
        separate(measure, into = c("stat", "sex", "trait"), sep = "_") %>%
        select(-stat)
        names(result_long)
}

{
    result_dev <- result_long %>%
      group_by(Development, sex, trait) %>%
      summarise(
        mean_var = mean(variation, na.rm = TRUE),
        se = sd(variation, na.rm = TRUE) / sqrt(n()),
        .groups = "drop"
      )
}

#Plot Developmental Variation between females and males

{
     ggplot(result_dev, aes(x = Development, y = mean_var, fill = sex)) +
        geom_col(position = "dodge") +
        geom_errorbar(
          aes(ymin = mean_var - se, ymax = mean_var + se),
          width = 0.2,
          position = position_dodge(0.9)
        ) +
        facet_wrap(~trait) +
        theme_classic() +
        labs(
          x = "Development",
          y = "Mean variation",
          fill = "Sex"
        )
}

#Prepare variation table

{
    result_overall <- dm %>%
      group_by(Species, Development) %>%
      summarise(
          head_var = mean(c(
            sd(f_head, na.rm = TRUE),
            sd(m_head, na.rm = TRUE)
          ), na.rm = TRUE),
          body_var = mean(c(
            sd(f_body, na.rm = TRUE),
            sd(m_body, na.rm = TRUE)
          ), na.rm = TRUE),
          .groups = "drop"
        )
}

{
      result_overall_long <- result_overall %>%
          pivot_longer(
            cols = c(head_var, body_var),
            names_to = "trait",
            values_to = "variation"
          )
}

# Plot Overall Variation

{
      result_dev <- result_overall_long %>%
        group_by(Development, trait) %>%
        summarise(
            mean_var = mean(variation, na.rm = TRUE),
            se = sd(variation, na.rm = TRUE) / sqrt(n()),
            .groups = "drop"
          )
}

{
        ggplot(result_dev, aes(x = Development, y = mean_var, fill = Development)) +
          geom_col() +
          geom_errorbar(
            aes(ymin = mean_var - se, ymax = mean_var + se),
            width = 0.2
           ) +
           facet_wrap(~trait) +
           theme_classic() +
           labs(
             x = "Development",
             y = "Mean variation",
             title = "Overall variation by developmental type"
            )
  }

{
        ggplot(result_dev, aes(x = Development, y = mean_var, fill = Development)) +
          geom_col(width = 0.7, color = "black") +
          geom_errorbar(
              aes(ymin = mean_var - se, ymax = mean_var + se),
              width = 0.15
            ) +
            facet_wrap(~trait, scales = "free_y") +
            theme_classic(base_size = 14) +
            scale_fill_manual(values = c(
                "Pseudergate" = "#0071B1",  # blue
                "TW" = "#EDC261"        # orange
              ))#+
              theme(
                legend.position = "none",
                axis.text.x = element_text(angle = 30, hjust = 1),
                strip.text = element_blank(),
                strip.background = element_blank())+
              labs(
                x = "Worker Type",
                y = "Mean variation",
            )
  }

# Prepare variation of size graph

{
      dm_long <- dm %>%
        pivot_longer(
          cols = c(f_head, f_body, m_head, m_body),
          names_to = c("sex", ".value"),
          names_sep = "_"
  )
}

# Plot variation of size graph

{
      ggplot(dm_long, aes(x = log(head), y = log(body), color = Development)) +
        geom_point(size = 3, alpha = 0.8) +
        scale_color_manual(values = c(
          "Pseudergate" = "#0071B1",
          "TW" = "#EDC261"
        )) +
        theme_classic(base_size = 14) +
        labs(
          x = "(log) Head",
          y = "(log) Body",
          color = "Development"
        )
}
# Analysis 
{
  result_long_head <- result_long %>%
    filter(trait == "head") 
  
  result_long_body = result_long %>%
    filter(trait == "body") 
  
# testing overall development  effects on head and body variation
  t.test(variation ~ Development, data =  result_long_head)
  t.test(variation ~ Development, data = result_long_body)
  
  result_long$Development = as.factor(result_long$Development)
  nlevels(result_long$Development)
  levels(long_dm_head$Development)
  
  }

