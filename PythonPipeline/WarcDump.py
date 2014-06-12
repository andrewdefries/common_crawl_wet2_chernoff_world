#!/usr/bin/env python
"""warcdump - dump warcs in a slightly more humane format"""

from __future__ import print_function

import os
import sys

import os.path
import warc
import csv

parser = OptionParser(usage="%prog [options] warc warc warc")

def write_csv(in_name=None, out_name="warc_header.csv"):
    ret = False
    with open(out_name, 'wb') as csvfile:
        result = []
        spamwriter = csv.writer(csvfile, delimiter=' ',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)
        with warc.open(in_name, 'rU') as f: 
            for record in f:
               url = record['WARC-Target-URI']
               rec_id = record['WARC-Record-ID']
               warc_date = record['WARC-Date']
               ip = record['WARC-IP-Address']
               spamwriter.writerow([url, rec_id, ip, warc_date])
        spamwriter.close()
    return True


if __name__ == '__main__':  
    (options, input_files) = parser.parse_args(args=argv[1:])
    write_csv(input_files=None, out_name="warc_header.csv")
