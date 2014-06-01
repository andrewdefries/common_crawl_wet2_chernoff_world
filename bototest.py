import itertools
import json

from boto.s3.connection import S3Connection

aws_auth_filename = 'aws.auth'

def get_aws_creds( aws_auth_filename ):

    with open( aws_auth_filename, 'r' ) as f:
        aws_auth = json.load( f )

    return aws_auth

aws_auth = get_aws_creds( aws_auth_filename )

conn = S3Connection( aws_auth['aws_access_key_id'], aws_auth['aws_secret_access_key'] )
"""
rs = conn.get_all_buckets()
print rs
"""

once_only = 0

bucket_name = 'aws-publicdatasets'

mybucket = conn.get_bucket( bucket_name )

print "Bucket:", mybucket

#print mybucket.list() # use prefix='<desired prefix>'
#print type(mybucket.list())

for key in itertools.islice(mybucket.list("common-crawl/crawl-data/", delimiter="/"),None):
    print key.name

    for subkey_1 in itertools.islice(mybucket.list(key.name, delimiter="/"),None):
        print "\t" + subkey_1.name
        
        for subkey_2 in itertools.islice(mybucket.list(subkey_1.name, delimiter="/"),None):
            print "\t\t" + subkey_2.name
        
            for subkey_3 in itertools.islice(mybucket.list(subkey_2.name, delimiter="/"),None):
                print "\t\t\t" + subkey_3.name
             
                for subkey_4 in itertools.islice(mybucket.list(subkey_3.name, delimiter="/"),None):
                    print "\t\t\t\t" + subkey_4.name
                    if once_only == 0:
                        """ get the first gz """
                        once_only += 1

                        print subkey_4.name
                        print subkey_4.size
                        print subkey_4.get_contents_to_filename( 'testout.gz' )

                        exit()
                    else:
                        pass
