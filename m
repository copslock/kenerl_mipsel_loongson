Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA60974 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Aug 1998 15:22:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA32619
	for linux-list;
	Fri, 28 Aug 1998 15:20:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA61617
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Aug 1998 15:19:16 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA10845
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Aug 1998 15:19:15 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-12.uni-koblenz.de [141.26.249.12])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA06280
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Aug 1998 00:19:00 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id MAA05167;
	Fri, 28 Aug 1998 12:31:55 +0200
Message-ID: <19980828123154.B358@uni-koblenz.de>
Date: Fri, 28 Aug 1998 12:31:54 +0200
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: Emacs problem
References: <19980823223647.12724@alpha.franken.de> <19980824121930.00186@uni-koblenz.de> <19980825225603.43888@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980825225603.43888@alpha.franken.de>; from Thomas Bogendoerfer on Tue, Aug 25, 1998 at 10:56:03PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Aug 25, 1998 at 10:56:03PM +0200, Thomas Bogendoerfer wrote:

> Another questione does gcc/egcs produce .sdata, .lit4 or .li8 sections
> on Linux/MIPS ?

These sections are mostly being used for code using global pointer
optimization.  .lit8 is also being used for fp code when assembling li.d
macros.

For kernel code global pointer optimization is incompatible
with our current use of $gp as the current pointer; in userland gp
optimization is incompatible with PIC code.

  Ralf
