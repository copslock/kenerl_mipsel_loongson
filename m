Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2IFmiV31847
	for linux-mips-outgoing; Mon, 18 Mar 2002 07:48:44 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2IFmO931844
	for <linux-mips@oss.sgi.com>; Mon, 18 Mar 2002 07:48:25 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA02365;
	Mon, 18 Mar 2002 16:47:14 +0100 (MET)
Date: Mon, 18 Mar 2002 16:47:13 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Johannes Stezenbach <js@convergence.de>
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Toolchain question
In-Reply-To: <20020318154202.GA3092@convergence.de>
Message-ID: <Pine.GSO.4.21.0203181644380.5561-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 18 Mar 2002, Johannes Stezenbach wrote:
> On Sun, Mar 17, 2002 at 09:34:06PM +0100, Jan-Benedict Glaw wrote:
> > Which cross compiler and binutils are currently known to be good for
> > kernel compilation? I'm (for both LE and BE) currently still using
> > this gcc-3.0 snapshot from the simple/crossdev "package". It's a
> > bit old, but working quite good.
> > 
> > What compiler/binutils are currently advisable? Current CVS from
> > binutils, current gcc 3.0 branch from CVS?
> 
> I'm using binutils-2.12.90.0.1 and gcc-2.95.4-debian, which
> was recommended here. Read the the thread on "gcc include strangeness"
> around Feb. 11 for details.

Are you compiling natively, or did you create a cross-compiler using the
gcc-2.95.4-debian sources?

In the latter case, I'm interested in the magic you used to build the
cross-compiler, since I can't seem to build a cross-compiler for any arch using
those sources (2.95.2 was fine).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
