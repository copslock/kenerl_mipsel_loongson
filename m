Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g168obA12581
	for linux-mips-outgoing; Wed, 6 Feb 2002 00:50:37 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g168oVA12572
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 00:50:31 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA03368;
	Wed, 6 Feb 2002 09:49:23 +0100 (MET)
Date: Wed, 6 Feb 2002 09:49:24 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: sjhill@cotw.com, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
In-Reply-To: <02a001c1ae90$43748d40$5601010a@prefect>
Message-ID: <Pine.GSO.4.21.0202060948190.20126-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 5 Feb 2002, Bradley D. LaRonde wrote:
> As already mentioned, a MIPS TLB entry typically can point with 36 bits
> (that's 67TB of address space?) at physical memory.  If you have more than

At bit less: 64 GiB or approx. 69 GB :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
