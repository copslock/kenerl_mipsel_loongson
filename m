Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2007 17:10:24 +0100 (BST)
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:32913 "HELO
	smtp121.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20023166AbXFWQJ4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 Jun 2007 17:09:56 +0100
Received: (qmail 94931 invoked from network); 23 Jun 2007 16:09:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=2pttBnj2s/3czFRcw5M0KutAyj3EP1eMxdwwWKRHXHXd/BXHCCicBYHpV0R44M/Al7bDryWGcI//BzDWp884YcHkXB+Wkhr+mTzMKux3eJ9WOy06duYjxYXObtgQr7FG0o72Mk9p70BtJipeu71hMDy5HbZxtrUJv7caNKNUQaM=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.213.6 with plain)
  by smtp121.sbc.mail.sp1.yahoo.com with SMTP; 23 Jun 2007 16:09:49 -0000
X-YMail-OSG: ePBbEKcVM1kCaKzaxlgmWFOo1_mvggWec3UaNlUopZXjnZD1A59Bi1z.zO1Chgt50ZyMzEQ.MQ--
From:	David Brownell <david-b@pacbell.net>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [spi-devel-general] [PATCH] TXx9 SPI controller driver
Date:	Sat, 23 Jun 2007 09:09:51 -0700
User-Agent: KMail/1.9.6
Cc:	spi-devel-general@lists.sourceforge.net, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	mlachwani@mvista.com
References: <20070622.232111.36926005.anemo@mba.ocn.ne.jp> <200706221151.24959.david-b@pacbell.net> <20070624.004159.07644824.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070624.004159.07644824.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706230909.52037.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Saturday 23 June 2007, Atsushi Nemoto wrote:

> Thank you for excellent review!  I'll look at each comments surely
> will update the driver but it may take a few days.

That's fine.

 
> For now, I'm quite sure your patch is OK for me except for one thing:
> 
> > + * spi_tx99.c - TXx9 SPI controller driver.
> 
> Name it spi_txx9.c, please ;)

Sorry, typo!  ... please fix when you resubmit.

 
> And for mmiowb() issue, I put it just only I was not sure whether
> gpio_set_value() guarantee I/O barrier.  Now I see i2c-gpio.c, etc. do
> not have such barriers.  I will remove these barriers and fix platform
> gpio codes.

I don't think this is a case where there'd be a benefit to
allowing non-barriered implementations, and thus requiring
all portable code to include platform-neutral I/O barriers.
I don't know that such neutral primitives actually exist...

I'll update the GPIO docs to make that clear, unless you
have some strong argument to the contrary.

- Dave
