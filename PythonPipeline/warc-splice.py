import sys
import re

def pattern_gen():
    """
    Function defines how a pattern is built for re.match
    """
    pattern = ""

    return pattern



def pattern_matcher(pattern):

    for line in sys.stdin:
        if re.match(pattern, line):
            sys.stdout.write(line)
    


pattern = pattern_gen()

pattern_matcher(pattern)


