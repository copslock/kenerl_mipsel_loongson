Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA99068 for <linux-archive@neteng.engr.sgi.com>; Fri, 4 Sep 1998 14:27:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA76659
	for linux-list;
	Fri, 4 Sep 1998 14:26:26 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA05085
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 4 Sep 1998 14:26:24 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA09065
	for <linux@cthulhu.engr.sgi.com>; Fri, 4 Sep 1998 14:26:23 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA17799
	for <linux@cthulhu.engr.sgi.com>; Fri, 4 Sep 1998 23:26:20 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA00575;
	Fri, 4 Sep 1998 23:25:28 +0200
Message-ID: <19980904232528.A393@uni-koblenz.de>
Date: Fri, 4 Sep 1998 23:25:28 +0200
From: ralf@uni-koblenz.de
To: Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Bug
References: <Pine.LNX.3.96.980904204616.7535A-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.980904204616.7535A-100000@calypso.saturn>; from Ulf Carlsson on Fri, Sep 04, 1998 at 08:51:47PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Sep 04, 1998 at 08:51:47PM +0200, Ulf Carlsson wrote:

> I think you forgot a break in the middle of a switch statement, setting
> order to 3 is pretty nonsense otherwise.
> I compiled a new kernel with my patch, and I couldn't see any changes. The
> VCED is probably handled correctly by the interrupt anyway.

Thanks, applied.  Note that this bug just resulted in somewhat reduced
performance at cost of 28kb more memory used.  On SC CPUs we use 8
different empty_zero_page pages to avoid VCED errors completly.

  Ralf
