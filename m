Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA87699 for <linux-archive@neteng.engr.sgi.com>; Wed, 2 Sep 1998 07:30:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA48254
	for linux-list;
	Wed, 2 Sep 1998 07:29:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA61122
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Sep 1998 07:29:47 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-13.uni-koblenz.de [141.26.249.13]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA05560
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Sep 1998 07:29:45 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA00976;
	Wed, 2 Sep 1998 00:08:41 +0200
Message-ID: <19980902000840.C370@uni-koblenz.de>
Date: Wed, 2 Sep 1998 00:08:40 +0200
To: Ulf Carlsson <grim@zigzegv.ml.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: cdrom
References: <19980901165505.A456@uni-koblenz.de> <Pine.LNX.3.96.980901193416.17758A-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.980901193416.17758A-100000@calypso.saturn>; from Ulf Carlsson on Tue, Sep 01, 1998 at 07:50:46PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 01, 1998 at 07:50:46PM +0200, Ulf Carlsson wrote:

> I tried to implement your ideas, I disabled sync, I don't know how you
> disable disconnect/reconnect. Anyway, I don't think that's the problem.
> The problem is the sigsegv in mount the oops causes, do we have something
> like a 'half' mounted device?

The mount operation is assumed to be atomic.  If it's not you're in deep
trouble.

> Unable to handle kernel paging request at virtual address 00000000, epc ==
> 88021bcc, ra == 8809414
> Oops: 0000
> ...
> epc   : 88021bcc
> Status: 3004fc02
> Cause : 00000008
> Segmentation fault
> 
> I get those other messages ...

As I recently told you on IRC - the patch as you've posted it is not
correct.  It will misstreat VCEI exceptions.

> scsi: aborting command due to timeout ...
> 
> ...  when I try to access the directory where I mounted the CDROM drive.
> Do you think my SC hack is causing this mess?

Not the timeouts, they're a genuine wd driver bug.

  Ralf
