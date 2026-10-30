# PostgreSQL Environment Setup — Pipeline TEST Run Note

**Date:** 2026-10-30
**Request:** `notebook-requests/PostgreSQL Environment Setup.txt` (DBAS5115 exercise)

## (a) This was a pipeline test run

This output set was produced as a **test of the my-hub notebook-requests pipeline**,
run manually at James's request. It proves the pipeline can take a plain-text request
file and return a generated, *actually executed* notebook plus supporting files —
the same shape a normal pipeline run would produce.

## (b) The provided SQL was missing — a substitute was used

The exercise refers to a provided file, `PostGres_testing.sql`. That file does not
exist in this repository and was not found in the local course materials either.
Because James confirmed this run is a test, it proceeded **without** the original file,
using a clearly-labelled substitute written for the occasion:

- `request_results/PostGres_testing_SUBSTITUTE.sql` — a `DROP TABLE IF EXISTS` at the
  top (the statement the exercise says to skip on the first run), a `CREATE TABLE`,
  five `INSERT`ed records, and a final `SELECT`.

Nothing in the substitute is presented as the instructor's file.

## (c) What the notebook proves

`notebooks/postgresql_environment_setup_test.ipynb` was executed against a **real
PostgreSQL 16.2 server** (a throwaway local instance started only for this test and
shut down afterwards — no system services were touched). Its embedded outputs show:

- a live connection (`SELECT version()` returned the PostgreSQL 16.2 banner);
- the first run skipping the `DROP TABLE` exactly as the exercise instructs, then
  creating the table and inserting the records;
- the resulting table records read back as a DataFrame — 5 rows;
- a second, full run (DROP included) returning the same 5 records, proving the
  script is re-runnable.

## (d) What James still needs for actual course credit

This test run is **not** a course submission. For credit, James still needs:

1. the original `PostGres_testing.sql` from the instructor/course site;
2. his **own** run of it inside his **own GitHub Codespace** (the exercise requires
   the repo to be launched and set up there);
3. his **own** screenshot of the resulting records saved as `successful_setup.bmp`
   in the repository, then a commit and push.

No `successful_setup.bmp` was created here — a screenshot of someone else's run
would not be his work, so none was fabricated.
