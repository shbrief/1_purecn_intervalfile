workflow preprocess_bed {
    # inputs
    File inputBED

	call IntervalFile {
	    input:
	        bed = inputBED
	}

    output {
        File PureCN_Interval = IntervalFile.Interval
    }
	
	meta {
		author: "Sehyun Oh"
        email: "shbrief@gmail.com"
        description: "IntervalFile.R of PureCN: Generate an interval file from a BED file containing baits coordinates"
    }
}

task IntervalFile {
	File bed
	File inputFasta
	String BED_pre = basename(bed, ".bed")
	File mappability

	command <<<
		Rscript /usr/local/lib/R/site-library/PureCN/extdata/IntervalFile.R \
		--infile ${bed} \
		--fasta ${inputFasta} \
		--outfile ${BED_pre}_gcgene.txt \
		--mappability ${mappability} \
		--force
	>>>

	runtime {
		docker: "quay.io/shbrief/pcn_docker"
		cpu : 4
		memory: "32 GB"
	}
	
	output {
		File Interval = "${BED_pre}_gcgene.txt"
	}
}