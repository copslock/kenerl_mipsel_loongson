Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA51348 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 11:52:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA01555
	for linux-list;
	Wed, 25 Nov 1998 11:51:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA44007
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 25 Nov 1998 11:51:17 -0800 (PST)
	mail_from (Olivier.Galibert@loria.fr)
Received: from lorraine.loria.fr (lorraine.loria.fr [152.81.1.17]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA09042
	for <linux@cthulhu.engr.sgi.com>; Wed, 25 Nov 1998 11:51:10 -0800 (PST)
	mail_from (Olivier.Galibert@loria.fr)
Received: from renaissance.loria.fr (renaissance.loria.fr [152.81.4.102])
	by lorraine.loria.fr (8.8.7/8.8.7/8.8.7/JCG) with ESMTP id UAA08883
	for <linux@cthulhu.engr.sgi.com>; Wed, 25 Nov 1998 20:49:00 +0100 (MET)
Received: (from galibert@localhost) by renaissance.loria.fr (8.8.2/8.8.2) id UAA04724; Wed, 25 Nov 1998 20:49:00 +0100 (MET)
Message-ID: <19981125204900.A4692@loria.fr>
Date: Wed, 25 Nov 1998 20:49:00 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: help offered
Mail-Followup-To: linux@cthulhu.engr.sgi.com
References: <365AA647.62A5565D@fra.se> <199811242033.MAA31902@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1i
In-Reply-To: <199811242033.MAA31902@oz.engr.sgi.com>; from Ariel Faigon on Tue, Nov 24, 1998 at 12:33:45PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Nov 24, 1998 at 12:33:45PM -0800, Ariel Faigon wrote:
> 	- Scalability: up to 256 CPUs

I can tell than an O2K with 64 CPUS works quite well when the hardware
isn't failing, but the hardware is often failing...


> 	- Guaranteed Real Time response (kernel is preemptible
> 	  i.e. you can have multiple system calls executing in server
> 	  space simultaneously.

Linux 2.1.* is very preemtible, even if there are  stil some things to
do.


> 	- A real journalling filesystem (XFS). Reboot doesn't
> 	  require a lenghty 'fsck'.  Even if you have a terabyte
> 	  filesystem the filesystem check takes one second or so.

xfs is _very_ good.


> 	- Bandwidth (I/O networking) e.g. 4 GB/sec write to
> 	  RAID disks.

Interesting.  Our "local" SGI vendor  (i.e. the one for France),  told
us that 1GB/sec write  speed was too much  and he could only guarantee
800MB/sec for our 1TB raid array.


> Note that Linux doesn't even support big files (more than 4 GB)
> on x86, while IRIX supports many terabyte files.

The  limit on  x86 is  2GB.   To  be  fair,  said  terabyte  files and
filesystems  are  connected  to systems   with  a 64bits architecture.
Afaik, linux on alpha handles terabytes files.

  OG.
