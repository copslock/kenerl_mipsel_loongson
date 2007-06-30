Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jun 2007 18:33:32 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:13559 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022081AbXF3Rda (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 30 Jun 2007 18:33:30 +0100
Received: from localhost (p2031-ipad213funabasi.chiba.ocn.ne.jp [124.85.67.31])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A54D4B676; Sun,  1 Jul 2007 02:33:26 +0900 (JST)
Date:	Sun, 01 Jul 2007 02:34:14 +0900 (JST)
Message-Id: <20070701.023414.71085498.anemo@mba.ocn.ne.jp>
To:	david-b@pacbell.net
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH] TXx9 SPI controller driver (take 2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200706300953.20156.david-b@pacbell.net>
References: <20070627.222458.27955527.anemo@mba.ocn.ne.jp>
	<200706300953.20156.david-b@pacbell.net>
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
X-archive-position: 15585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 30 Jun 2007 09:53:19 -0700, David Brownell <david-b@pacbell.net> wrote:
> > This is a driver for SPI controller built into TXx9 MIPS SoCs.
> > This driver is derived from arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c.
> > 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > ---
> > Changes from previous version:
> 
> Better, but still not there yet.

Thanks!  I'll be back with take 3 patch.

> > +	txx9spi_cs_func(spi, c, 0, 1000000000 / 2 / spi->max_speed_hz);
> 
> You still use this confusing A/2/B syntax.  Please
> rewrite that using one "/" and one "*".  (And there
> is similar usage elsewhere.)

The compiler will optimize "1000000000 / 2 / spi->max_speed_hz" into
"500000000 / spi->max_speed_hz", so it can be treat as one "/", no?

---
Atsushi Nemoto
