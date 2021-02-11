#!/bin/bash

firefox  http://127.0.0.1:8082

echo "        
####################################################################
#                                                                  
#    Firefox should now display http://${HOSTNAME}:7777            
#                                                                  
#           hit 'CTRL + C' to stop http server                       
#                                                                  
####################################################################
"

python -m SimpleHTTPServer 8082
