Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA45120 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 12:38:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA72484
	for linux-list;
	Wed, 25 Nov 1998 12:37:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA66728;
	Wed, 25 Nov 1998 12:37:37 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id MAA37649; Wed, 25 Nov 1998 12:37:37 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199811252037.MAA37649@oz.engr.sgi.com>
Subject: Re: help offered
To: galibert@pobox.com (Olivier Galibert)
Date: Wed, 25 Nov 1998 12:37:36 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19981125204900.A4692@loria.fr> from "Olivier Galibert" at Nov 25, 98 08:49:00 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:> 	- Guaranteed Real Time response (kernel is preemptible
:> 	  i.e. you can have multiple system calls executing in server
:> 	  space simultaneously.
:
:Linux 2.1.* is very preemtible, even if there are  stil some things to
:do.
:

Interesting.  Could you elaborate on:

	0) What was changed in recent Linux kernels
	   to support preemtibility in kernel space?
	1) Which "serious" (i.e not 'getpid') system calls are
	   now reentrant ?
	2) What still remains to be done so Linux can really
	   scale before it gets bottlenecked by kernel locks ?


:> 	- Bandwidth (I/O networking) e.g. 4 GB/sec write to
:> 	  RAID disks.
:
:Interesting.  Our "local" SGI vendor  (i.e. the one for France),  told
:us that 1GB/sec write  speed was too much  and he could only guarantee
:800MB/sec for our 1TB raid array.
:

I've seen way much higher numbers.  They are not official, and
are not supposed to be used in sales situations, but were obtained
in our labs with XFS and arrays that were designed and tuned to
maximize bandwidth and to prove that XFS is not the bottleneck.
I believe they also used fiberchannel etc.   Anyway, there are
some much greater experts on this subject on this list if they
care to give the details.

:
:> Note that Linux doesn't even support big files (more than 4 GB)
:> on x86, while IRIX supports many terabyte files.
:
:The  limit on  x86 is  2GB.   To  be  fair,  said  terabyte  files and
:filesystems  are  connected  to systems   with  a 64bits architecture.
:Afaik, linux on alpha handles terabytes files.
:
Yes, I know this is not a strictly-Linux limitation, which is why
I was careful to add "on x86".

Please don't get me wrong: I'm not trying to advocate any OS over
the other (I love and use both) and I didn't mean to turn this
into an advocacy thread.  I was just to respond honestly and fairly
to a specific question I was asked.

-- 
Peace, Ariel
