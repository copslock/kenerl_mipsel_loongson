Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA15686 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 May 1999 15:49:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA01274
	for linux-list;
	Thu, 27 May 1999 15:47:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA20640
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 May 1999 15:47:46 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03832
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 May 1999 15:47:44 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-20.uni-koblenz.de [141.26.131.20])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA11471
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 May 1999 00:47:40 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA01190;
	Fri, 28 May 1999 00:46:32 +0200
Date: Fri, 28 May 1999 00:46:32 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Robert Keller <rck@corp.home.net>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: after the kernel seems to live
Message-ID: <19990528004632.B608@uni-koblenz.de>
References: <4.1.19990526115716.03f65930@mail> <4.1.19990526115716.03f65930@mail> <19990527121840.T866@uni-koblenz.de> <4.1.19990527124423.00930cd0@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <4.1.19990527124423.00930cd0@mail>; from Robert Keller on Thu, May 27, 1999 at 01:03:32PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, May 27, 1999 at 01:03:32PM -0700, Robert Keller wrote:

> At 12:18 PM 5/27/99 +0200, Ralf Baechle wrote:
> >What CPU is being used on that eval board?  If it's one that isn't yet
> >supported in our sources then I suspect you have a problem either with the
> >cacheflushing routines themselfes or the calls to them in the network
> >driver.  What NIC are you using, btw?  We've got patches around for a
> >couple of those which are most often being used with MIPS machines.
> 
> Its a VR5000 (D30500S2),  2.2.1 seems to recognize it as a
> type 24 (0x18).  Presently, I'm using a PCI 3c905 despite the
> fact that the eval board has a 21140 (albeit with a completely
> bogus SROM) built in to it.  I have my own patches to 3c59x.c
> tulip.c and even tlan.c to get them working to varying degrees.
> I'd still be interested in comparing my patches with the ones
> you have...

The R5000 is supported and known to work.  You happen to have a
second level cache on that board?

> How can I make sure that I'm not haveing cacheflushing problems?

Debugging :-)

In particular the ring structures are nasty, allocate them as uncached
memory in KSEG1.  In general the rule is that you should try to handle
as much in uncached memory as possible when debugging such problems.
That's of course very bad for performance but it helps.

> I'm presently using declinuxroot-990518.tgz from ftp.linux.sgi.com,
> so should I assume that it should just work?

Yes, it should.

  Ralf
