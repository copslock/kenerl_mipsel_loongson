Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA29440 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 09:08:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA09109
	for linux-list;
	Wed, 17 Jun 1998 09:07:24 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA45192
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 09:07:22 -0700 (PDT)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id JAA95977 for linux@engr.sgi.com; Wed, 17 Jun 1998 09:07:22 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199806171607.JAA95977@oz.engr.sgi.com>
Subject: Re: (fwd) linux SEGV details (another one)
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Wed, 17 Jun 1998 09:07:22 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

----- Forwarded message from David Kostal -----

>From kron@informatics.muni.cz  Wed Jun 17 08:59:20 1998
From: David Kostal <kron@informatics.muni.cz>
Message-Id: <199806171559.RAA13325@anxur.fi.muni.cz>
Subject: Re: (fwd) linux SEGV details
In-Reply-To: <199806171543.IAA95711@oz.engr.sgi.com> from Ariel Faigon at "Jun 17, 98 08:43:11 am"
To: ariel@cthulhu
Date: Wed, 17 Jun 1998 17:59:09 +0200 (MET DST)
Cc: linux@cthulhu
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> #mkswap /dev/sdb2
> Segmentation fault
> #
> 
> and on console (there is no syslogd :( ) is:
> 
> #dmesg
> [...skipped...]
> VFS: brelse: Trying to free free buffer
> Unable to handle kernel paging request at virtual address 00050040,
> epc == 88041e7c, ra == 880464e0
> Oops: 0000
> $0 : 00000000 88140000 00000028 00000009
> $4 : 00050028 00000001 bf0f0000 00000000
> $8 : 00000720 00000000 00000000 00000000
> $12: 00000008 000003e2 8836e59c 7ffffcf0
> $16: 00050028 894c7c88 894c7d80 00000001
> $20: 00000000 00000000 894c7c80 00000000
> $24: 00000001 7ffffcf1
> $28: 894c6000 894c7c58 00000000 880464e0
> epc   : 88041e7c
> Status: 3000fc03
> Cause : 00000008
> 
> 
> [and just another attempt to mkswap...]
> VFS: brelse: Trying to free free buffer
> Unable to handle kernel paging request at virtual address 00050040,
> epc == 88041e7c, ra == 880464e0
> Oops: 0000
> $0 : 00000000 88140000 00000028 00000009
> $4 : 00050028 00000001 bf0f0000 00000000
> $8 : 00000720 00000000 00000000 00000000
> $12: 00000008 000003e2 8836e59c 7ffffcf0
> $16: 00050028 894c7c88 894c7d80 00000001
> $20: 00000000 00000000 894c7c80 00000000
> $24: 00000001 7ffffcf1
> $28: 894c6000 894c7c58 00000000 880464e0
> epc   : 88041e7c
> Status: 3000fc03
> Cause : 00000008
> 
> The same with recompiled mkswap.
> 

New report :-)

It looks like mkswap is not able to determine the size of (swap)
partition. If I try to do
#mkswap /dev/sdb2 1024
it works OK. When I try 
#mke2fs /dev/sdb2, 
it works fine too, but 
#dd if=/dev/sdb2 of=/dev/null 
segfaults (and kernel messages are nearly the same as massages from
mkswap).

dd if=/dev/sdb1 of=/dev/null works ok. 

Disc is partitioned from Irix 5.3, /dev/sdb1 is swap, /dev/sdb2 is
ext2 with sgi/linux installed on it. 



I have noticed another problem. Linux happily mounts the same
swap-file twice and if the system needs to swap, kswapd starts to run
at 60% CPU (or more) and the system slows down to death.

david kostal (kron@fi.muni.cz)
----+

----- End of forwarded message from David Kostal -----

-- 
Peace, Ariel
