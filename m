Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Oct 2004 12:14:36 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:37567 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225262AbUJMLOc>;
	Wed, 13 Oct 2004 12:14:32 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i9DBEMMp023323;
	Wed, 13 Oct 2004 13:14:22 +0200 (MEST)
Date: Wed, 13 Oct 2004 13:14:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Bjoern Riemer <riemer@fokus.fraunhofer.de>,
	ppopov@embeddedalley.com,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: meshcube patch for au1000 network driver
In-Reply-To: <20041013110947.GA6992@linux-mips.org>
Message-ID: <Pine.GSO.4.61.0410131314040.2571@waterleaf.sonytel.be>
References: <416BC4D9.2060904@fokus.fraunhofer.de> <20041013110947.GA6992@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 13 Oct 2004, Ralf Baechle wrote:
> On Tue, Oct 12, 2004 at 01:49:45PM +0200, Bjoern Riemer wrote:
> > i fixed the ioctl support in the net driver to support link detection by
> >   ifplugd ond maybe netplugd(not tested)
> > here my patch for
> > drivers/net/au1000.c
> 
> Please never ever send ed-style patches, only unified (-u).  They're
> totally unreadable and have several technical problems.  And preferbly
> inline, not attachment.

And `-p' helps as wel...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
