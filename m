Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA46677 for <linux-archive@neteng.engr.sgi.com>; Sat, 1 May 1999 21:06:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA36006
	for linux-list;
	Sat, 1 May 1999 21:03:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA30985
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 May 1999 21:03:08 -0700 (PDT)
	mail_from (jcoffin@sv.usweb.com)
Received: from sv.usweb.com (null-client16.sf.usweb.com [207.138.177.16] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id AAA03982
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 May 1999 00:03:08 -0400 (EDT)
	mail_from (jcoffin@sv.usweb.com)
Received: (qmail 16307 invoked by uid 500); 2 May 1999 04:10:56 -0000
To: tsbogend@alpha.franken.de
CC: linux@cthulhu.engr.sgi.com
Subject: RE: Yet Closer
From: Jeff Coffin <jcoffin@sv.usweb.com>
Date: 01 May 1999 21:10:55 -0700
Message-ID: <m3k8usun5c.fsf@chuck.sv.usweb.com>
X-Mailer: Gnus v5.5/Emacs 20.3
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>  Try the vmlinux-initrd kernel from the test directory. It should drop 
>  you into a single user shell with a ram disk as root. You should be able 
>  to mount your root, and fix what's necessary. 

Almost.  I get to the prompt, but it doesn't appear to respond to
keyboard stimulii.  

[...]
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Welcome to Linux/MIPS
# 


I tried feeding it an assortment of console args too:

/dev/ttyS0
/dev/ttyS1
/dev/tty00
/dev/tty01

Any ideas?


--jeff
