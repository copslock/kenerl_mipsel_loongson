Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id NAA01827
	for <pstadt@stud.fh-heilbronn.de>; Thu, 1 Jul 1999 13:27:48 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00879; Thu, 1 Jul 1999 04:26:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA28862
	for linux-list;
	Thu, 1 Jul 1999 04:23:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA95451;
	Thu, 1 Jul 1999 04:22:54 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA07271; Thu, 1 Jul 1999 04:22:52 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port44.koeln.ivm.de [195.247.239.44])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id NAA18047;
	Thu, 1 Jul 1999 13:22:43 +0200
X-To: linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.990701132545.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <199907010053.RAA00061@fir.engr.sgi.com>
Date: Thu, 01 Jul 1999 13:25:45 +0200 (MEST)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Subject: Re: Memory corruption
Cc: linux@cthulhu.engr.sgi.com, Ulf Carlsson <ulfc@thepuffingroup.com>,
        Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 8bit


On 01-Jul-99 William J. Earl wrote:
> Ralf Baechle writes:
[...]
>  > Actually we're pretty generous with our cacheflushed, we flush more than we
>  > should.
> 
>      Yes, but it is not clear that all paths are covered.
> 
>  > > Also, the flush_page_to_ram() slows down processing on
>  > > machines which physical cache tags, for cases where the virtual
>  > > index used by the kernel and the virtual index used by the application
>  > > are the same.  It should have an extra argument of the intended user virtual
>  > > address, so that it can decide whether to flush or not on architectures
>  > > such as MIPS.
>  > 
>  > For R3000 and R6000 flush_page_to_ram() is a no-op, see arch/mips/mm/r2300.c
>  > and arch/mips/mm/r6000.c.
> 
>     Yes, since those have write-through caches.  The icache
> invalidation is still an issue, if there are any paths, such as
> try_to_swap_out(), which break a virtual-to-physical mapping without
> flushing the icache.

A good point. That seems to be exactly the problem R3k DECstations have. Processes
are dying with SIGABRT SIGBUS or SIGSEGV shortly after swapping occurs. Trying to
hunt that down I removed all optimisations from the cacheflushing routines and 
replaced them with flush_cache_all() but that didn't help.

---
Regards,
Harald
