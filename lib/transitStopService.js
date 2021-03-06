let table = "transit_stops";

function factory({ pg }) {
  return {
    create,
    remove,
    get,
    getGeoJSON,
    list,
    update,
  };

  async function create(params) {
    const insertKeys = Object.keys(params);
    const insertValues = Object.keys(params)
      .map(column => {
        let insertValue = `'${params[column]}'`;
        if (column == "geom") {
          insertValue = `ST_GeomFromText('${params[column]}', 4326)`;
        }
        return `${insertValue}`;
      })
      .join(", ");

    const query = `INSERT INTO ${table}(${insertKeys}) VALUES (${insertValues}) RETURNING gid`;
    const result = await pg.query(query, params);
    return result[0];
  }

  async function remove(id) {
    // prettier-ignore
    const query =
`DELETE FROM ${table} WHERE gid = $1 RETURNING *`;

    const result = await pg.query(query, [id]);
    return result;
  }

  async function get(id) {
    // prettier-ignore
    const query =
`SELECT
  gid,
  location,
  route,
  rte_desc,
  dir_desc,
  ST_AsText(geom) as geom
FROM ${table}
WHERE
  gid = $1`;

    const result = await pg.query(query, [id]);
    return result[0];
  }

  async function getGeoJSON() {
    // prettier-ignore
    const query =
  `SELECT row_to_json(fc)
  from (
      SELECT
          'FeatureCollection' as "type",
          array_to_json(array_agg(f)) as "features"
      FROM (
          SELECT
              'Feature' as "type",
              ST_AsGeoJSON(ST_Transform(geom, 4326), 6) :: json as "geometry",
              (
                  SELECT json_strip_nulls(row_to_json(t))
                  FROM (
                      SELECT
                      gid,
                      location,
                      route,
                      rte_desc,
                      dir_desc
                        ) t
              ) as "properties"
          FROM ${table}
          LIMIT 1000
      ) as f
  ) as fc;
    `;

    const result = await pg.query(query);
    return result[0]["row_to_json"];
  }

  async function list() {
    // prettier-ignore
    const query =
`SELECT
  gid,
  location,
  route,
  rte_desc,
  dir_desc,
  ST_AsText(geom) as geom
FROM ${table}
  `;

    const result = await pg.query(query);
    return result;
  }

  async function update(id, updates) {
    if (typeof id !== "number") {
      throw new Error("id must be a number");
    }

    const params = [id];

    const setStatement = Object.keys(updates)
      .map(column => {
        let updateValue = `'${updates[column]}'`;
        if (column == "geom") {
          updateValue = `ST_GeomFromText('${updates[column]}', 4326)`;
        }
        return `${column} = ${updateValue}`;
      })
      .join(", ");

    console.log("UPDATES\n", setStatement);
    const query = `UPDATE ${table} SET ${setStatement} WHERE gid = $1`;

    const result = await pg.query(query, params);
    return result;
  }
}

module.exports = factory;
