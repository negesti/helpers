#!/bin/bash

firefox  http://localhost:7777

echo "        
####################################################################
#                                                                  
#    Firefox should now display http://${HOSTNAME}:7777            
#                                                                  
#           hit 'CTRL + C' to stop http server                       
#                                                                  
####################################################################
"

python -m SimpleHTTPServer 7777
