Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA85029 for <linux-archive@neteng.engr.sgi.com>; Sun, 19 Jul 1998 23:23:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA96011
	for linux-list;
	Sun, 19 Jul 1998 23:23:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA68540
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 19 Jul 1998 23:23:08 -0700 (PDT)
	mail_from (dan@dar.net)
Received: from morpho.dar.net (morpho.dar.net [128.252.125.187]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA08255
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 23:23:07 -0700 (PDT)
	mail_from (dan@dar.net)
Received: from morpho.dar.net (dan@morpho.dar.net [128.252.125.187])
	by morpho.dar.net (8.8.7/8.8.7) with SMTP id AAA25049
	for <linux@cthulhu.engr.sgi.com>; Mon, 20 Jul 1998 00:31:12 -0500
Date: Mon, 20 Jul 1998 00:31:11 -0500 (CDT)
From: Dan Pinkard <dan@dar.net>
To: linux@cthulhu.engr.sgi.com
Subject: Clue-Gap
Message-ID: <Pine.LNX.3.96.980719205718.21761B-100000@morpho.dar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Either a lack of indy-clue, irix-clue, or possibly even linux-clue has
made the install process slow goings for me. If you can tell me where I
went wrong, or what I'm missing, I'll thank you. 

I'm booting with 
boot bootp():/tftplinux/vmlinux 

which sucessfully pulls the kernel and boots. The tftpboot directory has
been populated with the hardhat tarball and will actually get me into the
installer. I have also gotten it to work by copying vmlinux to the root
irix partition and booting from dhcp in the kernel. It needs nfsroot= but
works fine.

In either case, once I'm in, it cannot get past the fdisk screen. After
choosing done on fdisk it immediately dumps the kernel info and I'm left
with a very unresponsive machine.

I'm thinking that it is likely due to a poorly partitioned drive... Using
dsk0d4s1 and dsk0d4s7 as linux partitions I first used the old redhat 5.0
installer for the irix mke2fs and fscke2fs and remade dsk0d4s7. I
decided to follow through and let the installer dump the cpio image into
dsk0d4s7. After several reboots I realized it would get farter running
boot vlinux.2.1.99 root=/dev/sdc2 than anything else, but it, too, froze,
asking for some init level. I assume it only needs to be passed as a boot
param, so I moved on. (The goal was to verify the name of the partition,
not to boot into the old installer)

Again, the hardhat installer did not make it past the fdisk screen. 

Next I rebooted and used the hardhat installer to refdisk it all myself.
Quite nice.. worked fine, but it didn't make it beyond the fdisk screen.

At any rate, What can I salvage of this situation? Where did I most likely
go wrong, and what can I/we do to better answer this question for next
time?

Thanks... d.p.
