Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA52607 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 12:23:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA86743
	for linux-list;
	Wed, 17 Jun 1998 12:22:52 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA16707;
	Wed, 17 Jun 1998 12:22:49 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id MAA26867; Wed, 17 Jun 1998 12:22:47 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA09696;
	Wed, 17 Jun 1998 21:21:18 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id VAA00670;
	Wed, 17 Jun 1998 21:20:49 +0200
Message-ID: <19980617212049.B410@uni-koblenz.de>
Date: Wed, 17 Jun 1998 21:20:49 +0200
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: (fwd) linux SEGV details (another one)
References: <199806171607.JAA95977@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199806171607.JAA95977@oz.engr.sgi.com>; from Ariel Faigon on Wed, Jun 17, 1998 at 09:07:22AM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 17, 1998 at 09:07:22AM -0700, Ariel Faigon wrote:

> I have noticed another problem. Linux happily mounts the same
> swap-file twice and if the system needs to swap, kswapd starts to run
> at 60% CPU (or more) and the system slows down to death.

On what kernel did this happen?  Some Linux kernels in the 2.1.x series
had this problem in the generic swap code, it's was not a specific
MIPS problem.

  Ralf
