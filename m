Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA24123 for <linux-archive@neteng.engr.sgi.com>; Mon, 19 Oct 1998 17:55:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA60618
	for linux-list;
	Mon, 19 Oct 1998 17:54:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA78990
	for <linux@engr.sgi.com>;
	Mon, 19 Oct 1998 17:54:40 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA03647
	for <linux@engr.sgi.com>; Mon, 19 Oct 1998 17:54:39 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-23.uni-koblenz.de [141.26.249.23])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA04334
	for <linux@engr.sgi.com>; Tue, 20 Oct 1998 02:54:11 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id DAA01921;
	Mon, 19 Oct 1998 03:29:46 +0200
Message-ID: <19981019032946.F1880@uni-koblenz.de>
Date: Mon, 19 Oct 1998 03:29:46 +0200
From: ralf@uni-koblenz.de
To: "Gleb O. Rajko" <rajko@mech.math.msu.su>, linux-mips@fnet.fr
Cc: Vladimir Roganov <roganov@niisi.msk.ru>, linux@cthulhu.engr.sgi.com
Subject: Re: get_mmu_context()
References: <19981015222100.E2079@uni-koblenz.de> <Pine.SV4.3.91.981016185136.876A-100000@mech.math.msu.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.SV4.3.91.981016185136.876A-100000@mech.math.msu.su>; from Gleb O. Rajko on Fri, Oct 16, 1998 at 07:04:48PM +0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Oct 16, 1998 at 07:04:48PM +0400, Gleb O. Rajko wrote:

> We are going to provide support for building generic kernels in the near 
> future if somebody who holds r4k will help us and will try our patches 
> on a r4k box. I think the best time to start is when r3k will be synced 
> with the main branch. Perhaps, Harald may answer when it might occur.

If you are in doubt about any R4k related changes feel free to send them
to me.

> > Which I want to avoid because in worst case that means we'll have to eat
> > a latency of over 1400ns per cache line to fetch from memory.  This number
> > is measured on a R4000SC with 100Mhz.  That is enough to show up right
> > away on the context switch times which now look fairly nice as long as we
> > don't have to swallow cache faults.
> > 
> Perhaps, we may use global vars in most cases and patch code at bootup 
> for critical ones.

Yes.  We can actually do even more in that direction like for example
eleminating calls via pointers as used throughout the mm.  We insert jal
instructions and patch the address as needed.  Or we even overwrite the
call by nops if the routine is emtpy.

> > The MIPS implementation does worse, especially for the R3000 where waste the
> > lowest 6 bits which effectivly truncates our ASID (or PID) to 26 bits.
> > Assuming just 100,000 context switches we'll wrap around after just a bit
> > more than 11 minutes.  I think we can do more than 100,000 context switches
> > per second on a reasonable R3000 system.

> As I understand the only place where change the version is in 
> get_new_mmu_context(). Thus, if the version overflows we may create a new 
> process which will share its address space with other due to the same 
> ASID and varsion pair. Am I right ?  

Correct.

> > Btw, is any of the R3000 machines stable enough to run lmbench?  I'm
> > interested to get results, best the raw result file from
> > lmbench/results/mips-linux/.  Reminds me to run lmbench on my RS3230.

> Ok. I will try to run lmbench while Vladimir will think about your ideas :-)

:-)

Btw, lmbench has in the past helped me to kill several interesting bugs.

  Ralf
