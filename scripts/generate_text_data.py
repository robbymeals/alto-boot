import argparse
import json
import os
import multiprocessing as mp

def worker_init(inpath_in, outpath_in):
    global inpath
    global outpath
    inpath = inpath_in
    outpath = outpath_in
    

def json_to_corpus_text(posting_json_path):
    with open(posting_json_path, "r") as f:
        posting = json.load(f)
    with open("{}/{}".format(outpath, posting["DIMJOBPOSTINGKEY"]), "w") as f:
            f.write(posting["data"]["topo"])


def crawl_dir(dir_to_crawl, n=-1):
    i = 0;
    for dirpath, _, filenames in os.walk(dir_to_crawl):
        for f in filenames:
            i = i + 1
            if i%10000==0:
                logging.info("loaded {} postings".format(i))
            if all([n>0, i==n]):
                raise StopIteration
            yield os.path.abspath(os.path.join(dirpath, f))



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("inpath")
    parser.add_argument("outpath")
    parser.add_argument("--subset", type=int, default=-1)
    args = parser.parse_args()
    with mp.Pool(mp.cpu_count(), worker_init, (args.inpath, args.outpath)) as pool:
        pool.map(json_to_corpus_text, crawl_dir(args.inpath, n=args.subset))


