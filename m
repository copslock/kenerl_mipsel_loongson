Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQA9x913948
	for linux-mips-outgoing; Mon, 26 Nov 2001 02:09:59 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAQA9uo13944
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 02:09:56 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAQ99km09913;
	Mon, 26 Nov 2001 20:09:46 +1100
Date: Mon, 26 Nov 2001 20:09:46 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: new asm-mips/io.h
Message-ID: <20011126200946.A8408@dea.linux-mips.net>
References: <20011126.123545.41627333.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011126.123545.41627333.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Mon, Nov 26, 2001 at 12:35:45PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 26, 2001 at 12:35:45PM +0900, Atsushi Nemoto wrote:

> A last cleanups for io.h looks bit wrong.  Please apply.

Yes, the byteswapping stuff (CONFIG_SWAP_IO_SPACE) also got lost.

> By the way, I have some boards which require special I/O routines.
> Some of these boards need byteswap on PCI I/O region but noswap on ISA
> region.  And some of these boards do not require byteswap but need
> swap the address ('port' values).  I added following codes to support
> these boards.  Is it worth to apply?

Not as is - the kernel has changed, so your patch wouldn't apply anymore.
Aside of that I don't think we'll have any alternative to do something
along the lines of your patch.  There are for example systems where the
high 8 bits of the I/O or memory address on the ISA bus are supplied in
a separate register of the chipset, not as part of the memory address
itself.  It's really remarkable how much bad taste some hardware designers
have ...

  Ralf
