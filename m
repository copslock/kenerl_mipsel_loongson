Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 16:46:14 +0200 (CEST)
Received: from mail2.sonytel.be ([195.0.45.172]:5617 "EHLO mail.sonytel.be")
	by linux-mips.org with ESMTP id <S1123926AbSJWOqO>;
	Wed, 23 Oct 2002 16:46:14 +0200
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA19357;
	Wed, 23 Oct 2002 16:46:06 +0200 (MET DST)
Date: Wed, 23 Oct 2002 16:46:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Schulze <joey@infodrom.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [patch] Correct monochrome selection
In-Reply-To: <20021023142839.GG14430@finlandia.infodrom.north.de>
Message-ID: <Pine.GSO.4.21.0210231642200.2882-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 23 Oct 2002, Martin Schulze wrote:
> Geert Uytterhoeven wrote:
> > On Sat, 19 Oct 2002, Martin Schulze wrote:
> > > please apply the patch below which will add proper handling for
> > > monochrome graphic cards.
> > > 
> > > Both changes are required since there are graphic cards out in the
> > > voi^Wwild that are monochrome but have bits_per_pixel set to something
> > > else than 1, e.g. PMAG-AA which uses 8 bits per pixel but ignores 7 of
> > > it.
> > > 
> > > Since currently no such card is supported, this change wasn't
> > > required.  However, we developed support for the PMAG-AA card and we
> > > would like to add support for it to the Linux kernel, of course.
> > 
> > HP300 TopCat uses a similar scheme, and is supported by Linux/m68k.
> 
> *cough*  Is there a working machine running Linux out somewhere?  If
> so, I wonder why this oddity wasn't noted/didn't appear etc.

drivers/video/hpfb.c sets fb_var_screeninfo.bits_per_pixel to 1 instead of 8,
and relies on an unmerged[*] hack to drivers/video/fbcon.c to display the
monochrome penguin logo.

> HP300 is not a really working port iirc.

Yes, it depends a lot on your definition of `working' :-)

Gr{oetje,eeting}s,

						Geert

[*] Available from Linux/m68k CVS http://linux-m68k-cvs.apia.dhs.org/
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
