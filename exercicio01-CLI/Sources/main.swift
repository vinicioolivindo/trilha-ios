import Foundation

// Função para contagem de palavras
func contarPalavras(no texto: String) -> Int {
    let palavras = texto.split { !$0.isLetter }
    return palavras.count
}

// Função para busca de uma palavra
func buscarPalavra(_ palavra: String, no texto: String) -> Bool {
    return texto.contains(palavra)
}

// Função para substituir uma palavra
func substituirPalavra(_ palavraAntiga: String, por palavraNova: String, no texto: String) -> String {
    return texto.replacingOccurrences(of: palavraAntiga, with: palavraNova)
}

// Função principal da CLI
func executarCLI() {
    let argumentos = CommandLine.arguments
    guard argumentos.count > 2 else {
        print("Uso: command <operacao> <arquivo> [<params>]")
        return
    }

    let operacao = argumentos[1]
    let caminhoArquivo = argumentos[2]

    do {
        let conteudo = try String(contentsOfFile: caminhoArquivo, encoding: .utf8)
        switch operacao {
        case "contar":
            let quantidadePalavras = contarPalavras(no: conteudo)
            print("Número de palavras: \(quantidadePalavras)")
        case "buscar":
            guard argumentos.count > 3 else {
                print("Uso: command buscar <arquivo> <palavra>")
                return
            }
            let palavra = argumentos[3]
            let encontrada = buscarPalavra(palavra, no: conteudo)
            print(encontrada ? "Palavra encontrada." : "Palavra não encontrada.")
        case "substituir":
            guard argumentos.count > 4 else {
                print("Uso: command substituir <arquivo> <palavraAntiga> <palavraNova>")
                return
            }
            let palavraAntiga = argumentos[3]
            let palavraNova = argumentos[4]
            let novoConteudo = substituirPalavra(palavraAntiga, por: palavraNova, no: conteudo)
            try novoConteudo.write(toFile: caminhoArquivo, atomically: true, encoding: .utf8)
            print("Palavra substituída com sucesso.")
        default:
            print("Operação desconhecida.")
        }
    } catch {
        print("Erro ao ler o arquivo: \(error)")
    }
}

// Executar a função principal
executarCLI()
