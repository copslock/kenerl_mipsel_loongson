Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 15:14:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57307 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21920228AbYJTOOo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 15:14:44 +0100
Received: from localhost (p5246-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DDA85A401; Mon, 20 Oct 2008 23:14:37 +0900 (JST)
Date:	Mon, 20 Oct 2008 23:14:50 +0900 (JST)
Message-Id: <20081020.231450.51866269.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48FB7D9E.4030803@ru.mvista.com>
References: <20081017.231036.26097587.anemo@mba.ocn.ne.jp>
	<48FB7D9E.4030803@ru.mvista.com>
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
X-archive-position: 20814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 19 Oct 2008 22:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	struct tx4938ide_platform_info pdata = {
> > +		.ioport_shift = shift,
> > +		.gbus_clock = tune ? txx9_gbus_clock : 0,
> 
>     Any reason not to supply the GBUS clock?

The EBUS channel might be used for both ATA and ISA or other local bus
devices.  In that case, the board setup code should initialize best
timings for all devices and the IDE driver should not overrite it.

>     I'm afraid you can't just early return from the set_pio_mode() method...

Do you mean I should use IDE_HFLAG_NO_SET_MODE instead of just
returning from set_pio_mode?

> > +	for (i = 0; i < 8; i++) {
> > +		/* check EBCCRn.ISA, EBCCRn.BSZ, EBCCRn.ME */
> > +		if ((__raw_readq(&tx4938_ebuscptr->cr[i]) & 0x00f00008)
> > +		    == 0x00e00008)
> > +			break;
> > +	}
> > +	if (i == 8)
> > +		return;
> > +	pdata.ebus_ch = i;
> 
>     Why not grab the base address from this register as well and put it into 
> the resource?

Well, ... no reason :-)  I will do that way.  Thank you.
---
Atsushi Nemoto
