Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA08937 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Mar 1999 08:58:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA96759
	for linux-list;
	Mon, 8 Mar 1999 08:57:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA44743
	for <linux@engr.sgi.com>;
	Mon, 8 Mar 1999 08:57:38 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from gamera.colorado.edu ([128.138.189.223]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA03281
	for <linux@engr.sgi.com>; Mon, 8 Mar 1999 08:57:38 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from localhost by gamera.colorado.edu
	via sendmail with smtp
	id <m10K3LN-001FGFC@gamera.colorado.edu> (Debian Smail3.2.0.102)
	for <linux@engr.sgi.com>; Mon, 8 Mar 1999 09:57:29 -0700 (MST) 
Date: Mon, 8 Mar 1999 09:57:29 -0700 (MST)
From: Jake Griesbach <griesbac@gamera.colorado.edu>
Reply-To: Jake Griesbach <griesbac@gamera.colorado.edu>
To: linux@cthulhu.engr.sgi.com
Subject: Linux/Mips installation
Message-ID: <Pine.LNX.3.96.990308095619.29222A-100000@gamera.colorado.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I'm new to this list, so please forgive me if this has already been
addressed earlier...

I'm trying to install SGI/Linux onto an Indy workstation using the
instructions found at http://www.linux.sgi.com/mips/manhattan.  I've got
the machine so that it net boots the kernel and starts the installation
program.  However, after I select the hard drive I want to install to, I
get the following error:

                                         Oops: 0000
$0 : 00000000 1000fc00 00001000 ffffffe0
$4 : 00000020 00000000 1000fc00 1000fc00
$8 : 00000010 881095c0 00000001 00000068
$12: 00000000 8df81740 8df80000 88139e80
$16: 00000000 00001000 adf49000 8df47800
$20: 8df50e70 bfbc0003 00000000 bfb90000
$24: 00000001 2abe2f30
$28: 8de6a000 8de6bb98 8df50e70 880fa8c4
epc   : 88020f80
Status: 1000fc02
Cause : 00000008
install exited abnormally -- received signal 11
sending termination signals...done
sending kill signals...done
umounting filesystems...
/proc
umount failed /tmp
you may safely reboot your system


This happens directly after I select my target hard drive from the hard
drive list.  It doesn't seem to matter whether or not I try to partition
it with the Edit option on the menu.

Do you have any ideas as to what may be wrong?  I'm using the
hardhat-sgi-5.1.tar.gz file from
ftp://ftp.linux.sgi.com:/pub/linux/mips/RedHat.

Thanks!!

Jake Griesbach
University of Colorado
