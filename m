Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2004 09:07:18 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:15794 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225274AbUF3IHO>;
	Wed, 30 Jun 2004 09:07:14 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i5U87BXK012814;
	Wed, 30 Jun 2004 10:07:11 +0200 (MEST)
Date: Wed, 30 Jun 2004 10:07:11 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Incorrect mapping of serial ports to lines
In-Reply-To: <Pine.LNX.4.55.0406300022290.31801@jurand.ds.pg.gda.pl>
Message-ID: <Pine.GSO.4.58.0406301006340.20130@waterleaf.sonytel.be>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
 <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl>
 <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be>
 <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl> <20040629151313.E6498@mvista.com>
 <Pine.LNX.4.55.0406300022290.31801@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 30 Jun 2004, Maciej W. Rozycki wrote:
> On Tue, 29 Jun 2004, Jun Sun wrote:
> > This is why I favor run-time serial port configuration.  My view
>
>  Well, that's certainly a reasonable long-time strategy.
>
> > (maybe a little dramatic) is to remove all static serial port definition
> > and push them into board setup routine.  asm/serial.h only needs
>
>  I'm not sure that is the right way of doing it -- note that one problem
> is serial drivers can be built as modules and inserted at the run time.

The same is true for whatever other type of device (SCSI, IDE, Ethernet, ...).
And depending on the order of module loading, the order of the devices will
change.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
