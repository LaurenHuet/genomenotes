import pandas as pd
import logging

# Set up logging
logging.basicConfig(
    filename='blast_summary.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

try:
    # Load BLAST output
    df = pd.read_csv("blast_output.tsv", sep="\t", header=None)

    # Assign expected column names
    df.columns = [
        "qseqid", "staxids", "bitscore", "qseqid2", "sseqid", "pident", "length",
        "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue"
    ]

    # Extract original contig ID from sliding window label
    df["contig"] = df["qseqid"].str.extract(r"^(.*?)(_sliding:.*)?$")[0]

    # Sort by bitscore, keep top 10 per contig
    df_top10 = (
        df.sort_values(["contig", "bitscore"], ascending=[True, False])
          .groupby("contig")
          .head(10)
          .copy()
    )

    # Rewrite qseqid and qseqid2 to match the original contig name
    df_top10["qseqid"] = df_top10["contig"]
    df_top10["qseqid2"] = df_top10["contig"]
    df_top10.drop(columns=["contig"], inplace=True)

    # Save without header (BlobTools2 expects no header)
    output_file = "contig_top10_taxa_full.noheader.tsv"
    df_top10.to_csv(output_file, sep="\t", index=False, header=False)

    logging.info("Top 10 hits per contig saved successfully.")
    print("Done. File saved:", output_file)

except Exception as e:
    logging.exception("Error during processing.")
    print("Error occurred. See blast_summary.log")
