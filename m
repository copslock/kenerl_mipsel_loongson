Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA30532 for <linux-archive@neteng.engr.sgi.com>; Mon, 28 Sep 1998 16:51:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA64173
	for linux-list;
	Mon, 28 Sep 1998 16:50:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA41186
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 28 Sep 1998 16:50:26 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09938
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Sep 1998 16:50:24 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-11.uni-koblenz.de [141.26.249.11])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA04648
	for <linux@cthulhu.engr.sgi.com>; Tue, 29 Sep 1998 01:50:29 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA03275;
	Tue, 29 Sep 1998 01:50:03 +0200
Message-ID: <19980929015003.E2215@uni-koblenz.de>
Date: Tue, 29 Sep 1998 01:50:03 +0200
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: VCEI/VCED handling
References: <19980929011414.43485@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980929011414.43485@alpha.franken.de>; from Thomas Bogendoerfer on Tue, Sep 29, 1998 at 01:14:14AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 29, 1998 at 01:14:14AM +0200, Thomas Bogendoerfer wrote:

> Yesterday I studied the MIPS user's manual to find out, what has to be
> done for the virtual cache coherency exceptions. Before I start to write
> some code, I want make sure, that I got it right.
> 
> VCEI:
> 	Hit Set Virtual on BadVaddr
> 
> VCED: 
> 	Hit Invalidate BadVaddr
> 	TLB Lookup for BadVaddr
> 	Physical Address -> Index
> 	Index Load Tag
> 	Extract PIdx from TagLo
> 	Construct Vaddr from BadVaddr and PIdx
> 	Hit Write Back on created Vaddr
> 	Hit Set Virtual on BadVaddr
> 
> Comments ?

We've got code of which we're shure that it is correct.  Nevertheless
Linux ist still fragile on SC machines.  I've been tracking this in
private emails with Ulf but so far only with limited success.  Aside of
the missing VCED / VCEI handlers there must be something else that is
broken.

  Ralf
