Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 11:37:11 +0000 (GMT)
Received: from p508B51DF.dip.t-dialin.net ([IPv6:::ffff:80.139.81.223]:6295
	"EHLO p508B51DF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225558AbSLWLee>; Mon, 23 Dec 2002 11:34:34 +0000
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:43748 "EHLO
	mail.sonytel.be") by ralf.linux-mips.org with ESMTP
	id <S868824AbSLVOCI>; Sun, 22 Dec 2002 15:02:08 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA26135;
	Sun, 22 Dec 2002 14:58:43 +0100 (MET)
Date: Sun, 22 Dec 2002 14:58:48 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: nsauzede <nsauzede@online.fr>
cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: linux-mips fbdev
In-Reply-To: <013b01c2a16c$68385f60$0100a8c0@yak>
Message-ID: <Pine.GSO.4.21.0212221454130.11726-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 12 Dec 2002, nsauzede wrote:
> I've got an Indy running linux-mips and I wonder if fbdev exists/is possible on this platform.
> If I remember well, direct framebuffer mmaping like on intel platforms for example is not possible because Video Ram is hidden behind SGI custom video chips, and video accesses are done by some magic incantations..

Yes, you always have to use the graphics accelerator.

> But the fact is that I can run linux on my box, a gfx penguin logo appears at boot, and I can enjoy a huge beautifull mc on the console, so I guess some "kind" of framebuffer is there, but not the full-blown Geert's-et-al stuff.

:-)

> So my question is : would it be feasible/easy to implement some kind of "stubs" to, at least, simulate a straight framebuffer, with full /dev/fb0 stuff, so I could port my fbdev userspace stuff to my Indy ???

By using the tricks also used in vga256fb (cfr.
http://www.kyuzz.org/antirez/vga256fb.html), you can emulate a normal linear
frame buffer and use the Indy's graphics accelerator to update the screen.
But it will be slow.

An alternative is to use mmap() tricks to find out what's updated in the fake
linear frame buffer, and update the screen afterwards.

Or program the Indy graphics accelerator directly from user space :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
