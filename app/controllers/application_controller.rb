class ApplicationController < Jets::Controller::Base
    def index
        render json: {status: true}
    end
end
