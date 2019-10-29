const dropdownValues = require("../../src/dropdownValues.json");
const { locationTypes } = dropdownValues;

function factory(logger, parkLocationService) {
  POST.apiDoc = {
    summary: "Returns a GeoJSON Feature Collection filtered by location type",
    tags: ["Park Location"],
    produces: ["application/json"],
    parameters: [
      {
        description: "Search terms",
        in: "body",
        name: "search",
        required: true,
        schema: {
          properties: {
            location_type: {
              description: "Park Location Type",
              type: "string",
              enum: locationTypes,
            },
          },
          type: "object",
        },
      },
    ],
    responses: {
      200: {
        description: "OK",
      },
      500: {
        description: "Server Error",
      },
    },
  };

  return {
    POST,
  };

  async function POST(req, res) {
    const { body } = req;
    console.log("POST BODY", body);

    let result;
    try {
      result = await parkLocationService.getGeoDataByType(body);
    } catch (e) {
      logger.error(e);
      return res.status(500).json({ message: "Internal Server Error" });
    }

    if (!result) {
      result = [];
    }

    return res.status(200).json(result);
  }
}

module.exports = factory;
