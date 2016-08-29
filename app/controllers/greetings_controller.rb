class GreetingsController < ApplicationController
  def index
    render json: {
      "Note" => "Hello! Here are your API calls:",
      "api" => [
        {
          name: "GET /api/v1/announcements",
          parameters: [
            {name: "limit", type: "int", required: false, default: 20},
          ],
        },
        {
          name: "GET /api/v1/announcements/:id",
        },
        {
          name: "GET /api/v2/announcements",
          parameters: [
            {name: "limit", type: "int", required: false, default: 20},
            {name: "offset", type: "int", required: false, default: 0},
          ],
        },
        {
          "name": "GET /api/v2/announcements/:id",
        },
      ]
    }
  end
end
