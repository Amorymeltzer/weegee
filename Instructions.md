md5deep -r "folder1" | sort > deep.txt

Step 1: ./makeMatchList.pl
Result: matchList.txt (hashes then full link, removes .DS_stores)

Step 2: ./deleteList.pl
Result: Discern which file(s) to delete

Step 3: Go through ManualCheck.txt FIRST!  Repeat Steps 1 and 2 when done.

Step 4: ./move.pl
Result: Files in dupes.txt moved to trash

Step 5: ./orgFiles.pl <directory/with/only/image/files>
Result: Files moved to appropriately named directs
