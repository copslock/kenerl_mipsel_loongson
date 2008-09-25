Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 14:16:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:20427 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S29574303AbYIYNQb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 14:16:31 +0100
Received: from localhost (p4221-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.221])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AEE87B926; Thu, 25 Sep 2008 22:16:24 +0900 (JST)
Date:	Thu, 25 Sep 2008 22:16:51 +0900 (JST)
Message-Id: <20080925.221651.106261794.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	bzolnier@gmail.com, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48DA2543.4050304@ru.mvista.com>
References: <48D57245.8060606@ru.mvista.com>
	<20080922.013256.128618380.anemo@mba.ocn.ne.jp>
	<48DA2543.4050304@ru.mvista.com>
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
X-archive-position: 20631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 24 Sep 2008 15:32:19 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>> +	if (pair)
> >>> +		safe = min(safe, ide_get_best_pio_mode(pair, 255, 4));
> >>> +	/*
> >>> +	 * Update Command Transfer Mode for master/slave and Data
> >>> +	 * Transfer Mode for this drive.
> >>> +	 */
> >>> +	mask = is_slave ? 0x07f00700 : 0x070007f0;
> >>> +	val = (safe << 24) | (safe << 8) | (pio << (is_slave ? 20 : 4));
> >>>       
> >>    You are not obliged to set the same command rimings for both drives...
> >
> > I thought I should use "safe" command timings for command transfer
> > mode since taskfile registers should be considered as "shared" for
> 
>    Safe mode is defined as the mode not faster than the slowest drive's 
> fastest mode.
> 
> > both drives.  At least device selection sequence should be done in
> > safe speed, isn't it?
> 
>     But why do you think that the PIO mode being programmed is actually 
> safer for another drive than previous one which might have been slower?

Ah, so do you mean the code should be like this?

	if (pair)
		safe = min(safe, ide_get_best_pio_mode(pair, 255, 4));
	/*
	 * Update Command Transfer Mode and Data Transfer Mode for this drive.
	 */
	mask = is_slave ? 0x07f00000 : 0x000007f0;
	val = ((safe << 8) | (pio << 4)) << (is_slave ? 16 : 0);

> >>> +		/* wait 12GBUSCLK (typ. 60ns @ GBUS200MHz) */
> >>> +		ndelay(400);
> >>>   
> >>    But why wait 400 ns?
> >
> > Well, I should recalculate safe value for possible slowest gbus clock.
> 
>    Hm, that corresponds to 30 MHz and 6.7x that one for 200 MHz. But why 
> 100 ns turns into 1 us then? Well, not that it actually matters much, 
> just for consistency...

Well, while possible slowest gbus clock is 20MHz * 10 * (8 / 6) / 6 =
44MHz (not sure it _really_ work), I will choose 270ns here.

> >>> +		pr_err("%s: Error interrupt %#x (%s%s%s%s )\n",
> >>> +		       hwif->name, stat,
> >>> +		       (stat & TX4939IDE_INT_ADDRERR) ?
> >>> +		       " Address-Error" : "",
> >>> +		       (stat & TX4939IDE_INT_REACHMUL) ?
> >>> +		       " Reach-Multiple" : "",
> >>>       
> >>    This is not an error condition and should only happen in so called 
> >> VDMA mode iff you suspend the transfer, IIUC.
> 
>    I.e. when you're performing PIO transfer with drive but have 
> programmed the controller for DMA transfer -- IIUC, TX4939 supports 
> that. Otherwise these "break" bits don't make sense...
> 
> > So just masking Reach-Multiple interrupt is better?
> 
>    Aren't you masking it already?

Oh yes.   Then... just ignoring INT_REACHMUL is be better?

> >>> +	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
> >>> +		dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_stat);
> >>> +		if (!(dma_stat & 4))
> >>> +			pr_debug("%s: weird interrupt status. "
> >>>       
> >>    This one is worth pr_warning() or even pr_err()...
> >>
> >>> +				 "DMA_stat %#02x int_ctl %#04x\n",
> >>> +				 hwif->name, dma_stat, ctl);
> >>>   
> >>    However,  it's already done in the dma_end() method;.do we need 
> >> really to print 2 messages?
> >
> > Yes, we don't need this usually.  So I used pr_debug() instead of
> > pr_warning().  But I have no strong opinition here.  I'll drop it.
> 
>    I suggest pr_err() or pr_warning() here and dropping it in the 
> dma_end() method.

OK.  I will do.

---
Atsushi Nemoto
