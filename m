Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 12:31:55 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:38084 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225565AbTIWLbw>; Tue, 23 Sep 2003 12:31:52 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA22790;
	Tue, 23 Sep 2003 13:31:43 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 23 Sep 2003 13:31:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix character loss in drivers/tc/zs.c
In-Reply-To: <20030923084005.GU13578@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030923132357.22133B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 23 Sep 2003, Thiemo Seufer wrote:

> >  Can you please elaborate?  tty is expected to be NULL if info->hook is
> > not, so the code after the change should not differ effectively -- only a
> > useless check is added at the end.  Am I missing anything?
> 
> AFAICS the
> 
>         while ((read_zsreg(info->zs_channel, R0) & Rx_CH_AV) != 0) {
> 
> loops over the FIFO contents and 'return' discards the remaining
> part. The patch made a visible difference for me with some noisy
> debug printk()'s in the kernel.

 Hmm, a coincidence?  Without your patch the execution goes as follows:

receive_chars()
{
	...
	(*info->hook->rx_char)(ch, flag);
	return;
}

And after the change it is as follows:

receive_chars()
{
	...
	(*info->hook->rx_char)(ch, flag);
	if (tty)
		tty_flip_buffer_push(tty);
	return;
}

and tty is NULL.  And I fail to see how it can it make any difference for
printk() output -- the code in question is only ever executed for input
from an LK201-type keyboard.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
