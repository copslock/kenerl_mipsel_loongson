Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA18572 for <linux-archive@neteng.engr.sgi.com>; Wed, 2 Jun 1999 15:36:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA27219
	for linux-list;
	Wed, 2 Jun 1999 15:35:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA44852;
	Wed, 2 Jun 1999 15:34:42 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02718; Wed, 2 Jun 1999 15:34:40 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-15.uni-koblenz.de [141.26.131.15])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA26724;
	Thu, 3 Jun 1999 00:34:36 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.8.7) id AAA01358;
	Thu, 3 Jun 1999 00:33:58 +0200
Date: Thu, 3 Jun 1999 00:33:58 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Robert Keller <rck@corp.home.net>
Cc: "William J. Earl" <wje@fir.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: after the kernel seems to live
Message-ID: <19990603003358.B934@uni-koblenz.de>
References: <4.1.19990602093023.03e1b5d0@poptart> <4.1.19990527124423.00930cd0@mail> <4.1.19990526115716.03f65930@mail> <19990527121840.T866@uni-koblenz.de> <19990528004632.B608@uni-koblenz.de> <4.1.19990602093023.03e1b5d0@poptart> <199906021756.KAA04212@fir.engr.sgi.com> <4.1.19990602142531.03e112b0@poptart>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <4.1.19990602142531.03e112b0@poptart>; from Robert Keller on Wed, Jun 02, 1999 at 02:32:31PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 02, 1999 at 02:32:31PM -0700, Robert Keller wrote:

> At 10:56 AM 6/2/99 -0700, William J. Earl wrote:
> >Robert Keller writes:
> > > At 12:46 AM 5/28/99 +0200, Ralf Baechle wrote:
> > > >The R5000 is supported and known to work.  You happen to have a
> > > >second level cache on that board?
> > > 
> > > how convinced are people that the VR5000 is supported?  I'm running
> > > the latest code off the linux.sgi.com cvs server and I'm getting *very*
> > > weird page faulting problems when doing the kernel/user space 
> > > hazard shuffle.  Its really hard to describe the problems as they are
> > > not deterministic:  sometimes the right thing happens, other times 
> > > I get restricted instruction exceptions...  Both of these can happen on
> > > the very same kernel binary...
> >
> >        What sort of system are you using, and what is the hardware 
> >configuration (including caches)?  
> 
> Its an NEC 5074 development board with an VR5000 --
> 	32K  I  and 32K  D Primary cache
> 	no secondary cache.  
> 
> which vec0 code should I be using?  

Like R4k.

> NEC seems to have a bunch of errata and hazards in this part when 
> dealing with TLBWR and friends...  Is any of the existing code supposed
> to respect these?

I don't have the errata at hand but as I remember we deal correctly with
all the cache and TLB errata documented by IDT/QED.  Otherwise for
shure Linux wouldn't run on my R5k Indy.

Is NEC's VR5000 different from the IDT/QED version?

> Also, arch/mips/Makefile makes the compiler use -r8000 -mips2, is 
> that right?

Yes.

  Ralf
