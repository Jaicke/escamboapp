class Site::Profile::MyDataController < Site::ProfileController
    before_action :set_profile_member, only: [:edit, :update]

    def edit
    end

    def update
        if @profile_member.update(params_profile_member)
            redirect_to edit_site_profile_my_datum_path, notice: "Perfil atualizado"
        else
            render :edit
        end
    end

    private

    def set_profile_member
        @profile_member = ProfileMember.find_or_create_by(member: current_member)
    end
    

    def params_profile_member
        params.require(:profile_member).permit(:first_name, :second_name, :birthdate)
    end
    
    
    
end
