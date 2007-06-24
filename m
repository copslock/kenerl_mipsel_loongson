Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jun 2007 16:55:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:43472 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021509AbXFXPzX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 24 Jun 2007 16:55:23 +0100
Received: from localhost (p5214-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.214])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E19B7B6D8; Mon, 25 Jun 2007 00:55:17 +0900 (JST)
Date:	Mon, 25 Jun 2007 00:56:00 +0900 (JST)
Message-Id: <20070625.005600.07644920.anemo@mba.ocn.ne.jp>
To:	david-b@pacbell.net
Cc:	spi-devel-general@lists.sourceforge.net, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	mlachwani@mvista.com
Subject: Re: [spi-devel-general] [PATCH] TXx9 SPI controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200706230909.52037.david-b@pacbell.net>
References: <200706221151.24959.david-b@pacbell.net>
	<20070624.004159.07644824.anemo@mba.ocn.ne.jp>
	<200706230909.52037.david-b@pacbell.net>
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
X-archive-position: 15521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 23 Jun 2007 09:09:51 -0700, David Brownell <david-b@pacbell.net> wrote:
> > And for mmiowb() issue, I put it just only I was not sure whether
> > gpio_set_value() guarantee I/O barrier.  Now I see i2c-gpio.c, etc. do
> > not have such barriers.  I will remove these barriers and fix platform
> > gpio codes.
> 
> I don't think this is a case where there'd be a benefit to
> allowing non-barriered implementations, and thus requiring
> all portable code to include platform-neutral I/O barriers.
> I don't know that such neutral primitives actually exist...
> 
> I'll update the GPIO docs to make that clear, unless you
> have some strong argument to the contrary.

No contrary argument.  Some guide to writers of GPIO implementations
about the I/O barriers should be appreciated.

---
Atsushi Nemoto
