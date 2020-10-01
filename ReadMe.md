# RepoStars

Esta demonstração lista os repositórios na linguagem de programação "Swift" ordenados pela quantidade de estrelas.

<img src="https://amarildolucas.s3-sa-east-1.amazonaws.com/Simulator+Screen+Shot+-+iPhone+11+Pro+-+2020-10-01+at+14.22.30.png" width="450" alt="Captura de tela 1"/>

## Ferramentas usadas

- Quick/Nimble para testes unitários.
- KIF para testes funcionais.

![Captura de tela 2](https://amarildolucas.s3-sa-east-1.amazonaws.com/Captura+de+Tela+2020-09-30+a%CC%80s+13.22.02.png)

- Nimble-Snapshots para Snapshot Tests.

<img src="https://amarildolucas.s3-sa-east-1.amazonaws.com/The__RepositoriesViewController___Record_Snapshots__Should_have_correct_repositories_UITableView_with_data%403x.png" width="450" alt="Captura de tela 3"/>

- Fastlane.

![Captura de tela 4](https://amarildolucas.s3-sa-east-1.amazonaws.com/Captura+de+Tela+2020-10-01+a%CC%80s+15.19.25.png)

- Slather para reportar cobertura de testes em conjunto com Fastlane.

![Captura de tela 5](https://amarildolucas.s3-sa-east-1.amazonaws.com/Captura+de+Tela+2020-10-01+a%CC%80s+15.22.29.png)

- GitHub Actions com pipeline simples de CI.

![Captura de tela 6](https://amarildolucas.s3-sa-east-1.amazonaws.com/Captura+de+Tela+2020-10-01+a%CC%80s+15.28.19.png)

## Breves considerações

- MVP foi usado como padrão de arquitetura.
- Testes de código assíncrono foram separados em target diferentes por serem mais demorados. Separação seria útil se usado com Test Plans no Xcode ou executando numa CI.
