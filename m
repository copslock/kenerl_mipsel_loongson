Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA2291026 for <linux-archive@neteng.engr.sgi.com>; Sun, 29 Mar 1998 14:41:23 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA5333483
	for linux-list;
	Sun, 29 Mar 1998 14:40:48 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA5207906
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 29 Mar 1998 14:40:46 -0800 (PST)
Received: from MajorD.xtra.co.nz (terminator.xtra.co.nz [202.27.184.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id OAA28682
	for <linux@cthulhu.engr.sgi.com>; Sun, 29 Mar 1998 14:40:44 -0800 (PST)
	mail_from (ratfink@xtra.co.nz)
Received: from xtra.co.nz (xtra185187.xtra.co.nz [202.27.185.187])
	by MajorD.xtra.co.nz (8.8.8/8.8.6) with ESMTP id KAA18155;
	Mon, 30 Mar 1998 10:40:00 +1200 (NZST)
Message-ID: <351ECDC0.D0E3BC60@xtra.co.nz>
Date: Mon, 30 Mar 1998 10:40:00 +1200
From: Brendan Black <ratfink@xtra.co.nz>
Organization: Acess Denied...
X-Mailer: Mozilla 4.04 [en] (X11; U; Linux 2.0.33 i586)
MIME-Version: 1.0
To: ralf@uni-koblenz.de
CC: Dong Liu <dliu@npiww.com>, linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
References: <199803272025.PAA16215@pluto.npiww.com> <19980327220550.50946@uni-koblenz.de> <199803272159.QAA18195@pluto.npiww.com> <19980328055201.31189@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de wrote:
> 
> On Fri, Mar 27, 1998 at 04:59:26PM -0500, Dong Liu wrote:
> 
> >  > > Another thing it didn't get the right capacity of scsi disk.
> >  >
> >  > Are you shure?  Some peopple got fooled by the 1024 vs. 1024 bytes per
> >  > kb isue ...  Or are the numbers way off?
> >
> > This what I got
> >
> > sda: sector size 0 reported, assume 512
> > SCSI device sda: hdwr sector= 512 bytes, Sectors=1 [0 MB][0.0 GB]
> >
> > :=)
> 
> Hmmm...  I speculate we misstreat R4000MC / R4400MC CPUs :-(
> 
> >  > There is a command named ``hinv'' under IRIX.  Can you mail me the output?
> 
> > FPU: MIPS R4010 Floating Point Chip Revision: 0.0
> > CPU: MIPS R4000 Processor Chip Revision: 3.0
> > Secondary unified instruction/data cache size: 1 Mbyte
> 
> Sigh, was suspecting that.  Actually handling of these CPUs should be
> fixed in current kernels ...
> 
>   Ralf

seeeing I am having exactly the same problem, it might fix me too
-- 
Brendan Black - Network Engineer, Telecom Internet Services
email:	ratfink@xtra.co.nz (personal)	phone: +-649 3555238
	                                mob:   +-6425 2752667
"Waving away a cloud of smoke, I look up, and am blinded by a bright, white
light. It's God. No, not Richard Stallman, or Linus Torvalds, but God. In
a booming voice, He says: "THIS IS A SIGN. USE LINUX, THE FREE UNIX SYSTEM
FOR THE 386." -- Matt Welsh
