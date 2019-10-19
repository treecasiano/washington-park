function factory(logger, exampleService) {
  DELETE.apiDoc = {
    summary: "Deletes a record by ID",
    tags: ["Example"],
    parameters: [
      {
        description: "Record ID",
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
    summary: "Get example record by ID",
    tags: ["Example"],
    produces: ["application/json"],
    parameters: [
      {
        description: "Record by ID from the example hello_world table",
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
    summary: "Update record in hello_table",
    tags: ["Example"],
    produces: ["application/json"],
    parameters: [
      {
        description: "User id in example table",
        in: "path",
        minimum: 1,
        name: "id",
        required: true,
        type: "integer",
      },
      {
        description: "hello_table updates",
        in: "body",
        name: "body",
        required: true,
        schema: {
          properties: {
            username: {
              description: "username",
              type: "string",
            },
            first_name: {
              description: "First Name",
              type: "string",
            },
            last_name: {
              description: "Last Name",
              type: "string",
            },
            favorite_color: {
              description: "Favorite Color",
              type: "string",
            },
            created_on: {
              description: "Date record was created",
              oneOf: [
                { type: "string", format: "date-time" },
                { type: "null" },
              ],
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
      record = await exampleService.get(id);
      if (!record) {
        return res.status(404).json({ message: `No record for id: ${id}` });
      }
    } catch (e) {
      console.error(e);
      return res.status(500).json({ message: "Internal Server Error" });
    }
    try {
      result = await exampleService.remove(id);
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
      record = await exampleService.get(id);
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
      record = await exampleService.get(id);
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
      await exampleService.update(id, updates);
      result = await exampleService.get(id);
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
