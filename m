Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Sep 2007 16:45:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:46799 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20027274AbXIWPpa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Sep 2007 16:45:30 +0100
Received: from localhost (p7008-ipad309funabasi.chiba.ocn.ne.jp [123.217.201.8])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 425318E86; Mon, 24 Sep 2007 00:45:24 +0900 (JST)
Date:	Mon, 24 Sep 2007 00:47:01 +0900 (JST)
Message-Id: <20070924.004701.108307934.anemo@mba.ocn.ne.jp>
To:	david-b@pacbell.net
Cc:	technoboy85@gmail.com, nico@openwrt.org, linux-mips@linux-mips.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH][MIPS][3/7] AR7: gpio char device
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070922185916.BC8122371A7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200709201800.53887.technoboy85@gmail.com>
	<20070923.014201.75184195.anemo@mba.ocn.ne.jp>
	<20070922185916.BC8122371A7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
X-archive-position: 16641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 22 Sep 2007 11:59:16 -0700, David Brownell <david-b@pacbell.net> wrote:
> > I think there were some discussions about userspace API for GPIO on
> > LKML, but cannot remember the detail.
> >
> > David, give us a comment please?
> 
> It's not yet platform-neutral even given those issues; see below.
> And it's insufficient by itself, which is the main technical point
> I'd raise:  without even udev/mdev hooks, it needs manual setup.
> 
> I don't think anyone has yet *proposed* a platform-neutral userspace
> interface to GPIOs yet.  They all seem to include at least platform
> specific pinmux setup ... which is probably inevitable, but that
> would seem to need abstracting into platform-specific hooks.
> 
> There have been a few folk expressing interest in a userspace GPIO
> interface, and a few system-specific examples.  The most flexible ones
> that come to mind are on Gumstix PXA2xx boards.  One enables GPIO
> IRQs through a gpio-events module; and a /proc/gpio/GPIOnn interface
> monitors all the pins and their configurations (which may mean they
> aren't used for GPIOs at all).  On some AVR32 boards, Atmel had a
> (less capable) configfs interface, mostly used for LED access.

Thank you pointing out those issues.  It seems things are much
complicated than I was thinking of...

> More detailed comments are embedded below.

And these comments help us understanding how to use and implement the
GPIO API.  Thanks!

---
Atsushi Nemoto
