Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA53349 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Feb 1999 16:11:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA41890
	for linux-list;
	Tue, 16 Feb 1999 16:10:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA47227
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Feb 1999 16:10:41 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA06904
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Feb 1999 16:10:39 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-14.uni-koblenz.de [141.26.131.14])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA21019
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Feb 1999 01:10:37 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA25383;
	Wed, 17 Feb 1999 00:49:53 +0100
Message-ID: <19990217004953.Q644@uni-koblenz.de>
Date: Wed, 17 Feb 1999 00:49:53 +0100
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Eric Melville <m_thrope@rigelfore.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: problem booting sgi linux
References: <36C76479.62B097D2@rigelfore.com> <19990215013527.B2910@alpha.franken.de> <36C966DA.C7F506BA@rigelfore.com> <19990216202555.A1673@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990216202555.A1673@alpha.franken.de>; from Thomas Bogendoerfer on Tue, Feb 16, 1999 at 08:25:55PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Feb 16, 1999 at 08:25:55PM +0100, Thomas Bogendoerfer wrote:

> On Tue, Feb 16, 1999 at 04:38:50AM -0800, Eric Melville wrote:
> > CPU: MIPS R4400 Processor Chip Revision: 6.0
> [..]
> > any ideas as to why every kernel i've tried hangs when it tries to free
> > unused kernel memory? thanks...
> 
> looks like we have still a problem with R4400. Ralf ?

Nope, no known problem, but we definately have a problem with the R4700.
Fixed.  Not that Indys would use a R4700 ...

I'll have to get V6.0 erratas, maybe that'll explain something.

  Ralf
