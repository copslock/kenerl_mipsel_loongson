Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR870909608
	for linux-mips-outgoing; Tue, 27 Nov 2001 00:07:00 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAR86uo09605
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 00:06:56 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAR76mt02868;
	Tue, 27 Nov 2001 18:06:48 +1100
Date: Tue, 27 Nov 2001 18:06:48 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: new asm-mips/io.h
Message-ID: <20011127180648.H29424@dea.linux-mips.net>
References: <20011126.123545.41627333.nemoto@toshiba-tops.co.jp> <20011126200946.A8408@dea.linux-mips.net> <20011127.130406.104026562.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127.130406.104026562.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Tue, Nov 27, 2001 at 01:04:06PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 01:04:06PM +0900, Atsushi Nemoto wrote:

> ralf> Aside of that I don't think we'll have any alternative to do
> ralf> something along the lines of your patch.  There are for example
> ralf> systems where the high 8 bits of the I/O or memory address on
> ralf> the ISA bus are supplied in a separate register of the chipset,
> ralf> not as part of the memory address itself.  It's really
> ralf> remarkable how much bad taste some hardware designers have ...
> 
> So, what should we do for these tasteless hardware?

Punish it's developers with fish and chips [1].

> Is there any suggestions? (please don't say "Do not eat" ...)

Not a bad idea in context of fish and chips.

Well, talk to it's developers before it's too late.  Or as it has already
happened for some hardware I think we should simply go with your
suggestion and make all those functions vectors.

  Ralf

[1] Unavoidable part of the Australian experience
