#!/bin/bash
cd /var/svn
svnadmin create firstrepo
mkdir ~/mainrepo
cd ~/mainrepo
mkdir trunk tags branches
svn import ~/mainrepo file:///var/svn/firstrepo -m 'Adding Initial Directories'

rm -f /var/run/apache2/apache2.pid
apache2 -DFOREGROUND
