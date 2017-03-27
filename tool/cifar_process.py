#!/usr/bin/env python

import cPickle
import sys
import os

def dump_filenames(fn, d):
    fh = open(fn+"_filenames", 'w')
    for f in d:
        fh.write("%s\n" % f)
    fh.close()

def dump_labels(fn, d):
    fh = open(fn+"_labels", 'w')
    for f in d:
        fh.write("%i\n" % f)
    fh.close()

def dump_data(fn, d):
    fh = open(fn+"_data", 'w')
    for row in d:
        for i in row:
            fh.write("%i\n" % i)
    fh.close()

if __name__ == "__main__":
    fn = sys.argv[1]
    fh = open(fn, 'rb')
    data = cPickle.load(fh)
    dump_filenames(fn, data['filenames'])
    dump_labels(fn, data['labels'])
    dump_data(fn, data['data'])
    sys.exit(0)
