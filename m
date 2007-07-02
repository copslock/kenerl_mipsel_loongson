Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2007 15:01:24 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:15333 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022859AbXGBOBW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Jul 2007 15:01:22 +0100
Received: from localhost (p4019-ipad24funabasi.chiba.ocn.ne.jp [220.104.82.19])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D7507B73C; Mon,  2 Jul 2007 23:00:01 +0900 (JST)
Date:	Mon, 02 Jul 2007 23:00:50 +0900 (JST)
Message-Id: <20070702.230050.59033318.anemo@mba.ocn.ne.jp>
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
X-archive-position: 15595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 30 Jun 2007 09:53:19 -0700, David Brownell <david-b@pacbell.net> wrote:
> > +	txx9spi_cs_func(spi, c, 0, 1000000000 / 2 / spi->max_speed_hz);
> 
> You still use this confusing A/2/B syntax.  Please
> rewrite that using one "/" and one "*".  (And there
> is similar usage elsewhere.)

Replaced with "(NSEC_PER_SEC / 2) / spi->max_speed_hz".

> These checks here should be in txx9_spi_transfer(), where
> returning EINVAL will do some good.  The single caller to
> this routine doesn't even look at its return value ... and
> returning without issuing the message's completion callback
> is just a bug.

Oh it was really a bug.  Fixed.

> That speed check is wrong.  There's no reason two transfers
> shouldn't have different speeds ... e.g. flash chips often
> have speed limits in certain bulk reads, which don't apply
> to other operations.

Done.

> Also, you can't replace per-transfer speed checks with one
> for the overall message... each transfer could have a
> very different speed.

Done.  Now per-transfer speed_hz and bits_per_word are really supported.

> Here's where the (corrected) checks for each spi_transfer in the
> message belong:  if the message is invalid, don't even queue it,
> just return -EINVAL.

Done.

> > +	if (clk_enable(c->clk)) {
> 
> Minor comment:  if power management is a concern, you might
> consider leaving the clock disabled except when transfers
> are active or you're accessing controller registers.  On
> most chips, leaving a clock enabled all the time (like this)
> means power is needlessly consumed.  (This isn't wrong, just
> sub-optimal in terms of power reduction.)

Well, I did not change this since we can not really stop the
"spi-baseclk" anyway.  But thank you for comment.

> > +	master->num_chipselect = 0;	/* unlimited: any GPIO numbers */
> 
> No, actually it means "no chipselects" as I said before;
> the fact that this works right now is a bug that will be
> fixed at some point.  INT_MAX would allow any GPIO.

Done.  I chose "(u16)INT_MAX" to silence a sparse warning.

> ... almost mergeable!

Let's go take3 !

---
Atsushi Nemoto
