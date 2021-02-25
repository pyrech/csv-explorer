# CSV explorer

You need to browse a big CSV but Office/OpenOffice/LibreOffice does not accept to load a CSV of 100+ MB?
Use this tool to load the CSV into a MySQL database and explore the data with PHPMyAdmin.

## Load the data

Put your CSV file into the [files/](files/) directory

```bash
mv myleak.csv files/myleak.csv
```

Start MySQL database and PHPMyAdmin:

```bash
docker-compose up -d 
```

Load the data into the database:

```bash
docker-compose run mysql bash -c "./loaddata.sh files/myleak.csv"
```

>Note: This step can take up to one min for a CSV of 400 MB

## Explore the data

You can open [127.0.0.1:8080/](http://127.0.0.1:8080/) in your browser to access PHPMyAdmin.
Defaut credentials are `root` / `yolo`.
You can now browse your data by querying the `explorer.data` table.

If you prefer to explore over CLI, you can run the following command instead to open a MySQL shell:

```bash
docker-compose run mysql mysql -h mysql -u root -pyolo explorer
```

```sql
SELECT * FROM data WHERE ...
```

## Remove everything

Finish to explore the data? You can delete everything by running the following command:

```bash
docker-compose down --remove-orphans --volumes --rmi=local
```
