function factory(logger, transitStopService) {
  GET.apiDoc = {
    summary: "Gets a list of all Transit Stops",
    tags: ["Transit Stop"],
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

  return {
    GET,
  };

  async function GET(req, res) {
    let result;
    try {
      result = await transitStopService.list();
    } catch (e) {
      logger.error(e);
      return res.status(500).json({ message: "Server Error" });
    }
    return res.status(200).json(result);
  }
}

module.exports = factory;
