Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2008 16:59:01 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:29912 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20270085AbYILP67 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Sep 2008 16:58:59 +0100
Received: from localhost (p8230-ipad401funabasi.chiba.ocn.ne.jp [123.217.242.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5B8C49DF0; Sat, 13 Sep 2008 00:58:53 +0900 (JST)
Date:	Sat, 13 Sep 2008 00:59:04 +0900 (JST)
Message-Id: <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48CA8BEE.1090305@ru.mvista.com>
References: <48C851ED.4090607@ru.mvista.com>
	<20080912.005243.48535230.anemo@mba.ocn.ne.jp>
	<48CA8BEE.1090305@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>   You shouldn't fake the BMDMA interrupt. If it's not there, it's not 
> >>there. Or does this actually happen?
> 
> > IIRC, Yes.
> 
>     Hum, let me think... worth printing a message if this happens.

It might be.  I'll try it.

> >>>+		/*
> >>>+		 * If only one of XFERINT and HOST was asserted, mask
> >>>+		 * this interrupt and wait for an another one.  Note
> 
> >>   This comment somewhat contradicts the code which returns 1 if only 
> >>HOST interupt is asserted if ERR is set.
> 
>     Which is not its business to test. I think you should remove that above 
> check -- if there's INTRQ asserted, then it's asserted. I wonder if BMIDE 
> interrupt bit gets set in that case (suspecting it's not)...

Well, let me explain a bit.  The datasheed say I should wait _both_
XFERINT and HOST interrupt.  So, if only one of them was asserted, I
mask it and wait another one.  But on the error case, only HOST was
asserted and XFERINT was never asserted.  Then I could not exit from
"waiting another one" state, until timeout.

> >>>+			pr_debug("%s: weired interrupt status. "
> >>>  
> 
> >>   Weird.
> 
> > Sure.  But it can happen IIRC...
> 
>     I meant the typo. :-)

Oh, thanks!

> >>>+	__ide_flush_dcache_range((unsigned long)addr, size);
> 
> >>   Why is this needed BTW?
> 
> > Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> > inconsistency on PIO drive.  PIO transfer only writes to cache but
> > upper layers expects the data is in main memory.
> 
>     Hum, then I wonder why it's MIPS specific...

SPARC also have it.  And there were some discussions for ARM IIRC.

> >>>+	.read_sff_dma_status	= tx4939ide_read_sff_dma_status,
> 
> >>   Hum, it should be re-defined in both LE and BE mode (but actually not 
> >>called anyway).
> 
> > What do you mean?  Please elaborate?
> 
>     I mean that in LE mode you're using ide_read_sff_dma_status() but not 
> setting hwif->dma_base, so it won't work. But since it shouldn't be called in 
> this driver's case, this doesn't hurt.

Yes, I see, thanks.

---
Atsushi Nemoto
