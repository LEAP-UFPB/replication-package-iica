###############################################################################
# IBRCRM — PAINEL 2x2 (2010, 2015, 2020, 2022) | Brasil + Regiões | CATEGÓRICO
# - 1 arquivo (JPG) por indicador, por escopo (Brasil + 5 regiões)
# - Sem bordas municipais (apenas limites estaduais)
# - Legenda interna e maior (título = ano)
# Saída: ./results/graphs/ibrcrm/{brasil,norte,...}/panel_<indicador>_2010_2015_2020_2022.jpg
###############################################################################

# -------------------------- Pacotes ------------------------------------------
pkgs <- c("dplyr","stringr","geobr","sf","tmap","ragg")
to_install <- setdiff(pkgs, rownames(installed.packages()))
if (length(to_install)) install.packages(to_install, dependencies = TRUE)
invisible(lapply(pkgs, require, character.only = TRUE))

options(timeout = 1000000)
sf::sf_use_s2(FALSE)
tmap_mode("plot")
options(tmap.check.and.fix = TRUE)

# -------------------------- Config -------------------------------------------
YEARS_TARGET <- c(2010, 2015, 2020, 2022)
OUT_ROOT <- "./results/graphs/ibrcrm"
dir.create(OUT_ROOT, recursive = TRUE, showWarnings = FALSE)

cand <- c(
  "./output_agg/ibrcrm_final_boruta.rds",
  "./output_boruta/ibrcrm_final_boruta.rds"
)
INPUT_RDS <- cand[file.exists(cand)][1]
if (is.na(INPUT_RDS)) stop("Não encontrei ./output_agg/ibrcrm_final_boruta.rds nem ./output_boruta/ibrcrm_final_boruta.rds")

# -------------------------- Paletas FIXAS ------------------------------------
PAL5 <- list(
  "IBrCRM"         = c("#deebf7","#9ecae1","#6baed6","#3182bd","#08519c"), # Geral - Azul
  "Infraestrutura" = c("#efebe9","#d7ccc8","#bcaaa4","#8d6e63","#5d4037"), # Marrom
  "Produtivo"      = c("#fffde7","#fff59d","#ffee58","#fbc02d","#f9a825"), # Amarelo
  "Educação"       = c("#fce4ec","#f8bbd0","#f48fb1","#ec407a","#ad1457"), # Rosa
  "Ambiental"      = c("#e8f5e9","#c8e6c9","#81c784","#43a047","#1b5e20"), # Verde
  "Social"         = c("#ffebee","#ffcdd2","#ef9a9a","#e53935","#b71c1c"), # Vermelho
  "Institucional"  = c("#fff3e0","#ffe0b2","#ffb74d","#fb8c00","#e65100"), # Laranja
  "Inovação"       = c("#f3e5f5","#e1bee7","#ba68c8","#8e24aa","#4a148c")  # Roxo
)

indices <- c("IBrCRM","Infraestrutura","Produtivo","Educação","Ambiental","Social","Institucional","Inovação")

pal5 <- function(indicador){
  PAL5[[indicador]]
}

# Legenda
LEG_TITLE_SIZE <- 1.25
LEG_TEXT_SIZE  <- 0.95

# Saída JPG
DPI  <- 450
W_CM <- 35
H_CM <- 25
W_PX <- round(W_CM/2.54 * DPI)
H_PX <- round(H_CM/2.54 * DPI)

save_tmap_jpg <- function(tm_obj, file_out, width_px = W_PX, height_px = H_PX, dpi = DPI, quality = 95) {
  ragg::agg_jpeg(
    filename   = file_out,
    width      = width_px,
    height     = height_px,
    units      = "px",
    res        = dpi,
    quality    = quality,
    background = "white"
  )
  on.exit(grDevices::dev.off(), add = TRUE)
  print(tm_obj)
  invisible(TRUE)
}

# -------------------------- Helpers ------------------------------------------
LEV_STD <- c("Muito baixo","Baixo","Médio","Alto","Muito alto")

slugify <- function(x){
  x2 <- iconv(x, from = "", to = "ASCII//TRANSLIT")
  x2 <- tolower(x2)
  x2 <- stringr::str_replace_all(x2, "[^a-z0-9]+", "_")
  x2 <- stringr::str_replace_all(x2, "^_|_$", "")
  x2
}

norm_level <- function(x){
  x <- as.character(x)
  x <- stringr::str_replace_all(x, "^Medio$", "Médio")
  x
}

as_likert <- function(x){
  x <- norm_level(x)
  factor(x, levels = LEV_STD, ordered = TRUE)
}

# -------------------------- Geometrias (1x) ----------------------------------
ufs <- geobr::read_state(year = 2020, showProgress = FALSE) |>
  dplyr::select(code_state, uf = abbrev_state, regiao = name_region, geom) |>
  dplyr::mutate(regiao = stringr::str_replace_all(regiao, "Centro ?Oeste", "Centro-Oeste")) |>
  sf::st_make_valid()

muni <- geobr::read_municipality(year = 2020, showProgress = FALSE) |>
  dplyr::mutate(
    code_muni  = as.integer(substr(as.character(code_muni), 1, 6)),
    code_state = as.integer(code_state)
  ) |>
  dplyr::left_join(
    ufs |> sf::st_drop_geometry() |> dplyr::select(code_state, uf, regiao),
    by = "code_state"
  ) |>
  dplyr::select(code_muni, code_state, uf, regiao, geom) |>
  sf::st_make_valid()

# Escopos
scopes <- list(
  "Brasil"       = "Brasil",
  "Norte"        = "Norte",
  "Nordeste"     = "Nordeste",
  "Sudeste"      = "Sudeste",
  "Sul"          = "Sul",
  "Centro-Oeste" = "Centro-Oeste"
)

prep_scope <- function(sf_all, ufs_all, scope_name){
  if (scope_name == "Brasil") {
    list(sf = sf_all, ufs = ufs_all)
  } else {
    list(
      sf  = sf_all |> dplyr::filter(regiao == scope_name),
      ufs = ufs_all |> dplyr::filter(regiao == scope_name)
    )
  }
}

# -------------------------- Dados (1x) ---------------------------------------
df_all <- readRDS(INPUT_RDS) |>
  dplyr::mutate(
    code_muni = as.integer(substr(as.character(code_muni), 1, 6)),
    ano       = as.integer(ano)
  )

years_avail <- sort(unique(df_all$ano))
years_use <- intersect(YEARS_TARGET, years_avail)
missing_years <- setdiff(YEARS_TARGET, years_avail)
if (length(missing_years)) message("⚠️ Anos ausentes e serão pulados: ", paste(missing_years, collapse = ", "))

if (length(years_use) < 2) stop("Poucos anos disponíveis para painel. Anos encontrados: ", paste(years_use, collapse = ", "))

# -------------------------- Função: painel por indicador/escopo ---------------
make_panel_maps <- function(scope_sf, scope_ufs, indicador, years_vec){
  
  plist <- lapply(years_vec, function(yy){
    
    dyy <- scope_sf |> dplyr::filter(ano == yy)
    if (!nrow(dyy) || all(is.na(dyy[[indicador]]))) return(NULL)
    
    tm_shape(dyy) +
      tm_polygons(
        col        = indicador,
        style      = "cat",
        palette    = pal5(indicador),
        title      = as.character(yy),
        textNA     = "Sem dados",
        colorNA    = "#4D4D4D",  # <<< cinza forte
        border.col = NA,
        lwd        = 0
      ) +
      tm_shape(scope_ufs) +
      tm_borders(lwd = 0.9, col = "grey20") +
      tm_layout(
        frame              = FALSE,
        bg.color           = "white",
        legend.outside     = FALSE,
        legend.position    = c("left","bottom"),
        legend.bg.color    = NA,
        legend.bg.alpha    = 0,
        legend.frame       = FALSE,
        legend.title.size  = LEG_TITLE_SIZE,
        legend.text.size   = LEG_TEXT_SIZE,
        inner.margins      = c(0.02,0.02,0.02,0.02)
      )
  })
  
  plist <- Filter(Negate(is.null), plist)
  if (!length(plist)) return(NULL)
  
  tmap_arrange(plist, ncol = 2)
}

# -------------------------- Loop: Brasil + Regiões ----------------------------
df_sel <- df_all |>
  dplyr::filter(ano %in% years_use) |>
  dplyr::select(
    code_muni, ano,
    IBrCRM          = ibrcrm_index,
    Ambiental       = ibrcrm_index_ambiental,
    "Inovação"      = ibrcrm_index_inovacao,
    Social          = ibrcrm_index_social,
    Infraestrutura  = ibrcrm_index_infra,
    Produtivo       = ibrcrm_index_produtivo,
    Institucional   = ibrcrm_index_institucional,
    "Educação"      = ibrcrm_index_educacao
  )

for (v in indices) df_sel[[v]] <- as_likert(df_sel[[v]])

sf_all <- muni |> dplyr::left_join(df_sel, by = "code_muni") |> sf::st_as_sf()

for (nm in names(scopes)) {
  
  sc <- prep_scope(sf_all, ufs, scopes[[nm]])
  out_dir <- file.path(OUT_ROOT, slugify(nm))
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  
  for (indicador in indices) {
    
    if (!indicador %in% names(sc$sf)) next
    if (all(is.na(sc$sf[[indicador]]))) next
    
    panel_tm <- make_panel_maps(sc$sf, sc$ufs, indicador, years_use)
    if (is.null(panel_tm)) next
    
    file_out <- file.path(
      out_dir,
      paste0("panel_", slugify(indicador), "_", paste(years_use, collapse = "_"), ".jpg")
    )
    
    save_tmap_jpg(panel_tm, file_out)
  }
}

message("OK: painéis salvos em: ", normalizePath(OUT_ROOT))
