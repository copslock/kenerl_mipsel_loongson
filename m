Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9I5tu117769
	for linux-mips-outgoing; Wed, 17 Oct 2001 22:55:56 -0700
Received: from mail.sonytel.be (main.sonytel.be [195.0.45.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9I5toD17765
	for <linux-mips@oss.sgi.com>; Wed, 17 Oct 2001 22:55:50 -0700
Received: from mullein.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id HAA26208;
	Thu, 18 Oct 2001 07:54:34 +0200 (MET DST)
Date: Thu, 18 Oct 2001 07:54:18 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
cc: raiko@niisi.msk.ru, hli@quicklogic.com,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: IDE DMA mode in Big endian for mips
In-Reply-To: <20011018.111843.41626947.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.4.21.0110180752320.9667-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 18 Oct 2001, Atsushi Nemoto wrote:
> >>>>> On Wed, 17 Oct 2001 20:43:58 +0900 (JST), Atsushi Nemoto <nemoto@toshiba-tops.co.jp> said:
> nemoto> Yes, I depend on hardware swapping on word/dword access.  It
> nemoto> seems many pci drivers depend on this swapping too.
> 
> Sorry, last sentence might be wrong.  I doubt I have been
> misunderstanding long time...
> 
> Can anybody explain me a PCI driver's policy of endianness?  Should we
> use cpu_to_le32 with outl/writel?  Should we use cpu_to_le32 to write
> 32bit data to DMA area?

The PCI bus is little-endian.
All accesses should be done using one of
  - {read,write}[bwlq]: PCI memory space
  - {in,out}[bwl]: PCI (and ISA) I/O space
  - isa_{read,write}[bwl]: ISA memory space

The functions above should take care of endian conversion.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
