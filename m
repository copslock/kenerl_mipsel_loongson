Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 08:22:05 +0100 (BST)
Received: from assei1bl6.telenet-ops.be ([195.130.133.68]:44181 "EHLO
	assei1bl6.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20021835AbXEHHWD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 May 2007 08:22:03 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by assei1bl6.telenet-ops.be (Postfix) with SMTP id 5B176220097;
	Tue,  8 May 2007 09:22:03 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by assei1bl6.telenet-ops.be (Postfix) with ESMTP id 31954220087;
	Tue,  8 May 2007 09:22:03 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l487M29N000918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 8 May 2007 09:22:02 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l487M26U000915;
	Tue, 8 May 2007 09:22:02 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Tue, 8 May 2007 09:22:02 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Samium Gromoff <_deepfire@feelingofgreen.ru>
Cc:	sknauert@wesleyan.edu, linux-mips@linux-mips.org
Subject: Re: PCI video card on SGI O2
In-Reply-To: <876473x0jx.wl@betelheise.deep.net>
Message-ID: <Pine.LNX.4.64.0705080920150.24717@anakin>
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
 <876473x0jx.wl@betelheise.deep.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 8 May 2007, Samium Gromoff wrote:
> At Tue, 8 May 2007 02:24:20 -0400 (EDT),
> sknauert@wesleyan.edu wrote:
> [snip]
> > 3) I tried a Voodoo 1, ATI Mach 64, S3 Virge DX, GX, etc., I actually have
> > a Millenium I but it won't fit in the O2.
> 
> Are you sure those have/need not to have proper BIOSen flashed onto them?
> 
> As i imagine, a videocard with x86 cr^Bode flashed into it is pretty useless,
> or worse than useless, on anything but x86...

You can run the x86 emulator to execute the BIOS code. IIRC, (some version of)
the X server has such an emulator included.  But that indeeds need `legacy I/O
port' access to work.

It's a pity the Millenium doesn't fit, as matroxfb is about the only
frame buffer device that can initialize a graphics card from scratch,
without help from the BIOS...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
