Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA08408 for <linux-archive@neteng.engr.sgi.com>; Mon, 20 Jul 1998 10:18:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA20595
	for linux-list;
	Mon, 20 Jul 1998 10:17:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA77913
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 20 Jul 1998 10:17:27 -0700 (PDT)
	mail_from (u120086@acl.lanl.gov)
Received: from acl.lanl.gov (acl.lanl.gov [128.165.147.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA22654
	for <linux@cthulhu.engr.sgi.com>; Mon, 20 Jul 1998 10:17:26 -0700 (PDT)
	mail_from (u120086@acl.lanl.gov)
Received: from localhost (u120086@localhost) by acl.lanl.gov (8.8.8/8.8.5) with SMTP id LAA27176; Mon, 20 Jul 1998 11:16:58 -0600 (MDT)
Date: Mon, 20 Jul 1998 11:16:58 -0600 (MDT)
From: "James V. Hendricks" <u120086@acl.lanl.gov>
Reply-To: "James V. Hendricks" <u120086@acl.lanl.gov>
To: Dan Pinkard <dan@dar.net>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Clue-Gap
In-Reply-To: <Pine.LNX.3.96.980719205718.21761B-100000@morpho.dar.net>
Message-ID: <Pine.SGI.3.96.980720110639.26627A-100000@acl.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

  What is the kernel error message you are getting?  I was having problems
getting a second disk to work as sdb1 -- it seems to give a page fault (or
something like that) and about 10 lines of hex dump with an "Aiyee, Kernel
Panic" or some other funny message like that.  When I only use one of the
drives it works fine.  And I can use /dev/sdb2.
  Once I start getting X up I'll try to figure out my disks problems a
little more...  Right now, running 'X' gives the message
 execve failed for /etc/X11/X (errno 8)
I tried copying over Xsgi from another indy but I got the same error
message.  Any suggestions/any documentation?

On Mon, 20 Jul 1998, Dan Pinkard wrote:

> In either case, once I'm in, it cannot get past the fdisk screen. After
> choosing done on fdisk it immediately dumps the kernel info and I'm left
> with a very unresponsive machine.
> 
> I'm thinking that it is likely due to a poorly partitioned drive... Using
> dsk0d4s1 and dsk0d4s7 as linux partitions I first used the old redhat 5.0
> installer for the irix mke2fs and fscke2fs and remade dsk0d4s7. I
> decided to follow through and let the installer dump the cpio image into
> dsk0d4s7. After several reboots I realized it would get farter running
> boot vlinux.2.1.99 root=/dev/sdc2 than anything else, but it, too, froze,
> asking for some init level. I assume it only needs to be passed as a boot
> param, so I moved on. (The goal was to verify the name of the partition,
> not to boot into the old installer)
