## Seção de Dados - Projeto-MDR

A criação de um índice de competitividade regional é uma ferramenta valiosa para orientar a tomada de decisões, a criação de programas e a alocação de recursos que visam impulsionar o desenvolvimento das diferentes regiões do país. A visualização dessa informação facilita a identificação de disparidades no desenvolvimento entre os municípios, ajudando a evitar o aprofundamento de desigualdades e a promover um desenvolvimento mais equitativo, garantindo que as regiões menos desenvolvidas recebam o apoio necessário. Existem vários índices de competitividade regional utilizados mundialmente, como o [Global Competitiveness Index](https://www.weforum.org/reports/global-competitiveness-report-2020/) do Fórum Econômico Mundial e o [World Competitiveness Ranking](https://www.imd.org/centers/wcc/world-competitiveness-center/) do IMD.

O objetivo deste projeto é construir um painel de dados municipais abrangendo um período de 20 anos, de 2000 a 2020, e incorporando indicadores demográficos, sociais, econômicos, de saúde, educação, infraestrutura, criminalidade e ambientais. O Brasil, um país de grande escala territorial, destaca-se pela disponibilidade de dados desagregados com uma vasta escala temporal. Para este projeto, utilizaremos as seguintes bases de dados:

### Fontes de Dados

| Fonte | Descrição |
| :--- | :--- |
| **IBGE** | Principal órgão de estatística do Brasil, fornecendo dados de estimativa populacional, Produto Interno Bruto (PIB), Valor Adicionado Bruto (VAB) e índice de Gini, essenciais para mensurar a atividade econômica e a desigualdade local. |
| **RAIS** | A Relação Anual de Informações Sociais (RAIS) disponibiliza dados sobre o mercado de trabalho formal, como o número de empregos, a massa salarial, a escolaridade dos trabalhadores e os vínculos do setor público municipal. |
| **CAGED** | O Cadastro Geral de Empregados e Desempregados (CAGED) fornece o fluxo de admissões e demissões no mercado de trabalho formal, permitindo uma análise da dinâmica do emprego. |
| **BCB** | O Banco Central do Brasil (BCB) controla a política monetária e supervisiona as instituições financeiras, fornecendo dados sobre operações de crédito e o estoque de crédito rural. |
| **MDIC** | O Ministério do Desenvolvimento, Indústria, Comércio e Serviços (MDIC) disponibiliza dados sobre o comércio exterior (exportações e importações). |
| **MDS** | O Ministério do Desenvolvimento e Assistência Social (MDS), via CadÚnico, disponibiliza dados sobre o Programa Bolsa Família e sobre a população em situação de pobreza e extrema pobreza. |
| **STN** | A Secretaria do Tesouro Nacional (STN) é responsável pela gestão das finanças públicas, fornecendo dados sobre receitas, despesas, gasto com pessoal e transferências do Fundo de Participação dos Municípios (FPM). |
| **BNDES** | O Banco Nacional de Desenvolvimento Econômico e Social (BNDES) fornece dados sobre contratos, clientes e valores contratados e desembolsados em operações de crédito de desenvolvimento nos municípios. |
| **INPI** | O Instituto Nacional da Propriedade Industrial (INPI) disponibiliza dados sobre depósitos e concessões de propriedade industrial (patentes de invenção, modelos de utilidade, certificados de adição e programas de computador). |
| **ANATEL** | A Agência Nacional de Telecomunicações (ANATEL) fornece dados sobre cobertura e qualidade de telefonia móvel, conexões de internet, banda larga e backhaul de fibra óptica. |
| **Receita Federal** | A Secretaria da Receita Federal disponibiliza, via DIRPF, dados agregados sobre rendimentos declarados no Imposto de Renda de Pessoa Física. |
| **INEP** | O Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira (INEP) é a principal fonte de dados sobre a educação no Brasil, com informações sobre infraestrutura escolar, corpo docente, desempenho dos alunos (IDEB) e taxas de rendimento. |
| **DATASUS/CNES** | O Departamento de Informática do SUS (DATASUS) e o Cadastro Nacional de Estabelecimentos de Saúde (CNES) disponibilizam informações sobre nascimentos, óbitos, internações, cobertura da atenção primária, infraestrutura e profissionais de saúde. |
| **ANA** | A Agência Nacional de Águas (ANA) gerencia os recursos hídricos do país, fornecendo dados sobre chuvas, temperatura e evapotranspiração. |
| **DNIT/ANTT** | O Departamento Nacional de Infraestrutura de Transportes (DNIT) e a Agência Nacional de Transportes Terrestres (ANTT) fornecem dados sobre a malha rodoviária e o fluxo de veículos. |
| **MapBiomas** | O MapBiomas fornece dados sobre o uso e cobertura da terra, incluindo vegetação nativa, desmatamento, área urbanizada e fragmentação da vegetação urbana. |
| **SEEG** | O Sistema de Estimativas de Emissões e Remoções de Gases de Efeito Estufa (SEEG) fornece estimativas anuais de emissões de GEE por setor e município. |
| **ANP** | A Agência Nacional do Petróleo, Gás Natural e Biocombustíveis (ANP) disponibiliza dados sobre os preços médios de revenda de combustíveis. |
| **Terraclimate** | O Terraclimate fornece dados climáticos, como o índice de aridez. |
| **SNIS** | O Sistema Nacional de Informações sobre Saneamento (SNIS) fornece dados sobre cobertura de água, esgoto e saneamento básico. |
| **MIDR** | O Ministério da Integração e do Desenvolvimento Regional (MIDR) fornece dados sobre desastres naturais e seus prejuízos. |
| **PAM/PPM (IBGE)** | A Pesquisa Agrícola Municipal (PAM) e a Pesquisa da Pecuária Municipal (PPM) do IBGE fornecem dados sobre área colhida, área destinada e valor da produção agrícola e pecuária. |

### Indicadores Selecionados

Os indicadores estão organizados nos **sete subíndices** que compõem o índice final (script `04_indice_boruta_cfa.R`): ambiental, inovação, desenvolvimento social, infraestrutura, desenvolvimento produtivo, institucional e educação. Cada subíndice é estimado separadamente via seleção de variáveis por Boruta e agregação por Análise Fatorial Confirmatória (CFA), com padronização dentro de grupos territoriais comparáveis (`name_biome_region_area`).

A coluna **Variável** traz o nome da coluna correspondente na base municipal-ano, ligando esta documentação diretamente ao script. A coluna **Sentido** indica a direção esperada: ↑ quando valores maiores representam melhor desempenho e ↓ quando valores menores representam melhor desempenho (variáveis invertidas antes da construção do índice, conforme o vetor `inverse_variables`).

#### 1. Ambiental

| Indicador | Variável | Sentido | Fonte |
| :--- | :--- | :---: | :--- |
| Índice de aridez | `indice_aridez` | ↓ | Terraclimate |
| Precipitação média | `pr_mean` | ↑ | ANA |
| Evapotranspiração de referência | `eto_mean` | ↑ | ANA |
| Temperatura média anual | `temperatura_media_anual` | ↓ | ANA |
| Desmatamento total | `desmatamento_total` | ↓ | MapBiomas |
| Desmatamento de formações florestais | `desmatamento_forest` | ↓ | MapBiomas |
| Desmatamento de formações naturais não florestais | `desmatamento_non_forest_natural_formation` | ↓ | MapBiomas |
| Percentual de área com vegetação nativa | `pct_area_veg_nativa` | ↑ | MapBiomas |
| Cobertura florestal | `floresta` | ↑ | MapBiomas |
| Desastres naturais (por 100 mil hab.) | `n_desastres_total_por100k` | ↓ | MIDR |
| Emissões de GEE per capita | `emissao_total_pc` | ↓ | SEEG |
| Área agrícola colhida | `pam_area_colhida_total` | ↑ | PAM/IBGE |
| Área agrícola destinada à colheita | `pam_area_destinada_total` | ↑ | PAM/IBGE |

#### 2. Inovação

| Indicador | Variável | Sentido | Fonte |
| :--- | :--- | :---: | :--- |
| Cobertura de banda larga móvel | `cobertura_banda_larga_movel` | ↑ | ANATEL |
| Qualidade da telefonia móvel | `qualidade_telefonia_movel` | ↑ | ANATEL |
| Depósitos de patente de invenção (PI) por 100 mil hab. | `deposito_pi_por_100k` | ↑ | INPI |
| Depósitos de modelo de utilidade (MU) por 100 mil hab. | `deposito_mu_por_100k` | ↑ | INPI |
| Depósitos de certificado de adição (CA) por 100 mil hab. | `deposito_ca_por_100k` | ↑ | INPI |
| Depósitos de programa de computador (PRG) por 100 mil hab. | `deposito_prg_por_100k` | ↑ | INPI |
| Depósitos totais por 100 mil hab. | `deposito_total_por_100k` | ↑ | INPI |
| Patentes concedidas por 100 mil hab. | `patentes_registradas_por_100k` | ↑ | INPI |
| Empregos em ciência e tecnologia por milhão de hab. | `empregos_ct_por_milhao` | ↑ | RAIS |
| Micro e pequenas empresas de biotecnologia/saúde por milhão | `mpe_biotec_saude_por_milhao` | ↑ | RAIS |
| Percentual da força de trabalho com ensino superior | `pct_forca_trabalho_universitaria` | ↑ | RAIS |
| Conexões de internet por 100 mil hab. | `conexoes_internet_por_100k` | ↑ | ANATEL |
| Conexões de banda larga ≥ 34 Mbps | `conexoes_banda_larga_34mb` | ↑ | ANATEL |
| Backhaul de fibra óptica | `backhaul_fibra` | ↑ | ANATEL |

#### 3. Desenvolvimento Social

| Indicador | Variável | Sentido | Fonte |
| :--- | :--- | :---: | :--- |
| Expectativa de vida ao nascer | `expectativa_vida_ao_nascer` | ↑ | DATASUS |
| Taxa de mortalidade infantil (por 1.000 nascidos vivos) | `taxa_mortalidade_infantil_por1000_nv` | ↓ | DATASUS |
| Taxa de mortalidade de menores de 5 anos (por 1.000 nv) | `taxa_mortalidade_menor5_por1000_nv` | ↓ | DATASUS |
| Índice de Gini | `indice_gini` | ↓ | IBGE |
| Internações hospitalares por 1.000 hab. (local de internação) | `internacoes_total_por1000` | ↓ | DATASUS |
| Internações hospitalares por 1.000 hab. (município de residência) | `internacoes_residencia_total_por1000` | ↓ | DATASUS |
| Procedimentos ambulatoriais | `procedimentos_ambulatoriais` | ↑ | DATASUS |
| Cobertura da Atenção Primária à Saúde (%) | `cobertura_aps_pct` | ↑ | DATASUS |
| Cobertura média de saúde | `cobertura_media` | ↑ | DATASUS |
| Cobertura vacinal infantil | `cobertura_vacinal_infantil` | ↑ | DATASUS |
| Taxa de homicídios | `taxa_homicidios` | ↓ | DATASUS |
| Óbitos por suicídio (por 100 mil hab.) | `n_obitos_suicidio_por100k` | ↓ | DATASUS |
| Estabelecimentos de saúde per capita | `total_estabelecimentos_saude_pc` | ↑ | CNES/DATASUS |
| Hospitais per capita | `n_hospitais_pc` | ↑ | CNES/DATASUS |
| Leitos hospitalares per capita | `n_leitos_pc` | ↑ | CNES/DATASUS |
| Profissionais de saúde per capita | `profissionais_total_pc` | ↑ | CNES/DATASUS |
| Médicos per capita | `doutores_medicos_total_pc` | ↑ | CNES/DATASUS |
| Percentual da população pobre e extremamente pobre | `pct_pop_pob_e_ext_pob` | ↓ | MDS/CadÚnico |
| Famílias beneficiárias do Bolsa Família | `qtd_familias_beneficiarias_bolsa_familia` | ↑ | MDS |
| Valor repassado pelo Bolsa Família (R$) | `valor_repassado_bolsa_familia_real` | ↑ | MDS |
| Valor médio do benefício PBF por família (R$) | `pbf_vlr_medio_benef_f_real` | ↑ | MDS |
| Razão de dependência jovem | `ydr` | ↑ | IBGE/DATASUS |
| Razão de dependência de idosos | `1oadr` | ↑ | IBGE/DATASUS |
| Razão de dependência total | `tdr` | ↑ | IBGE/DATASUS |
| Cobertura de abastecimento de água | `tx_cob_agua` | ↑ | SNIS |
| Cobertura de esgotamento sanitário | `tx_cob_esgoto` | ↑ | SNIS |
| Acesso a saneamento básico | `acesso_sb` | ↑ | SNIS |

#### 4. Infraestrutura

| Indicador | Variável | Sentido | Fonte |
| :--- | :--- | :---: | :--- |
| Extensão de rodovias pavimentadas (km) | `rodovias_pavimentadas_km` | ↑ | DNIT/ANTT |
| Área urbanizada | `area_urbanizada` | ↓ | MapBiomas |
| Índice de fragmentação da vegetação urbana | `indice_fragmentacao_veg_urbana` | ↑ | MapBiomas |
| Índice de espraiamento urbano (sprawl) | `sprawl_index` | ↓ | MapBiomas |
| Empresas de serviços de saúde, educação e finanças | `empresas_servicos_saude_educ_fin` | ↑ | RAIS |
| Óbitos no trânsito | `n_obitos_transito` | ↓ | DATASUS |
| Internações por acidentes de trânsito | `n_internacoes_transito` | ↓ | DATASUS |
| Fluxo de veículos por ano per capita | `fluxo_carros_ano_pc` | ↑ | DNIT |
| Veículos-quilômetro rodados por dia per capita (VKT) | `vkt_dia_pc` | ↑ | DNIT |
| Extensão total de vias per capita (km) | `ext_total_km_pc` | ↑ | DNIT/ANTT |
| Valor da produção agrícola per capita (PAM) | `pam_valor_producao_total_real_pc` | ↑ | PAM/IBGE |
| Valor da produção pecuária per capita (PPM) | `ppm_valor_producao_total_real_pc` | ↑ | PPM/IBGE |

#### 5. Desenvolvimento Produtivo

| Indicador | Variável | Sentido | Fonte |
| :--- | :--- | :---: | :--- |
| PIB | `pib_real` | ↑ | IBGE |
| VAB agropecuário | `vab_agro_real` | ↑ | IBGE |
| VAB industrial | `vab_industria_real` | ↑ | IBGE |
| VAB de serviços | `vab_servicos_real` | ↑ | IBGE |
| Exportações FOB | `vl_fob_exp_muni_real` | ↑ | MDIC |
| Importações FOB | `vl_fob_imp_muni_real` | ↑ | MDIC |
| Balança comercial | `balanca_comercial_muni_real` | ↑ | MDIC |
| Contratos BNDES | `bndes_contratos` | ↑ | BNDES |
| Clientes BNDES | `bndes_clientes` | ↑ | BNDES |
| Valor contratado BNDES | `bndes_valor_contratado_real` | ↑ | BNDES |
| Valor desembolsado BNDES | `bndes_valor_desembolsado_real` | ↑ | BNDES |
| Despesa de investimento | `despesa_investimento_real` | ↑ | STN |
| Massa salarial formal | `massa_salarial_formal_real` | ↑ | RAIS |
| Remuneração média formal | `remuneracao_media_formal_real` | ↑ | RAIS |
| Empregados formais | `empregados_formais` | ↑ | RAIS |
| Saldo de admissões e desligamentos | `fluxo_liquido_admissoes_desligamentos` | ↑ | CAGED |
| Estoque de crédito rural per capita | `estoque_credito_rural_real_pc` | ↑ | BCB |
| Contratos de crédito rural | `contratos_credito_rural_total` | ↑ | BCB |
| Crédito total per capita | `credito_total_real_pc` | ↑ | BCB |
| Operações de crédito per capita | `operacoes_de_credito_real_pc` | ↑ | BCB |
| Rendimentos declarados no IRPF | `rendimentos_dirpf_total_real` | ↑ | Receita Federal |
| Preço médio de revenda do etanol hidratado | `revenda_p_medio_etanol_hidratado_real` | ↑ | ANP |
| Preço médio de revenda da gasolina comum | `revenda_p_medio_gasolina_comum_real` | ↑ | ANP |

#### 6. Institucional

| Indicador | Variável | Sentido | Fonte |
| :--- | :--- | :---: | :--- |
| Índice de sustentabilidade fiscal | `ind_sustent_fiscal` | ↑ | STN |
| Grau de dependência de transferências | `grau_depend_transfer` | ↓ | STN |
| Participação do FPM na receita | `share_fpm` | ↑ | STN |
| Receita pública municipal per capita | `receita_pc_real` | ↑ | STN |
| Gasto público total per capita | `gasto_publico_total_real_pc` | ↑ | STN |
| Despesa de capital | `despesa_capital_real` | ↑ | STN |
| Gasto com pessoal | `gasto_pessoal_real` | ↑ | STN |
| Percentual do orçamento com pessoal | `pct_orcamento_pessoal` | ↓ | STN |
| Servidores públicos municipais por 1.000 hab. | `servidores_publicos_municipais_nj_por1000` | ↑ | RAIS |
| Proporção de servidores administrativos | `proporcao_servidores_administrativos` | ↑ | RAIS |

#### 7. Educação

| Indicador | Variável | Sentido | Fonte |
| :--- | :--- | :---: | :--- |
| Taxa de analfabetismo | `taxa_analfabetismo` | ↓ | IBGE |
| Distorção idade-série (fundamental) | `tdi_fund` | ↓ | INEP |
| Taxa de abandono (fundamental) | `aband_fund` | ↓ | INEP |
| Taxa de aprovação (fundamental) | `aprov_fund` | ↑ | INEP |
| Taxa de reprovação (fundamental) | `reprov_fund` | ↓ | INEP |
| IDEB | `ideb` | ↑ | INEP |
| Índice de infraestrutura escolar básica | `indice_infraestrutura_basica` | ↑ | INEP |
| Número de escolas | `n_escolas_total` | ↑ | INEP |
| Número de turmas | `qt_tu` | ↑ | INEP |
| Docentes com ensino superior | `docentes_superior` | ↑ | INEP |
| Número de computadores | `qt_computadores_total` | ↑ | INEP |
| Número de docentes | `qt_docentes_total` | ↑ | INEP |
| Número de matrículas | `qt_mat_total_total` | ↑ | INEP |
| Razão aluno-docente | `razao_aluno_docente` | ↓ | INEP |
| Média de alunos por turma | `tamanho_medio_turmas` | ↓ | INEP |
| Taxa de matrícula (população de 0 a 14 anos) | `taxa_matricula_pop_0_14` | ↑ | INEP |

### Notas de compatibilização com o script 04

Para evitar duplicidade, algumas variáveis do script foram consolidadas nesta documentação, mantendo apenas uma operacionalização por conceito:

- **Repetidas entre eixos** — `gasto_publico_total_real_pc` e `despesa_capital_real` apareciam simultaneamente em *produtivo* e *institucional*; ficaram apenas em *institucional*.
- **Nível vs. per capita / mesma medida** — mantida a versão normalizada e descartada a gêmea: `n_desastres_total_por100k` (em vez de `n_desastres_total`), `emissao_total_pc` (em vez de `emissao_total`), `n_obitos_suicidio_por100k` (em vez de `n_obitos_suicidio`), `taxa_mortalidade_infantil_por1000_nv` (em vez de `taxa_mortalidade_infantil`), `operacoes_de_credito_real_pc` (em vez de `operacoes_credito`), `receita_pc_real` (em vez de `receita_publica_municipal_total_real`), `pam_valor_producao_total_real_pc` e `ppm_valor_producao_total_real_pc` (em vez das versões em nível).
- **Duplicatas exatas** — `depositos_por_100k` (redundante com `deposito_total_por_100k`), `leitos_exist_total_pc` (redundante com `n_leitos_pc`), `atu_fund` (redundante com `tamanho_medio_turmas`) e `vab_total_real` (soma dos VABs setoriais) foram removidas; `desembolsos_reais_total_real` foi omitida por sobrepor-se a `bndes_valor_desembolsado_real`.

### Referências

[1] World Economic Forum. (2020). *The Global Competitiveness Report 2020*. Recuperado de https://www.weforum.org/reports/global-competitiveness-report-2020/

[2] IMD World Competitiveness Center. (2023). *IMD World Competitiveness Ranking*. Recuperado de https://www.imd.org/centers/wcc/world-competitiveness-center/
