Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA20922 for <linux-archive@neteng.engr.sgi.com>; Wed, 2 Jun 1999 14:34:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA83506
	for linux-list;
	Wed, 2 Jun 1999 14:32:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA55299
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Jun 1999 14:32:52 -0700 (PDT)
	mail_from (rck@corp.home.net)
Received: from poptart.corp.home.net (poptart.svr.home.net [24.0.26.24]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00052
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Jun 1999 14:32:50 -0700 (PDT)
	mail_from (rck@corp.home.net)
Received: from rck-lap (nt-dhcp198.media.home.net [24.0.22.198])
          by poptart.corp.home.net (Netscape Messaging Server 3.54)
           with SMTP id AAA3E75; Wed, 2 Jun 1999 14:32:43 -0700
Message-Id: <4.1.19990602142531.03e112b0@poptart>
X-Sender: rck@poptart
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1 
Date: Wed, 02 Jun 1999 14:32:31 -0700
To: "William J. Earl" <wje@fir.engr.sgi.com>,
        "Robert Keller" <rck@corp.home.net>
From: "Robert Keller" <rck@corp.home.net>
Subject: Re: after the kernel seems to live
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux@cthulhu.engr.sgi.com
In-Reply-To: <199906021756.KAA04212@fir.engr.sgi.com>
References: <4.1.19990602093023.03e1b5d0@poptart>
 <4.1.19990527124423.00930cd0@mail>
 <4.1.19990526115716.03f65930@mail>
 <19990527121840.T866@uni-koblenz.de>
 <19990528004632.B608@uni-koblenz.de>
 <4.1.19990602093023.03e1b5d0@poptart>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

At 10:56 AM 6/2/99 -0700, William J. Earl wrote:
>Robert Keller writes:
> > At 12:46 AM 5/28/99 +0200, Ralf Baechle wrote:
> > >The R5000 is supported and known to work.  You happen to have a
> > >second level cache on that board?
> > 
> > how convinced are people that the VR5000 is supported?  I'm running
> > the latest code off the linux.sgi.com cvs server and I'm getting *very*
> > weird page faulting problems when doing the kernel/user space 
> > hazard shuffle.  Its really hard to describe the problems as they are
> > not deterministic:  sometimes the right thing happens, other times 
> > I get restricted instruction exceptions...  Both of these can happen on
> > the very same kernel binary...
>
>        What sort of system are you using, and what is the hardware 
>configuration (including caches)?  

Its an NEC 5074 development board with an VR5000 --
	32K  I  and 32K  D Primary cache
	no secondary cache.  

which vec0 code should I be using?  

NEC seems to have a bunch of errata and hazards in this part when 
dealing with TLBWR and friends...  Is any of the existing code supposed
to respect these?

Also, arch/mips/Makefile makes the compiler use -r8000 -mips2, is 
that right?

...robert
