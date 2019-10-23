const dropdownValues = require("../src/dropdownValues.json");
const { locationTypes } = dropdownValues;

function factory(logger, parkLocationService) {
  GET.apiDoc = {
    summary: "Gets a list of all Park Locations",
    tags: ["Park Location"],
    produces: ["application/json"],
    parameters: [],
    responses: {
      200: {
        description: "List of records",
      },
      500: {
        description: "Internal Server Error",
      },
    },
  };

  POST.apiDoc = {
    summary: "Creates a Park Location",
    tags: ["Park Location"],
    produces: ["application/json"],
    parameters: [
      {
        description: "Record attributes",
        in: "body",
        name: "parkLocation",
        required: true,
        schema: {
          properties: {
            location_name: {
              description: "Park Location Name",
              type: "string",
            },
            street_addr_1: {
              description: "Street Address Line 1",
              type: "string",
            },
            street_addr_2: {
              description: "Street Address Line 2",
              type: "string",
            },
            city: {
              description: "City",
              type: "string",
              enum: ["Portland"],
              default: "Portland",
            },
            state: {
              description: "State",
              type: "string",
              enum: ["OR"],
            },
            ZIP: {
              description: "ZIP Code",
              type: "string",
            },
            location_type: {
              description: "Park Location Type",
              type: "string",
              enum: locationTypes,
              default: "Attraction",
            },
            hrs_of_operation: {
              description: "Hours of Operation",
              type: "string",
            },
            url: {
              description: "Park Location URL",
              type: "string",
            },
            image_url: {
              description: "Park Location Image URL",
              type: "string",
            },
            description: {
              description: "Park Location Description",
              type: "string",
            },
            geom: {
              description: "Geometry in the form of 'POINT(long lat)'",
              type: "string",
            },
          },
          required: ["location_name", "geom"],
          type: "object",
        },
      },
    ],
    responses: {
      200: {
        description: "Successfully created a new record",
      },
      400: {
        description: "Bad Request",
      },
      500: {
        description: "Internal Server Error",
      },
      default: {
        description: "An error occured",
      },
    },
  };

  return {
    GET,
    POST,
  };

  async function GET(req, res) {
    let result;
    try {
      result = await parkLocationService.list();
    } catch (e) {
      logger.error(e);
      return res.status(500).json({ message: "Server Error" });
    }
    return res.status(200).json(result);
  }

  async function POST(req, res) {
    const { body: params } = req;
    let result;
    if (Object.keys(params).length < 1) {
      return res
        .status(400)
        .json({ message: "Must include at least one attribute" });
    }
    try {
      const { user_id } = await parkLocationService.create(params);
      result = await parkLocationService.get(user_id);
    } catch (e) {
      console.error(e);
      return res.status(500).json({ message: "Internal Server Error" });
    }
    return res.status(200).json({ result });
  }
}

module.exports = factory;
