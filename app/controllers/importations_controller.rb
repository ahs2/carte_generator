class ImportationsController < ApplicationController
  def new
    @importation = Importation.new
  end
  
  def create
    @importation = Importation.new(importation_params)
    
    if @importation.save
      ImportationExcelWorker.perform_async(@importation.id)
      flash[:success] = "L'importation des données Excel est programmée !"
      sleep(3) # Ajouter un délai de 3 secondes
      redirect_to cards_path
    else
      flash[:error] = "Veuillez sélectionner un fichier à importer."
      render :new
    end
  end

  def destroy_all
    Importation.destroy_all
    Card.destroy_all
    flash[:success] = "Toutes les données d'importation ont été supprimées avec succès."
    redirect_to root_path
  end

  private

  def importation_params
    params.require(:importation).permit(:file)
  end
end
