// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Executavel", // Nome do projeto
    targets: [
        // Definição do target executável
        .executableTarget(
            name: "Executavel",
            path: "Sources" // Caminho do diretório onde o código está
        ),
    ]
)
