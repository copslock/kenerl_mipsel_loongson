Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 19:17:54 +0100 (BST)
Received: from asia.telenet-ops.be ([195.130.137.74]:22401 "EHLO
	asia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20031228AbXJLSRp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 19:17:45 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by asia.telenet-ops.be (Postfix) with SMTP id 2F0C7D418E;
	Fri, 12 Oct 2007 20:17:45 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by asia.telenet-ops.be (Postfix) with ESMTP id 089A4D4178;
	Fri, 12 Oct 2007 20:17:44 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9CIHiqQ016039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Oct 2007 20:17:44 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l9CIHibn016035;
	Fri, 12 Oct 2007 20:17:44 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 12 Oct 2007 20:17:44 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	kaka <share.kt@gmail.com>
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Unknown symbol register_framebuffer
In-Reply-To: <eea8a9c90710120756j7fb633fdjfc9704c447133a05@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0710122012580.15951@anakin>
References: <eea8a9c90710120551x66311e20pfd639edb9daf68fc@mail.gmail.com>
 <Pine.LNX.4.64.0710121513560.7335@anakin> <eea8a9c90710120756j7fb633fdjfc9704c447133a05@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 12 Oct 2007, kaka wrote:
> Actually we are the writer of the device driver file.
> We don't have any supplier.
> Although we have all the library and .so files.

The kernel does not load .so files.

> But it is not able to find the above mentioned symbols in the kernel table.
> COuld you plz let us know how to link the kernel symbol so that the KLM
> brcmstfb.ko can find the symbols?

Do not use printf(), malloc(), and free() from a kernel module.

Make sure to enable frame buffer support (and load the module if it's
modular).

There's no symbol named brcm_dir_entry in the kernel.

> On 10/12/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, 12 Oct 2007, kaka wrote:
> > > > WHile installing framebuffer driver for BCM chip in MIPS
> > platform(cross
> > > > compiled in intel 86).
> > > > I am getting the following error.
> > > >
> > >
> > > Since it is cross compiled and running on MIPS platform, the linux
> > doesn't
> > > support modinfo command to find the dependencies.
> >
> > Really? I just tried `modinfo' of an ia32 box on a cross-compiled module
> > for a ppc64 box, and it worked fine.
> >
> > > > # insmod brcmstfb.ko
> > > > brcmstfb: Unknown symbol unregister_framebuffer
> > > > brcmstfb: Unknown symbol printf
> > > > brcmstfb: Unknown symbol __make_dp
> > > > brcmstfb: Unknown symbol malloc
> > > > brcmstfb: Unknown symbol framebuffer_alloc
> > > > brcmstfb: Unknown symbol fb_find_mode
> > > > brcmstfb: Unknown symbol fb_dealloc_cmap
> > > > brcmstfb: Unknown symbol brcm_dir_entry
> > > > brcmstfb: Unknown symbol register_framebuffer
> > > > brcmstfb: Unknown symbol fb_alloc_cmap
> > > > brcmstfb: Unknown symbol framebuffer_release
> > > > brcmstfb: Unknown symbol free
> >
> > As mentioned before, please talk to the supplier of your module about
> > these
> > references to `printf', `malloc', and `free'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
