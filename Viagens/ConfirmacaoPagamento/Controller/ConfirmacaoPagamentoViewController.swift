//
//  ConfirmacaoPagamentoViewController.swift
//  Viagens
//
//  Created by Ana Leticia Camargos on 02/03/19.
//  Copyright © 2019 Ana Leticia Camargos. All rights reserved.
//

import UIKit

class ConfirmacaoPagamentoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTituloPacoteViagem: UILabel!
    @IBOutlet weak var labelHotel: UILabel!
    @IBOutlet weak var labelData: UILabel!
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var labelQuantidadePessoas: UILabel!
    
    var pacoteComprado: PacoteViagem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pacote = pacoteComprado {
            self.imageView.image = UIImage(named: pacote.viagem.caminhoDaImagem)
            self.labelHotel.text = pacote.nomeHotel
            self.labelTituloPacoteViagem.text = pacote.viagem.titulo.uppercased()
            self.labelData.text = pacote.dataViagem
            self.labelDescricao.text = pacote.descricao
            
            self.imageView.layer.cornerRadius = 10
            self.imageView.layer.masksToBounds = true
        }
    }
    
    @IBAction func botaoVoltarHome(_ sender: UIButton) {
        if let navigation = self.navigationController {
            navigation.popToRootViewController(animated: true)
        }
    }
}
