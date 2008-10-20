Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 15:15:23 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:45541 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21920237AbYJTOPQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 15:15:16 +0100
Received: from localhost (p5246-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B6B9DA9C2; Mon, 20 Oct 2008 23:15:11 +0900 (JST)
Date:	Mon, 20 Oct 2008 23:15:24 +0900 (JST)
Message-Id: <20081020.231524.52129378.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4938ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48FB610D.3020901@ru.mvista.com>
References: <20081017.231130.82350696.anemo@mba.ocn.ne.jp>
	<48FB610D.3020901@ru.mvista.com>
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
X-archive-position: 20815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 19 Oct 2008 20:32:13 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	/* IORDY setup time: 35ns */
> > +	wt = (35 + cycle - 1) / cycle;
> 
>     It's not that simple I'm afraid: you can't just wait IORDY for 35 ns as 
> that won't guarantee the minimum DIOx- actime time for the current PIO mode; 
> so t->act8 (since it's >= t->act) should be part of the equation here, 
> possibly with subtraction of couple cycles, if I'm interpreting the timing 
> diagrams in the datasheet correctly...

Hmm... so, does this statement seems correct?

	wt = (t->act8b + 35 + cycle - 1) / cycle - 2;

> > +	/* actual wait-cycle is max(wt & ~1, 1) */
> 
>     I got an impression that WT[0] bit is used otherwise in the ready mode, 
> and PWT[1:0]:WT[3:1] = 00000 would mean 0 cycles, not 1...

From "7.3.6.3  Ready Mode":

	When the number of wait cycles is 0, READY check is started in
	1 cycle after asserting the CE* signal. When the number of
	wait cycles is other than zero, after waiting only for the
	specified number of cycles, READY check is started.

> > +	if (pdata->ioport_shift) {
> > +		hw.io_ports_array[0] = (unsigned long)mmport[0];
> > +#ifdef __BIG_ENDIAN
> > +		mmport[0]++;
> > +		mmport[1]++;
> > +#endif
> > +		for (i = 1; i <= 7; i++)
> > +			hw.io_ports_array[i] = (unsigned long)mmport[0] +
> > +				(i << pdata->ioport_shift);
> > +		hw.io_ports.ctl_addr = (unsigned long)mmport[1];
> > +	} else
> > +		ide_std_init_ports(&hw, (unsigned long)mmport[0],
> > +				   (unsigned long)mmport[1]);
> 
>     From the datasheet I got an impression that this case is not possible...

Yes, but certanly RBTX4938 works without ioport_shift, with a little
help from IOC-FPGA.


I will accept all other points.  Thank you all the time!

---
Atsushi Nemoto
