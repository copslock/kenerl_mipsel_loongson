Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA63451 for <linux-archive@neteng.engr.sgi.com>; Sun, 14 Mar 1999 08:35:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA24465
	for linux-list;
	Sun, 14 Mar 1999 08:34:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA18670
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 14 Mar 1999 08:34:35 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA02467
	for <linux@cthulhu.engr.sgi.com>; Sun, 14 Mar 1999 08:34:34 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10MDqR-0027T9C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 14 Mar 1999 17:34:31 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10LnWl-002OmiC; Sat, 13 Mar 99 13:28 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id NAA00827
	for linux@cthulhu.engr.sgi.com; Sat, 13 Mar 1999 13:19:44 +0100
Message-ID: <19990313131944.A809@alpha.franken.de>
Date: Sat, 13 Mar 1999 13:19:44 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: initrd is working and new test image
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

since there are still some people out there, who have problems with
Linux/MIPS on their Indys, I was looking for way to rule out more
setup problems. One way is to get initrd working for Linux/MIPS,
so setting up the nfs root directory won't be necessary anymore.
I hope Puffin will get some time to get us a more decent RedHat
installer.

To build a kernel with an initrd, you need configure initrd into your
kernel, then make boot (right now it works only with ecoff kernels) 
and use arch/mips/boot/addinitrd to combine vmlinux.ecoff with your initrd.

For now, I've built a new kernel with an attached initrd. This initrd
contains a shell (ash) and some utilities (ls, mount, etc.) plus the
needed shared libraries. When you boot this kernel, you should see
the message will "Welcome to Linux/MIPS" and should be dropped into a single 
user shell.

So people with the problem seeing only "Freeing unused kernel memory",
please try it, and report your experiences.

I hope to get the kernel uploaded before monday (depends how crappy the line
to ftp.linux.sgi.com this time is). You can find it

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-initrd-990313.gz

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
