#language: pt

Funcionalidade: Criar um requisito
    COMO um administrado EU QUERO criar um novo requisito a partir da home.

    Contexto:
        Dado que meu banco de daos está inicializado


        Cenário: Criar um requisito como um administrador
            Dado que eu estou na "home" e eu estou logado como "administrador"
            Quando eu clico no link "Requerimentos"
            Quando eu aperto no botão "Novo requerimento"
            E eu preencho o campo "requirement_name" com o valor "Nome"
            E eu preencho o campo "requirement_description" com o valor "Nome nome nome"
            Quando eu aperto no botão "Criar Requirement"
            Então eu espero ver "Requirement was successfully created."

        Cenário: Ver um requisito que eu criei como um administrador
            Dado que eu criei um requisito com o nome "Nome" e com o valor "Nome nome nome" como administrador
            E que eu estou na "home"
            Quando eu clico no link "Requerimentos"
            Então eu espero ver "Nome"
            E eu espero ver "Nome nome nome"


        Cenário: Vizualizar os requisitos como um usuário
            Dado que eu estou na "home"
            Quando eu clico no link "Requerimentos"
            Então eu espero ver "Nome"
            E eu espero ver "Nome nome nome nome"

        Cenário: Vizualizar os requisitos como um estudante
            Dado que eu estou na "home" e eu estou logado como "estudante"
            Quando eu clico no link "Requerimentos"
            Então eu espero ver "Nome"
            E eu espero ver "Nome nome nome nome"

        Cenário: Vizualizar os requisitos como um professor
            Dado que eu estou na "home" e eu estou logado como "professor"
            Quando eu clico no link "Requerimentos"
            Então eu espero ver "Nome"
            E eu espero ver "Nome nome nome nome"

        Cenário: Vizualizar os requisitos como um secretário
            Dado que eu estou na "home" e eu estou logado como "secretário"
            Quando eu clico no link "Requerimentos"
            Então eu espero ver "Nome"
            E eu espero ver "Nome nome nome nome"

        Cenário: Vizualizar os requisitos como um administrador
            Dado que eu estou na "home" e eu estou logado como "administrador"
            Quando eu clico no link "Requerimentos"
            Então eu espero ver "Nome"
            E eu espero ver "Nome nome nome nome"