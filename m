Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA10507
	for <pstadt@stud.fh-heilbronn.de>; Sat, 2 Oct 1999 00:56:41 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA26527; Fri, 1 Oct 1999 15:52:09 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA25108
	for linux-list;
	Fri, 1 Oct 1999 15:43:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from aryabhatta.engr.sgi.com (aryabhatta.engr.sgi.com [150.166.70.9])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA24643
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 1 Oct 1999 15:43:37 -0700 (PDT)
	mail_from (owner-linux@aryabhatta.engr.sgi.com)
Received: (from singal@localhost) by aryabhatta.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) id PAA06302; Fri, 1 Oct 1999 15:43:36 -0700 (PDT)
Date: Fri, 1 Oct 1999 15:43:36 -0700 (PDT)
From: singal@aryabhatta.engr.sgi.com (Sanjay Singal)
Message-Id: <199910012243.PAA06302@aryabhatta.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

These are the sequence of steps needed to create a new Linux workarea and
get started. I referred to a lot of places to get this together, and
thought it might be a good idea to put this information in one location.
The list of places I looked at are listed in the end in case somebody is
interested.

-Sanjay.

--------------------------------------------------------------------------

a. Install sgibuild: Refer to the following for how to install it and where
	to get it from.

	sgibuild from Baron Roberts:

        Linux sgibuild Home Page:
            http://peanut/cgi-bin/wrap/baron/sgibuild

        sgibuild documentation:
            http://peanut/~baron/sgibuild/doc/sgibuild.html

        The email list linux-sgibuild, archived by thread:
            http://postofc.corp/mailman_archives/linux-sgibuild

        A Multi-Platform Build Architecture:
            http://peanut.engr/build/MultiBuild.html
                                                                                      
b. Install ptools for Linux:

	 To have ptools on Linux, do this
as root (copied from the bonnie:/usr/local/bin/ptools/p_wrapper script):

# How to "install" ptools p_* client commands on your Linux system:
#
#  1) The environment variable $WORKAREA must be set, and
#     point to a valid workarea, with a .workarea file that
#     at least sets the following resources.
#
#     Required Linux .workarea entries:
#
#           workarea.sm_machine : ...   # Irix server host (e.g. bonnie)
#           workarea.sm_location : ...  # Path to top of source tree
#           source_machine.user : ...   # Your Irix server login id
#           source_machine.group : ...  # Your Irix server login group
#           source_machine.local_rcs_directory : /usr/bin

For example, my .workarea file looks like the following:

# .workarea for MediaBase 4.2 Build

workarea.sm_machine :  bonnie.engr.sgi.com
workarea.sm_location : /isms/mediabase/4.2
source_machine.user :  singal
source_machine.group :  engr
source_machine.local_rcs_directory : /usr/bin                                     

#
#     In particular "source_machine.user"  and "source_machine.group"
#     must be specified in the .workarea file.  This is required even
#     if your Linux login id is the same as your Irix id.
#
#     [Well, actually, user can be specified in other ways.  See
#      the real story below, in the help message beginning with:
#           'ptools - Unable to identify user id. ...']
#
#  2) Copy this p_wrapper script to your Linux system, wherever it
#     is convenient to invoke, onetime.  It must be named p_wrapper.
#
#  3) Invoke "p_wrapper -u" as root on your Linux system to
#     install the Linux ptools p_* client commands.
#
#  4) The p_wrapper invocation will perform the following steps:
#
#       - It copies the Irix p_wrapper to your Linux /usr/local/bin.
#       - It unpacks the Irix linux_man.cpio-c.gz man pages to
#         /usr/local/man/man1 on your Linux system.
#       - It creates ~19 hard links in /usr/local/bin on your Linux
#         system, one link for each p_* ptools binary executable
#         client command in /usr/local/bin/ptools on your Irix system,
#         each link a hard link to the copy of p_wrapper in that directory.
#       - It copies about 13 p_* shell scripts from /usr/local/bin/ptools
#         on your Irix system, to /usr/local/bin on your Linux system.
#
#  5) You are now ready to use ptools from your Linux system,
#       subject to the following Requirements and Limitations:
#
#       Linux environment must set WORKAREA to a valid workarea,
#               with a .workarea file containing at least the five
#               resource settings listed above.
#       Your Irix server must have a sufficiently recent version of
#               ptools installed (post April 1999, approximately).
#       Your Irix server must have a "ptclient" login id, that
#               allows password free rcp/rsh from your Linux system.
#       You must be using the (default) rpc transport.  The older
#               ptools transports such as network or nfs_ro don't
#               work -- they will fail with various errors.
#       The p_setup command isn't supported on Linux -- and might
#               never be supported there -- too messy to port.

c. p_tupdate your workarea.

d. You need to set the following environment variables:

WORKAREA - the location of your current workarea
BUILD_ROOT - create a "build" directory under work/linux and
             set BUILD_ROOT to point to this.
DIST_ROOT - create a "dist" directory under work/linux and
            set DIST_ROOT to point to this.

e. To build for linux, you need to follow the following sequence:

	1) do a make in linux/ocs_make_root
	2) do make headers and make exports in linux/informix
	3) do make headers, make exports and make in linux/ocs


---------------------------------------------------------------------------

References:

a. Bill Earl's email: /hosts/forge/var/www/htdocs/linux/bill.txt
