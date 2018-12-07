// main.swift
import Utility  // ArgumentParserのために必要
import QiitaCore // Qiitaのために必要
import Dispatch // dispatchMainのために必要

// CommandLine.argumentsでコマンドラインから引数を受け取れます
// arguments[0]にはコマンド名が入ってくるので除いておきます。
print(CommandLine.arguments[0])
let arguments = Array(CommandLine.arguments.dropFirst())

// コマンドオプションの定義
let parser = ArgumentParser(usage: "-k [keyword]", overview: "Qiitaで記事を検索します")
let keyword = parser.add(option: "--keyword", shortName: "-k", kind: String.self)

do {
    let result = try parser.parse(arguments)
    if let keyword = result.get(keyword) {
      print("'\(keyword)'でQiitaの記事を検索します")

      let q = Qiita(keyword: "swift")
      q.search { result in
          print("result: \(result ?? "")")
          exit(0)
      }

      dispatchMain()
    } else {
      print("エラー")
    }
} catch {
    print(error)
}
