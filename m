Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARFJFG19179
	for linux-mips-outgoing; Tue, 27 Nov 2001 07:19:15 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fARFJBo19176
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 07:19:12 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAREJ7J06530;
	Wed, 28 Nov 2001 01:19:07 +1100
Date: Wed, 28 Nov 2001 01:19:07 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: new asm-mips/io.h
Message-ID: <20011128011907.A5508@dea.linux-mips.net>
References: <20011126200946.A8408@dea.linux-mips.net> <20011127.130406.104026562.nemoto@toshiba-tops.co.jp> <20011127180648.H29424@dea.linux-mips.net> <20011127.191022.27957874.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127.191022.27957874.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Tue, Nov 27, 2001 at 07:10:22PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 07:10:22PM +0900, Atsushi Nemoto wrote:

> ralf> Well, talk to it's developers before it's too late.  Or as it
> ralf> has already happened for some hardware I think we should simply
> ralf> go with your suggestion and make all those functions vectors.
> 
> For me, currently it happens only in big endian and I can live happy
> in a little endian world.  I will create new patch when I REALLY need
> it.  Thank you.

Right now the Linux philosophy is that we don't provide any swapping
facility for I/O port accesses.  Some hardware supports byteswapping for I/O
port and memory access, others must do that in software't, so big endian
systems can set CONFIG_SWAP_IO_SPACE to enable swapping for I/O ports and
memory.  In the past there has been quite some confusion about this and
how to use this properly in drivers ...

  Ralf
