Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA47308 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Apr 1999 15:49:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA56182
	for linux-list;
	Wed, 14 Apr 1999 15:48:19 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA66395
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Apr 1999 15:48:17 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (pr250.pheasantrun.net [208.140.225.250]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05659
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Apr 1999 15:48:12 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (clepple@sprocket.foo.tho.org [206.223.45.3])
	by foo.tho.org (8.8.7/8.8.7) with ESMTP id SAA11020
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Apr 1999 18:48:10 -0400
Message-ID: <37151B2A.C230B4A4@foo.tho.org>
Date: Wed, 14 Apr 1999 22:48:10 +0000
From: Charles Lepple <clepple@foo.tho.org>
X-Mailer: Mozilla 4.5 [en] (X11; U; Linux 2.0.36 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux/SGI list <linux@cthulhu.engr.sgi.com>
Subject: installation problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

After successfully (though not uneventfully ;-) installing HardHat on an
Indy/r5k, I am now faced with the quandry of installing to another
nearly identical machine. The only difference is that the second
machine's IRIX partitions were blown away when I tried to use fdisk (no,
I didn't finish reading the installation instructions at this point...).

All of the SGI employees out there are probably saying, "Reinstall
IRIX", but (it's a long story) I'd rather do this the Linux way. Any
suggestions? I looked at the prom man page, and I can get the box to
boot the kernel with a 'setenv diskless y' and 'setenv OSLoader
/var/boot/vmlinux' (and then some... I'm not in front of the machine at
the moment). However, with the IRIX dhcp_bootp daemon, I can't seem to
set the suggested nfs root partition, and now that sash is gone, I can't
seem to get command line parameters to work anymore (vmlinux is the
OSLoader, and it's not doing the sash thing), and hence, the kernel
won't boot.

Since I have the other machine up and running, is it possible to 'clone'
the disk with dd? Or will it not catch all of the disk label header
stuff needed to recognize partitions?

Also, on the working machine, is there a better way to boot it than
telling it to 'boot bootp():vmlinux' each time? Again, working with one
disk per machine, IRIX is gone (but I didn't blow sash away on this
one).

If this means that we need some tools to write to the disk headers (ie,
a SGI-aware fdisk, or something to put files into the disk label
directory (similar to the way sash and ide are stored)), I'd be
interested in talking to someone who can get to the information
necessary to do this. (I'm still looking at booting from a CD, but since
most of the working CD-ROM drives are in use, that may wait.)

--
Charles Lepple
System Administrator, Virginia Tech EE Workstation Labs
clepple@ee.vt.edu || http://www.foo.tho.org/charles/
