//
//  PacotesViewController.swift
//  Viagens
//
//  Created by Ana Leticia Camargos on 01/03/19.
//  Copyright © 2019 Ana Leticia Camargos. All rights reserved.
//

import UIKit

class PacotesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pesquisarViagem: UISearchBar!
    @IBOutlet weak var labelContadorPacotes: UILabel!

    let listaComTodasViagens:Array<PacoteViagem> = PacoteViagemDAO().retornaTodasAsViagens()
    var listaViagens: Array<PacoteViagem> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaViagens = listaComTodasViagens
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.pesquisarViagem.delegate = self
        self.labelContadorPacotes.text = self.atualizaContadorLabel()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaViagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacoteViagemCollectionViewCell
        
        let pacoteAtual = listaViagens[indexPath.row]
        
        cell.imageView.image = UIImage(named: pacoteAtual.viagem.caminhoDaImagem)
        cell.labelTitulo.text = pacoteAtual.viagem.titulo
        cell.labelPreco.text = "R$ \(pacoteAtual.viagem.preco)"
        cell.labelQuantidadeDias.text = "\(pacoteAtual.viagem.quantidadeDeDias)"
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let largura = collectionView.bounds.width / 2
        return CGSize(width: largura - 15, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pacote = listaViagens[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesViagensViewController
        controller.pacoteSelecionado = pacote
        //self.present(controller, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listaViagens = listaComTodasViagens
        if searchText != "" {
            
            let filtroListaViagem = NSPredicate(format: "titulo contains %@", searchText)
            let listaFiltrada: Array<PacoteViagem> = (listaViagens as NSArray).filtered(using: filtroListaViagem) as! Array
            listaViagens = listaFiltrada
            
        }
        
        self.labelContadorPacotes.text = self.atualizaContadorLabel()
        collectionView.reloadData()
    }
    
    func atualizaContadorLabel ( ) -> String {
        return listaViagens.count == 1 ? "1 pacote encontrado" : "\(listaViagens.count) pacotes encontrados"
    }
}
