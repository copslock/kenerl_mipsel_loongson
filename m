Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2008 17:31:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:50641 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21648605AbYJPQbA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2008 17:31:00 +0100
Received: from localhost (p6178-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.178])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 24382AA77; Fri, 17 Oct 2008 01:30:53 +0900 (JST)
Date:	Fri, 17 Oct 2008 01:31:01 +0900 (JST)
Message-Id: <20081017.013101.128619577.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4939ide driver (v3)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48F7391D.8050109@ru.mvista.com>
References: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>
	<48F7391D.8050109@ru.mvista.com>
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
X-archive-position: 20775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 16 Oct 2008 16:52:45 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
>    Mostly ACK but there's still a few minor nits...

Welcome back!  I will address all of your points except for followings.

> > +			xcount = bcount & 0xffff;
> > +			if (xcount == 0x0000) {
> >   
> 
>    Hm, I'm not sure this is necessary here... although I didn't see an 
> explicit mention that zero count means 64 KB in the datasheet -- which 
> it must mean if the BMIDE spec. was followed).
> In ide-dma.c this check was added because of CS5530's brain damage...

Hmm, if I could test this case easily I will drop this.  Otherwise I
will keep it as is for future investigation.

> > +	if ((dma_stat & 7) == 0 &&
> > +	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
> > +	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
> 
>    Parens around & and | are hardly needed...

You mean more parens are needed?

---
Atsushi Nemoto
