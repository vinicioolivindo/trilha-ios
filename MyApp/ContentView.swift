//
//  ContentView.swift
//  MyApp
//
//  Created by iredefbmac_23 on 16/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var texto: String = ""
    @State private var operacao: String = ""
    @State private var parametro1: String = ""
    @State private var parametro2: String = ""
    @State private var resultado: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                inputSection
                operationPicker
                parameterInputs
                executeButton	
                resultView
                Spacer()
            }
            .navigationTitle("Ferramenta de Texto")
        }
    }

    private var inputSection: some View {
        TextEditor(text: $texto)
            .frame(height: 200)
            .border(Color.gray, width: 1)
            .padding()
            .cornerRadius(8)
    }

    private var operationPicker: some View {
        Picker("Operação", selection: $operacao) {
            Text("Contar Palavras").tag("contar")
            Text("Buscar Palavra").tag("buscar")
            Text("Substituir Palavra").tag("substituir")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }

    private var parameterInputs: some View {
        VStack {
            if operacao == "buscar" || operacao == "substituir" {
                TextField("Parâmetro 1 (Palavra ou palavra antiga)", text: $parametro1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }

            if operacao == "substituir" {
                TextField("Parâmetro 2 (Nova palavra)", text: $parametro2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
        }
    }

    private var executeButton: some View {
        Button(action: executarOperacao) {
            Text("Executar")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }

    private var resultView: some View {
        ScrollView {
            Text(resultado)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .border(Color.gray, width: 1)
                .cornerRadius(8)
        }
    }

    private func executarOperacao() {
        switch operacao {
        case "contar":
            let quantidadePalavras = contarPalavras(no: texto)
            resultado = "Número de palavras: \(quantidadePalavras)"

        case "buscar":
            guard !parametro1.isEmpty else {
                resultado = "Por favor, insira a palavra a ser buscada."
                return
            }
            let encontrada = buscarPalavra(parametro1, no: texto)
            resultado = encontrada ? "Palavra encontrada." : "Palavra não encontrada."

        case "substituir":
            guard !parametro1.isEmpty && !parametro2.isEmpty else {
                resultado = "Por favor, insira a palavra antiga e a nova palavra."
                return
            }
            texto = substituirPalavra(parametro1, por: parametro2, no: texto)
            resultado = "Palavra substituída com sucesso."

        default:
            resultado = "Operação desconhecida."
        }
    }

    private func contarPalavras(no texto: String) -> Int {
        let palavras = texto.split { !$0.isLetter }
        return palavras.count
    }

    private func buscarPalavra(_ palavra: String, no texto: String) -> Bool {
        return texto.contains(palavra)
    }

    private func substituirPalavra(_ palavraAntiga: String, por palavraNova: String, no texto: String) -> String {
        return texto.replacingOccurrences(of: palavraAntiga, with: palavraNova)
    }
}

	
