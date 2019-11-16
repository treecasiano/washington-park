const dropdownValues = require("../../src/dropdownValues.json");
const { locationTypes, stateAbbreviations } = dropdownValues;

function factory(logger, parkLocationService) {
  DELETE.apiDoc = {
    summary: "Deletes a record by ID",
    tags: ["Park Location"],
    parameters: [
      {
        description: "Park Location Record ID",
        in: "path",
        minimum: 1,
        name: "id",
        required: true,
        type: "integer",
      },
    ],
    responses: {
      200: {
        description: "OK",
      },
      404: {
        description: "Not found",
      },
      500: {
        description: "Server Error",
      },
    },
  };

  GET.apiDoc = {
    summary: "Get Park Location record by ID",
    tags: ["Park Location"],
    produces: ["application/json"],
    parameters: [
      {
        description: "Park Location ID",
        in: "path",
        minimum: 1,
        name: "id",
        required: true,
        type: "integer",
      },
    ],
    responses: {
      200: {
        description: "OK",
      },
      404: {
        description: "Not found",
      },
      500: {
        description: "Server Error",
      },
    },
  };

  PUT.apiDoc = {
    summary: "Update record",
    tags: ["Park Location"],
    produces: ["application/json"],
    parameters: [
      {
        description: "Park Location ID",
        in: "path",
        minimum: 1,
        name: "id",
        required: true,
        type: "integer",
      },
      {
        description: "updates",
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
              enum: stateAbbreviations,
              default: "OR",
            },
            ZIP: {
              description: "ZIP Code",
              type: "string",
            },
            location_type: {
              description: "Park Location Type",
              type: "string",
              enum: locationTypes,
            },
            hrs_of_operation: {
              description: "Hours of Operation",
              type: ["string"],
            },
            url: {
              description: "Park Location URL",
              type: ["string"],
            },
            image_url: {
              description: "Park Location Image URL",
              type: ["string"],
            },
            description: {
              description: "Park Location Description",
              type: ["string"],
            },
            geom: {
              description: "Geometry in the form of 'POINT(long lat)'",
              type: "string",
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
      404: {
        description: "Not found",
      },
      500: {
        description: "Server Error",
      },
    },
  };

  return {
    DELETE,
    GET,
    PUT,
  };

  async function DELETE(req, res) {
    const {
      params: { id },
    } = req;

    let record;
    let result;
    try {
      record = await parkLocationService.get(id);
      if (!record) {
        return res.status(404).json({ message: `No record for id: ${id}` });
      }
    } catch (e) {
      console.error(e);
      return res.status(500).json({ message: "Internal Server Error" });
    }
    try {
      result = await parkLocationService.remove(id);
    } catch (e) {
      console.error(e);
      return res.status(500).json({ message: "Internal Server Error" });
    }

    return res.status(200).json({ result });
  }

  async function GET(req, res) {
    const {
      params: { id },
    } = req;

    let record;
    try {
      record = await parkLocationService.get(id);
    } catch (e) {
      logger.error(e);
      return res.status(500).json({ message: "Server Error" });
    }
    if (!record) {
      return res.status(404).json({ message: `No record for id ${id}` });
    }
    return res.status(200).json(record);
  }

  async function PUT(req, res) {
    const {
      params: { id },
    } = req;

    const updates = req.body;

    if (Object.keys(updates).length < 1) {
      return res
        .status(400)
        .json({ message: "Must update at least one attribute" });
    }

    let record;
    try {
      record = await parkLocationService.get(id);
    } catch (e) {
      logger.error(e);
      return res.status(500).json({ message: "Database error" });
    }

    if (!record) {
      return res
        .status(404)
        .json({ message: `Unable to find record for id: ${id}` });
    }

    let result;
    try {
      await parkLocationService.update(id, updates);
      result = await parkLocationService.get(id);
    } catch (e) {
      logger.error(e);
      return res.status(500).json({
        message: "Database error",
      });
    }

    return res.status(200).json({ result });
  }
}

module.exports = factory;
