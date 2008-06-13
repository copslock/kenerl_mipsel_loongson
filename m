Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 14:56:03 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:29649 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20035254AbYFMN4A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 14:56:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5DDtdBO016654;
	Fri, 13 Jun 2008 14:55:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5DDtcF2016641;
	Fri, 13 Jun 2008 14:55:38 +0100
Date:	Fri, 13 Jun 2008 14:55:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	adrian.bunk@movial.fi, chris@mips.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: mips: CONF_CM_DEFAULT build error
Message-ID: <20080613135538.GF703@linux-mips.org>
References: <20080525170718.GD1791@cs181133002.pp.htv.fi> <20080602.012814.35471915.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080602.012814.35471915.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 02, 2008 at 01:28:14AM +0900, Atsushi Nemoto wrote:

> > Commit 351336929ccf222ae38ff0cb7a8dd5fd5c6236a0
> > ([MIPS] Allow setting of the cache attribute at run time.)
> > causes the following build error with pnx8550-jbs_defconfig
> > and pnx8550-stb810_defconfig:
> 
> I wondered why the commit has my S-O-B, and finally found that I had
> fixed a section mismatch caused by the original patch (on queue tree
> on linux-mips.org) and Ralf had folded my fix into the original patch,
> with my S-O-B.  Folding on the queue tree will be good on many case,
> but sometimes a bit confusing. :-)

Yes, I try to merge any follow on patches into the original patch as long
as that one is still sitting in the patch queue.  Since that result in
bugs getting fixes before they ever show up in any of the more static
trees, that is the MIPS or kernel.org git trees there is little point in
documenting bugs "that never existed" and their "non-fixes" ;-)

  Ralf
