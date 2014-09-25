Helper Scripts
=======

Some small scripts that make my life easier


fvim
=======

search for a filename and open it in vim. If more then one match 
is found, they are shown as a numbered list



```bash
	fvim
	 	Specify a search term
	fvim  test
		No file found, maybe add a * ?
    fvim test*
    	 0: ./damn/long/folder/name/nobody/can/remember/test1.txt
    	 1: test2.txt
    	Number of the file to open or nothing to exit:
    fvim test1.txt
       Only one file found. Opening it

```

checkForUpdate
=========

Reads a list of servers names from `~/.update_server_list, starts a ssh session and
tries to find information about available updates.

**Supported OS:** Ubuntue 12.04, Ubuntu 14.04

```

  ######################################################
  #                 one.domain.name                    #
  #                                                    #
  #                                                    #
  #    >>> New release '14.04.1 LTS' available. <<<    #
  #                                                    #
  ######################################################
  
  ######################################################
  #                 two.domain.name                    #
  #                                                    #
  #    5 packages can be updated.                      #
  #    2 updates are security updates.                 #
  #                                                    #
  ######################################################
  

```



showMismatch
=========

Compare to files and show items that are only part of one

| file1.txt | file2.txt |
| --------- | --------- |
| foo       | bar       |
| foo       | bar       |
| foo       | bar       |
| foobar    | bar       |
|           | foor      |



```
./showMismatch file1.txt file2.txt

elements not part of first file: 
bar
bar
bar
bar
-----------------------------------------------------------
elements not part of second file: 
foobar
```
