Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA10035 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Feb 1999 13:36:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA29369
	for linux-list;
	Wed, 10 Feb 1999 13:35:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA24299
	for <linux@engr.sgi.com>;
	Wed, 10 Feb 1999 13:35:09 -0800 (PST)
	mail_from (chipper@llamas.net)
Received: from chipsworld.llamas.net (chipsworld.llamas.net [206.98.157.232]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03704
	for <linux@engr.sgi.com>; Wed, 10 Feb 1999 13:35:07 -0800 (PST)
	mail_from (chipper@llamas.net)
Received: from localhost (chipper@localhost)
	by chipsworld.llamas.net (8.9.1a/8.9.1) with ESMTP id QAA09629;
	Wed, 10 Feb 1999 16:34:30 -0500
Date: Wed, 10 Feb 1999 16:34:30 -0500 (EST)
From: Chris Chiapusio <chipper@llamas.net>
To: linux@cthulhu.engr.sgi.com, Richard Hartensveld <richard@infopact.nl>
Subject: Challange S question..
Message-ID: <Pine.LNX.4.05.9902101630540.769-100000@chipsworld.llamas.net>
X-Files: Resist or serve
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


This is my first time working witha  net booting workstation and i'm
having a problem w/ the install kernel booting on a Challenge S.

I saw the mention in the mail archive and attempted to do as it instructs,
but alas, I have had no success.

the kernel says this on boot:
SGI Zilog8530 serial driver version 1.00
Keyboard timeout
Keyboard timeout
tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
<snip>
VFS: Mounted root (nfs filesystem).
Adv: done running setup()
Freeing unused kernel memory: 44k freed


and freezes there.


now what i've done regarding the instructions on the web site are:
[root@outland dev]# pwd
/usr/src/sgi/installfs/dev
[root@outland dev]# ls -al tty* console*
lrwxrwxrwx   1 root     root            5 Feb 10 16:16 console -> ttyS0
lrwxrwxrwx   1 root     root            5 Feb 10 16:21 tty00 -> ttyS0
lrwxrwxrwx   1 root     root            5 Feb 10 16:21 tty01 -> ttyS1
crw-------   1 root     root       4,   1 May 11  1998 tty1
crw-------   1 root     root       4,   2 May 11  1998 tty2
crw-------   1 root     root       4,   3 May 11  1998 tty3
crw-------   1 root     root       4,   4 May 11  1998 tty4
crw-------   1 root     root       4,   5 May 11  1998 tty5
crw-r--r--   1 root     root       4,  64 Feb 10 16:16 ttyS0
crw-r--r--   1 root     root       4,  65 Feb 10 16:13 ttyS1


Am I doing something obviously wrong?

Chipper

------
                    Please encrypt anything important.
PGP Key: http://pgp.ai.mit.edu:11371/pks/lookup?op=get&search=0x6CFA486D
