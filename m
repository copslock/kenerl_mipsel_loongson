Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA92306 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Nov 1998 04:29:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA95422
	for linux-list;
	Thu, 26 Nov 1998 04:28:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA01664;
	Thu, 26 Nov 1998 04:28:44 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cs7-7.modems.unam.mx [132.248.134.78]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00071; Thu, 26 Nov 1998 04:28:41 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id GAA01602;
	Thu, 26 Nov 1998 06:28:37 -0600
Message-ID: <19981126062837.A1134@uni-koblenz.de>
Date: Thu, 26 Nov 1998 06:28:37 -0600
From: ralf@uni-koblenz.de
To: Ariel Faigon <ariel@oz.engr.sgi.com>,
        Olivier Galibert <galibert@pobox.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: help offered
References: <19981125204900.A4692@loria.fr> <199811252037.MAA37649@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199811252037.MAA37649@oz.engr.sgi.com>; from Ariel Faigon on Wed, Nov 25, 1998 at 12:37:36PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Nov 25, 1998 at 12:37:36PM -0800, Ariel Faigon wrote:

> :Linux 2.1.* is very preemtible, even if there are  stil some things to
> :do.
> 
> Interesting.  Could you elaborate on:
> 
> 	0) What was changed in recent Linux kernels
> 	   to support preemtibility in kernel space?

I think people are confusing the terms reentrant and preemptible.

> 	1) Which "serious" (i.e not 'getpid') system calls are
> 	   now reentrant ?

The large majority of the ``small stuff'' is now reentrant, that means
signals, interrupts, stuff like getpid.  Many subsystems or structures are
nowadays protected by there own locks and no longer by the big evil
lock-everything kernel lock.

> 	2) What still remains to be done so Linux can really
> 	   scale before it gets bottlenecked by kernel locks ?

The big ones which still need a lot of work are

 - VFS and lower layers are protected by the big kernel lock.
 - bottom half handlers run on only one CPU.
 - socket code is protected by the big kernel lock

It's 2.3 work, don't expect it to happen any day soon.  If you're
interested in more details, grep the kernel for lock_kernel / unlock_kernel.

  Ralf
