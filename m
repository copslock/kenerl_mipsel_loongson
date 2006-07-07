Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 19:58:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:60076 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S3466458AbWGGS6u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2006 19:58:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k67IMjek028773;
	Fri, 7 Jul 2006 19:22:45 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k67IMiQe028772;
	Fri, 7 Jul 2006 19:22:44 +0100
Date:	Fri, 7 Jul 2006 19:22:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
Message-ID: <20060707182244.GA28118@linux-mips.org>
References: <20060708.000032.88471510.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl> <20060708.011245.82794581.anemo@mba.ocn.ne.jp> <20060708.014339.89274844.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708.014339.89274844.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 08, 2006 at 01:43:39AM +0900, Atsushi Nemoto wrote:

> > >  For a VIVT I-cache this can result in a TLB exception.  TLB handlers are 
> > > not currently prepared for being called at the exception level.
> > 
> > Thanks, now I understand the problem.  Are there any good solutions?
> > Only I can think now is using handle_ri_slow for such CPUs.
> 
> Can we use Index_Load_Data_I to load the instruction code from icache?
> Just an idea...

In addition to what Maciej said - the format of instructions in the I-cache
is not necessarily the same as in memory.  Many processor store pre-decoded
instructions in the I-cache.

  Ralf
