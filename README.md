## Seção de Dados - Projeto-MDR

A criação de um índice de competitividade regional é uma ferramenta valiosa para orientar a tomada de decisões, a criação de programas e a alocação de recursos que visam impulsionar o desenvolvimento das diferentes regiões do país. A visualização dessa informação facilita a identificação de disparidades no desenvolvimento entre os municípios, ajudando a evitar o aprofundamento de desigualdades e a promover um desenvolvimento mais equitativo, garantindo que as regiões menos desenvolvidas recebam o apoio necessário. Existem vários índices de competitividade regional utilizados mundialmente, como o [Global Competitiveness Index](https://www.weforum.org/reports/global-competitiveness-report-2020/) do Fórum Econômico Mundial e o [World Competitiveness Ranking](https://www.imd.org/centers/wcc/world-competitiveness-center/) do IMD.

O objetivo deste projeto é construir um painel de dados municipais abrangendo um período de 20 anos, de 2000 a 2020, e incorporando indicadores demográficos, sociais, econômicos, de saúde, educação, infraestrutura, criminalidade e ambientais. O Brasil, um país de grande escala territorial, destaca-se pela disponibilidade de dados desagregados com uma vasta escala temporal. Para este projeto, utilizaremos as seguintes bases de dados:

### Fontes de Dados

| Fonte | Descrição |
| :--- | :--- |
| **IBGE** | Principal órgão de estatística do Brasil, fornecendo dados de estimativa populacional, Produto Interno Bruto (PIB) e Valor Adicionado Bruto (VAB), essenciais para mensurar a atividade econômica local e entender as áreas que impulsionam o crescimento econômico. |
| **RAIS** | A Relação Anual de Informações Sociais (RAIS) disponibiliza dados sobre o mercado de trabalho formal, como o número de empregos, a massa salarial e a escolaridade média dos trabalhadores. |
| **CAGED** | O Cadastro Geral de Empregados e Desempregados (CAGED) fornece o fluxo de admissões e demissões no mercado de trabalho formal, permitindo uma análise da dinâmica do emprego. |
| **BCB** | O Banco Central do Brasil (BCB) controla a política monetária e supervisiona as instituições financeiras, fornecendo dados sobre operações de crédito e o estoque de capital rural. |
| **MDIC** | O Ministério do Desenvolvimento, Indústria, Comércio e Serviços (MDIC) disponibiliza dados sobre o comércio exterior (exportações e importações) e sobre programas sociais como o Bolsa Família e o Cadastro Único. |
| **STN** | A Secretaria do Tesouro Nacional (STN) é responsável pela gestão das finanças públicas, fornecendo dados sobre as contas públicas, como receitas, despesas e transferências do Fundo de Participação dos Municípios (FPM). |
| **TSE** | O Tribunal Superior Eleitoral (TSE) organiza e supervisiona as eleições, fornecendo dados sobre o eleitorado em nível municipal. |
| **INEP** | O Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira (INEP) é a principal fonte de dados sobre a educação no Brasil, com informações sobre infraestrutura escolar, corpo docente, desempenho dos alunos (IDEB) e taxas de rendimento. |
| **DATASUS** | O Departamento de Informática do Sistema Único de Saúde (DATASUS) coleta e disponibiliza informações sobre a saúde pública, incluindo registros de nascimentos, óbitos, infraestrutura de saúde e dados epidemiológicos. |
| **ANA** | A Agência Nacional de Águas (ANA) gerencia os recursos hídricos do país, fornecendo dados sobre chuvas, temperatura, umidade e evapotranspiração, essenciais para a análise de recursos hídricos e condições climáticas. |
| **DNIT/ANTT** | O Departamento Nacional de Infraestrutura de Transportes (DNIT) e a Agência Nacional de Transportes Terrestres (ANTT) fornecem dados sobre a infraestrutura de transportes, como a extensão da malha rodoviária. |
| **MAPBIOMAS** | O MapBiomas fornece dados sobre o uso e cobertura da terra, incluindo áreas de água, florestas e mineração. |
| **SEEG** | O Sistema de Estimativas de Emissões e Remoções de Gases de Efeito Estufa (SEEG) fornece estimativas anuais de emissões de GEE por setor e município. |
| **ANP** | A Agência Nacional do Petróleo, Gás Natural e Biocombustíveis (ANP) disponibiliza dados sobre os preços médios de combustíveis. |
| **Terraclimate** | O Terraclimate fornece dados climáticos, como o índice de aridez e a radiação solar. |
| **PRF** | A Polícia Rodoviária Federal (PRF) fornece dados sobre acidentes e infrações em rodovias federais. |
| **SNIS** | O Sistema Nacional de Informações sobre Saneamento (SNIS) fornece dados sobre o acesso da população à água e ao saneamento. |
| **MIDR** | O Ministério da Integração e do Desenvolvimento Regional (MIDR) fornece dados sobre desastres naturais e seus prejuízos. |
| **PAM/IBGE** | A Pesquisa Agrícola Municipal (PAM) do IBGE fornece dados sobre a área colhida e a produção agrícola. |


### Indicadores Selecionados

O quadro seguinte sintetiza os principais indicadores que o projeto irá utilizar para a criação do indicador de competitividade regional, divididos por área de análise.

| Indicador | Descrição | Fonte |
| :--- | :--- | :--- |
| **Indicadores Econômicos** | | |
| PIB | Valor total de bens e serviços produzidos em um município | IBGE |
| Massa Salarial | Produto entre a remuneração média dos empregados e o número de empregos | RAIS |
| Número de empresas com CNPJ | Total de empresas registradas com um CNPJ | RAIS |
| Número de empregados formais | Total de trabalhadores empregados (carteira assinada) | RAIS |
| Fluxo de admitidos e demitidos | Saldo de trabalhadores que foram admitidos formalmente e desligados | CAGED |
| Balança Comercial | Saldo das exportações menos importações do município | MDIC |
| Estoque de crédito rural | Estoque de crédito rural para os municípios | BCB |
| Operações de crédito | Operações de crédito realizadas pelos municípios | BCB |
| **Indicadores Institucionais** | | |
| Gasto público municipal | Montante de recursos financeiros gastos pela administração pública municipal | STN |
| Receita pública municipal | Receita total arrecadada pela administração pública municipal | STN |
| Cota-parte FPM | Valor repassado de transferências destinadas ao Fundo de Participação dos Municípios (FPM) | STN |
| Despesa Investimento | Despesa dos municípios destinados à investimentos | STN |
| Capital | Despesas de capital - municipal | STN |
| Gasto com Pessoal | Despesas destinadas ao pagamento de salários, encargos e benefícios de funcionários | STN |
| Percentual gasto com pessoal | Porcentagem do orçamento destinada as despesas totais do município com pagamento de pessoal | STN |
| Grau de dependência municipal | Proporção das receitas do município provenientes de transferências governamentais em relação à receita total | STN |
| **Indicadores Sociais** | | |
| Número de pessoas beneficiárias pelo PBF | Quantidade de pessoas que recebem benefícios do Programa Bolsa Família | MDIC |
| Valor transferido para as pessoas pelo PBF | Montante transferido às famílias beneficiárias do Programa Bolsa Família | MDIC |
| Expectativa de vida | Número médio de anos de vida esperados para um recém-nascido | DATASUS |
| Razão dependência | Relação entre a população dependente e a população em idade ativa | DATASUS |
| Número de leitos per capita | Quantidade de leitos hospitalares disponíveis por habitante | DATASUS |
| Número de hospitais | Quantidade total de hospitais no município | DATASUS |
| Taxa de mortalidade infantil | Quantidade de óbitos de crianças menores de um ano a cada mil nascidos vivos | DATASUS |
| Mortes por causas evitáveis | Número total de óbitos por causas evitáveis no município | DATASUS |
| Número de escolas | Total de instituições de ensino fundamental e médio no município | INEP |
| Número de professores por aluno | Proporção de professores em relação ao número de alunos | INEP |
| Média de alunos por turma | Quantidade média de alunos em cada sala de aula | INEP |
| Indicadores de rendimento | Desempenho acadêmico dos alunos (aprovação, reprovação e abandono) | INEP |
| Taxa de homicídios | Quantidade de homicídios por 100 mil habitantes | DATASUS |
| Abandono Escolar | Taxa de abandono escolar | INEP |
| Doenças - contato com a água | Taxa de doença causadas por contado com água | DATASUS |
| População total - água | População com acesso a água | SNIS |
| **Indicadores Ambientais** | | |
| Quantidade de chuva acumulada | Quantidade de chuvas acumulada dentro de um ano (em milímetros) | ANA |
| Nível médio de evotranspiração | Quantidade média de água que evapora da superfície do solo e é liberada pelas plantas | ANA |
| Nível médio de temperatura | Média de temperatura registrada ao longo do tempo | ANA |
| Extensão de rodovias federais/estaduais | Extensão total de rodovias federais e estaduais presentes no município | DNIT/ANTT |
| Índice de aridez | Indica a aridez ou a secura do clima em uma determinada região | Terraclimate |
| Proporção de área coberta por florestamento | Porcentagem da área do município coberta por florestas | Mapbiomas |
| Área de cobertura de minério | Extensão da área dentro do município que é dedicada à extração de minérios | MAPBIOMAS |
| Total de desastres | Número total de desastres naturais ou eventos catastróficos registrados no município | MIDR |
| Prejuízos - desastres | Total de danos materiais ou econômicos causados pelos desastres naturais | MIDR |
| Área colhida | Área de terras agrícolas dentro do município que é usada para cultivos e que foi colhida | PAM/IBGE |
| Emissão de CO2 | Quantidade emitida de CO2 por município | SEEG |
| Preço médio de combustíveis | Média mensal dos preços da gasolina, etanol e diesel nos municípios | ANP |
| Acidentes em rodovias federais | Total anual de acidentes registrados em rodovias sob jurisdição federal | PRF |
| Infrações em rodovias federais | Total anual de autuações por infrações de trânsito em rodovias federais | PRF |



### Referências

[1] World Economic Forum. (2020). *The Global Competitiveness Report 2020*. Recuperado de https://www.weforum.org/reports/global-competitiveness-report-2020/

[2] IMD World Competitiveness Center. (2023). *IMD World Competitiveness Ranking*. Recuperado de https://www.imd.org/centers/wcc/world-competitiveness-center/

