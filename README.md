<h1 align="center">:dragon: DnsDragon !</h1>
<p align="center">
  <img src="https://img.shields.io/pypi/status/Django.svg"> 
   <a href="#"><img src="http://www.walderlan.xyz/assets/licenseGPL.svg" alt="License"></a><br />
  :mag_right: Pesquise por diretórios ocultos em aplicações web
</p>

Documentação: pt-br
## Overview

O DnsDragon é um script para scanear aplicações web em busca de diretórios como: administracao/ login/ dashboard/

#### Exemplo do software

![image](https://github.com/WalderlanSena/dnsdragon/blob/master/exemplo.png)

### :computer: Use:

```shellscript
./dnsdragon https://www.SiteQueDesejaScanear.com dragon.txt
```

### Options

```shellscript
./dnsdragon https://www.SiteQueDesejaScanear.com dragon.txt -s
```

**-s** [ Não mostra o fluxo de verificação dos deretórios, ou seja, só mostra para o usúarios os diretórios encontrados ]

### Como funciona as requisições do protocolo HTTP (Hypertext Transfer Protocol) ?

"O Hypertext Transfer Protocol, sigla HTTP (em português Protocolo de Transferência de Hipertexto) é um protocolo de comunicação (na camada de aplicação segundo o Modelo OSI) utilizado para sistemas de informação de hipermídia, distribuídos e colaborativos. Ele é a base para a comunicação de dados da World Wide Web.

Hipertexto é o texto estruturado que utiliza ligações lógicas (hiperlinks) entre nós contendo texto. O HTTP é o protocolo para a troca ou transferência de hipertexto.

Coordenado pela World Wide Web Consortium e a Internet Engineering Task Force, culminou na publicação de uma série de Requests for Comments; mais notavelmente o RFC 2616, de junho de 1999, que definiu o HTTP/1.1. Em Junho de 2014 foram publicados 6 RFC's para maior clareza do protocolo HTTP/1.1. Em Março de 2015, foi divulgado o lançamento do HTTP/2. A atualização deixará o navegador com um tempo de resposta melhor e mais seguro. Ele também melhorará a navegação em smartphones.

Para acedermos a outro documento a partir de uma palavra presente no documento actual podemos utilizar hiperligações (ou âncoras). Estes documentos se encontram no sítio com um endereço de página da Internet – e para acessá-los deve-se digitar o respectivo endereço, denominado URI (Universal Resource Identifier ou Identificador Universal de Recurso), que não deve ser confundido com URL (Universal Resource Locator ou Localizador Universal de Recurso), um tipo de URI que pode ser directamente localizado."

### Códigos de retorno

A linha inicial de uma resposta HTTP indica ao cliente se sua requisição foi bem sucedida ou não.[19] Essa situação é fornecida através de um código de retorno (Status-Code) e uma frase explicativa (Reason-Phrase). De acordo com Fielding,[20] o código de status é formado por três dígitos e o primeiro dígito representa a classe que pertence classificada em cinco tipos:

- 1xx: **Informational** (Informação) – utilizada para enviar informações para o cliente de que sua requisição foi recebida e está sendo processada;
- 2xx: **Success** (Sucesso) – indica que a requisição do cliente foi bem sucedida;
- 3xx: **Redirection** (Redirecionamento) – informa a ação adicional que deve ser tomada para completar a requisição;
- 4xx: **Client Error** (Erro no cliente) – avisa que o cliente fez uma requisição que não pode ser atendida;
- 5xx: **Server Error** (Erro no servidor) – ocorreu um erro no servidor ao cumprir uma requisição válida.

O protocolo HTTP define somente alguns códigos em cada classe descritos na RFC 2616, mas cada servidor pode definir seus próprios códigos.

### Como a veriicação de diretório funciona?

Sabendo que uma requisição **HTTP** terá um código de retorno, capturamos o mesmo e fazemos o teste de existência do dirétorio ou arquivo especifico:

<table>
  <thead>
    <th>Cod</th>
    <th>Significado</th>
  </thead>  
  <tbody>
        <tr>
          <td><b>200 OK</b></td>
          <td>Diretório ou arquivo encontrado</td>
        </tr>
        <tr>
          <td><b>403 Forbidden</b></td>
          <td>Diretório encontrado mas não há permissão de acesso</td>
        </tr>
        <tr>
          <td><b>302 Moved Temporarily</b></td>
          <td>O cliente para executar um redirecionamento temporário</td>
        </tr>
  </tbody>
</table>

<h3>Licença</h3>

O **dnsDragon** é um software de código aberto licenciado sob a licença [GPL license](https://github.com/WalderlanSena/dnsdragon/blob/master/LICENSE).
