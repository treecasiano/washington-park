function factory(logger, exampleService) {
  GET.apiDoc = {
    summary: "Gets a list of all records in the example hello_table database",
    tags: ["Example"],
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
    summary: "Creates a new record in the example hello_table database",
    tags: ["Example"],
    produces: ["application/json"],
    parameters: [
      {
        description: "Record attributes",
        in: "body",
        name: "example",
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
      result = await exampleService.list();
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
      const { user_id } = await exampleService.create(params);
      result = await exampleService.get(user_id);
    } catch (e) {
      console.error(e);
      return res.status(500).json({ message: "Internal Server Error" });
    }
    return res.status(200).json({ result });
  }
}

module.exports = factory;
