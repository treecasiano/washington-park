function factory(logger, invasiveSpeciesReportService) {
  GET.apiDoc = {
    summary: "Gets a list of all Invasive Species Reports",
    tags: ["Invasive Species Report"],
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
    summary: "Creates an Invasive Species Report",
    tags: ["Invasive Species Report"],
    produces: ["application/json"],
    parameters: [
      {
        description: "Record attributes",
        in: "body",
        name: "invasiveSpeciesReport",
        required: true,
        schema: {
          properties: {
            active: {
              description: "Report Active Status",
              enum: [0, 1],
              type: "integer",
              default: 1,
            },
            admin_notes: {
              description: "Admin Notes",
              type: ["string"],
            },
            observation_date: {
              description: "Observation Date",
              type: "string",
            },
            observer_email: {
              description: "Observer Email",
              type: "string",
            },
            observer_first_name: {
              description: "Observer First Name",
              type: "string",
            },
            observer_last_name: {
              description: "Observer Last Name",
              type: "string",
            },
            observer_phone: {
              description: "Observer Phone Number",
              type: "string",
            },
            organism_type: {
              description: "Invasive Species Type",
              type: "string",
            },
            organism_description: {
              description: "Invasive Species Description",
              type: "string",
            },
            location_details: {
              description: "Invasive Species Location Details",
              type: "string",
            },
            geom: {
              description: "Geometry in the form of 'POINT(long lat)'",
              type: "string",
            },
          },
          required: ["geom"],
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
      result = await invasiveSpeciesReportService.list();
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
      const { user_id } = await invasiveSpeciesReportService.create(params);
      result = await invasiveSpeciesReportService.get(user_id);
    } catch (e) {
      console.error(e);
      return res.status(500).json({ message: "Internal Server Error" });
    }
    return res.status(200).json({ result });
  }
}

module.exports = factory;
