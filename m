Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA99120 for <linux-archive@neteng.engr.sgi.com>; Wed, 4 Nov 1998 16:20:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA21149
	for linux-list;
	Wed, 4 Nov 1998 16:21:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA15971
	for <linux@engr.sgi.com>;
	Wed, 4 Nov 1998 16:20:58 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA07316
	for <linux@engr.sgi.com>; Wed, 4 Nov 1998 16:20:49 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-26.uni-koblenz.de [141.26.249.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA11597
	for <linux@engr.sgi.com>; Thu, 5 Nov 1998 01:20:46 +0100 (MET)
Message-ID: <19981027170306.E358@uni-koblenz.de>
Date: Wed, 4 Nov 1998 17:03:06 +0100
From: ralf@uni-koblenz.de
To: Warner Losh <imp@village.org>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: MIPS R3230?
References: <199810270544.WAA14203@harmony.village.org> <36350DB4.3CC01730@xmission.com> <199810262335.QAA12729@harmony.village.org> <199810270544.WAA14203@harmony.village.org> <199810270548.WAA14350@harmony.village.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199810270548.WAA14350@harmony.village.org>; from Warner Losh on Mon, Oct 26, 1998 at 10:48:10PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Oct 26, 1998 at 10:48:10PM -0700, Warner Losh wrote:

> I do have one specific question that doesn't appear to be in the
> hardware reference.  Can someone help me on where to find the entry
> points to the MIPS ROM/firmware?  I've not been able to find a vector
> table or anything like that in my hunting trought the hardware
> reference manual.

Checkout the arch/mips/mips/ directory in the CVS.  Long time ago there
were files in that directory which were generating PROM stubs, all
based on information from /usr/include/ of RISC/os 5.00.  Since nothing
was using these stubs for a long time I deleted them, you'll have to
rescue them from Attic/.

  Ralf
