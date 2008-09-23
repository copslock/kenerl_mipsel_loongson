Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 18:04:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:56561 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28596041AbYIWREl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2008 18:04:41 +0100
Received: from localhost (p8175-ipad207funabasi.chiba.ocn.ne.jp [222.145.90.175])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1304BA47B; Wed, 24 Sep 2008 02:04:35 +0900 (JST)
Date:	Wed, 24 Sep 2008 02:04:59 +0900 (JST)
Message-Id: <20080924.020459.128619366.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	bzolnier@gmail.com, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48D57245.8060606@ru.mvista.com>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
	<48D57245.8060606@ru.mvista.com>
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
X-archive-position: 20603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 21 Sep 2008 01:59:33 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +static int tx4939ide_dma_test_irq(ide_drive_t *drive)
> > +{
> > +	ide_hwif_t *hwif = HWIF(drive);
> > +	void __iomem *base = TX4939IDE_BASE(hwif);
> > +	u16 ctl = tx4939ide_readw(base, TX4939IDE_int_ctl);
> > +	u8 dma_stat, stat;
> > +	u16 ide_int;
> > +	int found = 0;
> > +
> > +	tx4939ide_check_error_ints(hwif, ctl);
> > +	ide_int = ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST);
> 
>    Well, since you're effectively ignoring the BUSERR interrupt, there's 
> no point in enabling it...

The BUSERR is not ignored.  tx4939ide_check_error_ints() will print a
message.  It would be better than just ignoring.

---
Atsushi Nemoto
