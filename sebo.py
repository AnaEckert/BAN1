import psycopg2
from tabulate import tabulate
from datetime import datetime


def conectar():
    return psycopg2.connect(database="sebo",
                            host="localhost",
                            user="postgres",
                            password="4077",
                            port="5432")


def listar_tabela(nome_tabela):
    conexao = conectar()
    cursor = conexao.cursor()
    cursor.execute(f"SELECT * FROM {nome_tabela}")
    colunas = [desc[0] for desc in cursor.description]
    dados = cursor.fetchall()
    print(f"\nTabela {nome_tabela}:")
    print(tabulate(dados, headers=colunas, tablefmt='grid'))
    cursor.close()
    conexao.close()


def inserir_tupla_pessoa(tabela):
    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute("SELECT MAX(idPessoa) FROM Pessoa")
    resultado = cursor.fetchone()[0]
    id = 1 if resultado is None else resultado + 1

    print(f"\nPreencha os valores para a tabela 'Pessoa':")
    nome = input("Nome da pessoa: ")
    dataNascStr = input("Data de nascimento (DD/MM/AAAA): ")
    dataNasc = datetime.strptime(dataNascStr, "%d/%m/%Y").date()
    endereco = input("Endereço: ")
    telefone = int(input("Telefone: "))
    cpf = int(input("Cpf: "))
    email = input("Email: ")
    obs = input("Deseja fazer uma observacao? (Sim - Escreva; Não - Enter")
    tipo = int(input("Tipo (1 - Cliente; 2 - Funcionario): "))

    cursor.execute(
        "INSERT INTO Pessoa (idPessoa, nome, dataNascimento, endereco, telefone, cpf, email, observacao, tipo) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
        (id, nome, dataNasc, endereco, telefone, cpf, email, obs, tipo)
    )
    conexao.commit()
    print("Inserido com sucesso.")
    cursor.close()
    conexao.close()

def inserir_tupla_venda(tabela):
    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute("SELECT MAX(idVenda) FROM Venda")
    resultado = cursor.fetchone()[0]
    id = 1 if resultado is None else resultado + 1

    print(f"\nPreencha os valores para a tabela 'Venda':")
    dataStr = input("Data da venda (DD/MM/AAAA): ")
    data = datetime.strptime(dataStr, "%d/%m/%Y").date()
    horaStr = input("Digite o horário (HH:MM:SS): ")
    hora = datetime.strptime(horaStr, "%H:%M:%S").time()
    parcelamento = int(input("Houve parcelamento? (Sim - Insira em quantas vezes; Não - 0): "))
    formaPagamento = input("Forma de pagamento: ")
    notaFiscal = input("Dados da nota fiscal (Não obrigatório): ")
    idCliente = int(input("Id Cliente: "))
    idFuncionario = int(input("Id Funcionario: "))

    if parcelamento == '0':
        cursor.execute(
            "INSERT INTO Venda (idVenda, dataVenda, horaVenda, formaPagamento, notaFiscal, idCliente, idFuncionario) VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (id, data, hora, formaPagamento, notaFiscal, idCliente, idFuncionario)
        )
    else:
        cursor.execute(
            "INSERT INTO Venda (idVenda, dataVenda, horaVenda, parcelamento, formaPagamento, notaFiscal, idCliente, idFuncionario) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
            (id, data, hora, parcelamento, formaPagamento, notaFiscal, idCliente, idFuncionario)
        )

    conexao.commit()
    print("Inserido com sucesso.")
    cursor.close()
    conexao.close()

def inserir_tupla_item(tabela):
    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute("SELECT MAX(idItem) FROM Item")
    resultado = cursor.fetchone()[0]
    id = 1 if resultado is None else resultado + 1

    print(f"\nPreencha os valores para a tabela 'Item':")
    quantidade = int(input("Quantidade do Item (na venda): "))
    idProduto = int(input("Id Produto (livro): "))
    idVenda = int(input("Id Venda: "))

    cursor.execute(
        "INSERT INTO Item (idItem, quantidade, idProduto, idVenda) VALUES (%s, %s, %s, %s)",
        (id, quantidade, idProduto, idVenda)
    )
    conexao.commit()
    print("Inserido com sucesso.")
    cursor.close()
    conexao.close()

def inserir_tupla_livro(tabela):
    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute("SELECT MAX(idProduto) FROM Livro")
    resultado = cursor.fetchone()[0]
    id = 1 if resultado is None else resultado + 1

    print(f"\nPreencha os valores para a tabela 'Livro':")
    idEstante = int(input("Id Estante onde se encontra: "))
    qtdEstoque = int(input("Quantidade em estoque: "))
    preco = int(input("Preço: "))
    nome = input("Título: ")
    tipo = input("Tipo (livro, HQ...): ")
    genero = input("Gênero: ")
    estado = input("Estado de conservação (não obrigatório): ")
    formato = input("Formato (não obrigatório): ")

    cursor.execute(
        "INSERT INTO Livro (idProduto, idEstante, qtdEstoque, preco, nome, tipo, genero, estado, formato) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
        (id, idEstante, qtdEstoque, preco, nome, tipo, genero, estado, formato

         )
    )
    conexao.commit()
    print("Inserido com sucesso.")
    cursor.close()
    conexao.close()

def inserir_tupla_autoria(tabela):
    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute("SELECT MAX(idAutoria) FROM Autoria")
    resultado = cursor.fetchone()[0]
    id = 1 if resultado is None else resultado + 1

    print(f"\nPreencha os valores para a tabela 'Autoria':")
    idProduto = int(input("Id Produto: "))
    idAutor = int(input("Id Autor: "))

    cursor.execute(
        "INSERT INTO Autoria (idAutoria, idProduto, idAutor) VALUES (%s, %s, %s)",
        (id, idProduto, idAutor)
    )
    conexao.commit()
    print("Inserido com sucesso.")
    cursor.close()
    conexao.close()

def inserir_tupla_autor(tabela):
    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute("SELECT MAX(idAutor) FROM Autor")
    resultado = cursor.fetchone()[0]
    id = 1 if resultado is None else resultado + 1

    print(f"\nPreencha os valores para a tabela 'Autor':")
    nome = input("Nome: ")
    idiomaPrincipal = input("Idioma principal (Não obrigatório): ")
    nacionalidade = input("Nacionalidade: ")
    numObrasAcervo = int(input("Número de obras no acervo: "))
    sexo = input("Sexo (não obrigatório): ")

    cursor.execute(
        "INSERT INTO Autor (idAutor, nome, idiomaPrincipal, nacionalidade, numObrasAcervo, sexo) VALUES (%s, %s, %s, %s, %s, %s)",
        (id, nome, idiomaPrincipal, nacionalidade, numObrasAcervo, sexo)
    )
    conexao.commit()
    print("Inserido com sucesso.")
    cursor.close()
    conexao.close()

def inserir_tupla_estante(tabela):
    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute("SELECT MAX(idEstante) FROM Estante")
    resultado = cursor.fetchone()[0]
    id = 1 if resultado is None else resultado + 1

    print(f"\nPreencha os valores para a tabela 'Estante':")
    andar = int(input("Andar: "))
    secao = input("Seção: ")

    cursor.execute(
        "INSERT INTO Estante (idEstante, andar, secao) VALUES (%s, %s, %s)",
        (id, andar, secao)
    )
    conexao.commit()
    print("Inserido com sucesso.")
    cursor.close()
    conexao.close()

def remover_tupla_pessoa(tabela, coluna_id):
    conexao = conectar()
    cursor = conexao.cursor()

    id_valor = input(f"Digite o id da pessoa que deseja remover: ")

    try:
        cursor.execute(
            f"DELETE FROM Pessoa WHERE idPessoa = %s",
            (id_valor,)
        )
        conexao.commit()

        if cursor.rowcount > 0:
            print("Tupla removida com sucesso.")
        else:
            print("Nenhuma tupla encontrada com esse ID.")
    except Exception as e:
        print("Erro ao remover tupla:", e)

    cursor.close()
    conexao.close()

def remover_tupla_venda(tabela, coluna_id):
    conexao = conectar()
    cursor = conexao.cursor()

    id_valor = input(f"Digite o id da venda que deseja remover: ")

    try:
        cursor.execute(
            f"DELETE FROM Venda WHERE idVenda = %s",
            (id_valor,)
        )
        conexao.commit()

        if cursor.rowcount > 0:
            print("Tupla removida com sucesso.")
        else:
            print("Nenhuma tupla encontrada com esse ID.")
    except Exception as e:
        print("Erro ao remover tupla:", e)

    cursor.close()
    conexao.close()

def remover_tupla_item(tabela, coluna_id):
    conexao = conectar()
    cursor = conexao.cursor()

    id_valor = input(f"Digite o id do item que deseja remover: ")

    try:
        cursor.execute(
            f"DELETE FROM Item WHERE idItem = %s",
            (id_valor,)
        )
        conexao.commit()

        if cursor.rowcount > 0:
            print("Tupla removida com sucesso.")
        else:
            print("Nenhuma tupla encontrada com esse ID.")
    except Exception as e:
        print("Erro ao remover tupla:", e)

    cursor.close()
    conexao.close()

def remover_tupla_livro(tabela, coluna_id):
    conexao = conectar()
    cursor = conexao.cursor()

    id_valor = input(f"Digite o id do livro que deseja remover: ")

    try:
        cursor.execute(
            f"DELETE FROM Livro WHERE idProduto = %s",
            (id_valor,)
        )
        conexao.commit()

        if cursor.rowcount > 0:
            print("Tupla removida com sucesso.")
        else:
            print("Nenhuma tupla encontrada com esse ID.")
    except Exception as e:
        print("Erro ao remover tupla:", e)

    cursor.close()
    conexao.close()

def remover_tupla_autoria(tabela, coluna_id):
    conexao = conectar()
    cursor = conexao.cursor()

    id_valor = input(f"Digite o id da autoria que deseja remover: ")

    try:
        cursor.execute(
            f"DELETE FROM Autoria WHERE idAutoria = %s",
            (id_valor,)
        )
        conexao.commit()

        if cursor.rowcount > 0:
            print("Tupla removida com sucesso.")
        else:
            print("Nenhuma tupla encontrada com esse ID.")
    except Exception as e:
        print("Erro ao remover tupla:", e)

    cursor.close()
    conexao.close()

def remover_tupla_autor(tabela, coluna_id):
    conexao = conectar()
    cursor = conexao.cursor()

    id_valor = input(f"Digite o id da autor que deseja remover: ")

    try:
        cursor.execute(
            f"DELETE FROM Autor WHERE idAutor = %s",
            (id_valor,)
        )
        conexao.commit()

        if cursor.rowcount > 0:
            print("Tupla removida com sucesso.")
        else:
            print("Nenhuma tupla encontrada com esse ID.")
    except Exception as e:
        print("Erro ao remover tupla:", e)

    cursor.close()
    conexao.close()

def remover_tupla_estante(tabela, coluna_id):
    conexao = conectar()
    cursor = conexao.cursor()

    id_valor = input(f"Digite o id da estante que deseja remover: ")

    try:
        cursor.execute(
            f"DELETE FROM Estante WHERE idEstante = %s",
            (id_valor,)
        )
        conexao.commit()

        if cursor.rowcount > 0:
            print("Tupla removida com sucesso.")
        else:
            print("Nenhuma tupla encontrada com esse ID.")
    except Exception as e:
        print("Erro ao remover tupla:", e)

    cursor.close()
    conexao.close()

def consulta_join(tabela1, tabela2):
    conexao = conectar()
    cursor = conexao.cursor()
    cursor.execute(f"SELECT v.idVenda, c.nome AS Cliente, f.nome AS Funcionario FROM Pessoa c JOIN Venda v ON c.idPessoa = v.idCliente JOIN Pessoa f ON v.idFuncionario = f.idPessoa")
    colunas = [desc[0] for desc in cursor.description]
    dados = cursor.fetchall()
    print(f"\nTabela Nome de Cliente e Funcionario que participaram em cada Venda:")
    print(tabulate(dados, headers=colunas, tablefmt='grid'))
    cursor.close()
    conexao.close()

def consulta_join_2(tabela1, tabela2, tabela3):
    conexao = conectar()
    cursor = conexao.cursor()
    cursor.execute(f"SELECT l.nome AS Livro, a.nome AS Autor FROM Livro l JOIN Autoria au ON l.idProduto = au.idProduto JOIN Autor a ON au.idAutor = a.idAutor")
    colunas = [desc[0] for desc in cursor.description]
    dados = cursor.fetchall()
    print(f"\nTabela Nomes de Livros com Seus Autores")
    print(tabulate(dados, headers=colunas, tablefmt='grid'))
    cursor.close()
    conexao.close()

def subconsulta_agregacao(tabela):
    conexao = conectar()
    cursor = conexao.cursor()
    cursor.execute(
        f"SELECT nome, genero, preco FROM Livro WHERE preco = ANY(SELECT MAX(preco) FROM Livro)")
    colunas = [desc[0] for desc in cursor.description]
    dados = cursor.fetchall()
    print(f"\nTabela de nomes, generos e preco de Livros com Maior Preco")
    print(tabulate(dados, headers=colunas, tablefmt='grid'))
    cursor.close()
    conexao.close()

def subconsulta_agregacao_2(tabela1, tabela2):
    conexao = conectar()
    cursor = conexao.cursor()
    cursor.execute(
        f"SELECT l1.nome AS NomeLivro, l1.idEstante AS IDEstante FROM Livro l1 WHERE l1.idEstante IN(SELECT e.idEstante FROM Livro l2 JOIN Estante e ON l2.idEstante = e.idEstante GROUP BY e.idEstante HAVING COUNT(l2.idProduto) > 1)")
    colunas = [desc[0] for desc in cursor.description]
    dados = cursor.fetchall()
    print(f"\nTabela de nomes de Livros que estão em Estantes que possuem 2 ou Mais títulos diferentes de Livros")
    print(tabulate(dados, headers=colunas, tablefmt='grid'))
    cursor.close()
    conexao.close()

def menu():
    while True:
        print("\n=== MENU ===")
        print("1. Listar tuplas de uma tabela")
        print("2. Inserir nova tupla em Pessoa")
        print("3. Inserir nova tupla em Venda")
        print("4. Inserir nova tupla em Item")
        print("5. Inserir nova tupla em Livro")
        print("6. Inserir nova tupla em Autoria")
        print("7. Inserir nova tupla em Autor")
        print("8. Inserir nova tupla em Estante")
        print("9. Remover tupla em Pessoa")
        print("10. Remover tupla em Venda")
        print("11. Remover tupla em Item")
        print("12. Remover tupla em Livro")
        print("13. Remover tupla em Autoria")
        print("14. Remover tupla em Autor")
        print("15. Remover tupla em Estante")
        print("16. Consulta com JOIN - VendaXPessoa")
        print("17. Consulta com JOIN - LivroXAutoriaXAutor")
        print("18. Subconsulta e Agregação - ANY e MAX")
        print("19. Subconsulta e Agregação - IN e GROUP BY-HAVING-COUNT")
        print("0. Sair")
        opcao = input("Escolha uma opção: ")

        if opcao == '1':
            tabela = input("Nome da tabela: ")
            listar_tabela(tabela)
        elif opcao == '2':
            inserir_tupla_pessoa("Pessoa")
        elif opcao == '3':
            inserir_tupla_venda("Venda")
        elif opcao == '4':
            inserir_tupla_item("Item")
        elif opcao == '5':
            inserir_tupla_livro("Livro")
        elif opcao == '6':
            inserir_tupla_autoria("Autoria")
        elif opcao == '7':
            inserir_tupla_autor("Autor")
        elif opcao == '8':
            inserir_tupla_estante("Estante")
        elif opcao == '9':
            remover_tupla_pessoa("Pessoa", "idPessoa")
        elif opcao == '10':
            remover_tupla_venda("Venda", "idVenda")
        elif opcao == '11':
            remover_tupla_item("Item", "idItem")
        elif opcao == '12':
            remover_tupla_livro("Livro", "idLivro")
        elif opcao == '13':
            remover_tupla_autoria("Autoria", "idAutoria")
        elif opcao == '14':
            remover_tupla_autor("Autor", "idAutor")
        elif opcao == '15':
            remover_tupla_estante("Estante", "idEstante")
        elif opcao == '16':
            consulta_join("Pessoa", "Venda")
        elif opcao == '17':
            consulta_join_2("Livro", "Autoria", "Autor")
        elif opcao == '18':
            subconsulta_agregacao("Livro")
        elif opcao == '19':
            subconsulta_agregacao_2("Livro", "Estante")
        elif opcao == '0':
            print("Encerrando.")
            break
        else:
            print("Opção inválida!")


if __name__ == "__main__":
    menu()
