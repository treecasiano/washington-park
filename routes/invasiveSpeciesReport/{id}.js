function factory(logger, invasiveSpeciesReportService) {
  DELETE.apiDoc = {
    summary: "Deletes a record by ID",
    tags: ["Invasive Species Report"],
    parameters: [
      {
        description: "Invasive Species Report Record ID",
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
    summary: "Get Invasive Species Report record by ID",
    tags: ["Invasive Species Report"],
    produces: ["application/json"],
    parameters: [
      {
        description: "Invasive Species Report ID",
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
    tags: ["Invasive Species Report"],
    produces: ["application/json"],
    parameters: [
      {
        description: "Invasive Species Report ID",
        in: "path",
        minimum: 1,
        name: "id",
        required: true,
        type: "integer",
      },
      {
        description: "updates",
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
              type: "string",
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
      record = await invasiveSpeciesReportService.get(id);
      if (!record) {
        return res.status(404).json({ message: `No record for id: ${id}` });
      }
    } catch (e) {
      console.error(e);
      return res.status(500).json({ message: "Internal Server Error" });
    }
    try {
      result = await invasiveSpeciesReportService.remove(id);
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
      record = await invasiveSpeciesReportService.get(id);
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
      record = await invasiveSpeciesReportService.get(id);
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
      await invasiveSpeciesReportService.update(id, updates);
      result = await invasiveSpeciesReportService.get(id);
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
