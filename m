Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA02000
	for <pstadt@stud.fh-heilbronn.de>; Thu, 8 Jul 1999 23:53:53 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05709; Thu, 8 Jul 1999 14:50:51 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA41637
	for linux-list;
	Thu, 8 Jul 1999 14:47:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA36728;
	Thu, 8 Jul 1999 14:47:12 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05071; Thu, 8 Jul 1999 14:47:06 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-3.uni-koblenz.de [141.26.131.3])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA06588;
	Thu, 8 Jul 1999 23:46:58 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id MAA04105;
	Thu, 8 Jul 1999 12:39:15 +0200
Date: Thu, 8 Jul 1999 12:39:14 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc: linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, Ulf Carlsson <ulfc@thepuffingroup.com>,
        "William J. Earl" <wje@fir.engr.sgi.com>
Subject: Re: Memory corruption
Message-ID: <19990708123914.E4012@uni-koblenz.de>
References: <19990706150549.A28849@uni-koblenz.de> <XFMail.990707230857.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <XFMail.990707230857.Harald.Koerfgen@home.ivm.de>; from Harald Koerfgen on Wed, Jul 07, 1999 at 11:08:57PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jul 07, 1999 at 11:08:57PM +0200, Harald Koerfgen wrote:

> On 06-Jul-99 Ralf Baechle wrote:
> > I've received a report from some person who is working on his own R3081
> > port.  He also observes data corruption and suspects reading of swapped
> > pages is causing that.
> 
> That's definitely true for R3k DECstations, and no, flushing the icache in
> flush_tlb_page() does not help. I have added cacheflushing to all tlb routines,
> copy_page and even rw_swap_page_base() and swap_after_unlock_page() without
> success.

Note that on R3000 with it's physical indexed caches there is no way that
cache problems should be able to crash the whole system.  At least under the
provision that DMA drivers get their cacheflushing right.

I recently tried to put our memcpy / memmove from the kernel into libc
and as result ended up with a libc which was almost unusable.  Also, a
part of memove is disabled by #if 0, it was demonstrated to cause data
corruption.  Time to fix that bastard.  The whole file is a big mess, btw.
because the code tries to share as much code as possible between memcpy,
memmove and __copy_{to,from}_user.  So put on your peril sensitive
glasses ;-)

> P.S.: I'll be on vacation until July 18th so this has twait a little bit :-)

s/.*/P.S.: I have plenty of time for hacking during my vacation :-)/p ;-)

  Ralf
