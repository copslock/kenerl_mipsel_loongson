Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 09:11:57 +0200 (CEST)
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:7944 "EHLO
	smtp-vbr12.xs4all.nl") by lappi.linux-mips.net with ESMTP
	id S525882AbYDDHLw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 09:11:52 +0200
Received: from dealogic.nl (a62-251-87-113.adsl.xs4all.nl [62.251.87.113])
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id m347B4IE009580
	for <linux-mips@linux-mips.org>; Fri, 4 Apr 2008 09:11:21 +0200 (CEST)
	(envelope-from ncoesel@DEALogic.nl)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Fix xss1500 compilation
Date:	Fri, 4 Apr 2008 09:06:29 +0200
Message-ID: <19CA9E279FDA5246B7D7A1C91A4AF7F40EFAA3@dealogicserver.DEALogic.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix xss1500 compilation
thread-index: AciVwPeSIL8Q3NchQmO23q+AJU8R/QAYAQEA
From:	"Nico Coesel" <ncoesel@DEALogic.nl>
To:	<linux-mips@linux-mips.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <ncoesel@DEALogic.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncoesel@DEALogic.nl
Precedence: bulk
X-list: linux-mips

I just looked at some other AU1x00 PCMCIA drivers. My guess is that if
someone wants to use PCMCIA on the XXS1500 board it is pretty simple to
create a new driver based on the pb1x00 or db1x00 board drivers
-assuming these work and compile well-.

Nico Coesel

> -----Oorspronkelijk bericht-----
> Van: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] Namens Adrian Bunk
> Verzonden: dinsdag 1 april 2008 17:55
> Aan: Florian Fainelli
> CC: linux-mips@linux-mips.org; ralf@linux-mips.org
> Onderwerp: Re: [PATCH] Fix xss1500 compilation
> 
> On Tue, Apr 01, 2008 at 03:53:25PM +0200, Florian Fainelli wrote:
> > This patch fixes the compilation of the Au1000 XSS1500  board setup 
> >and irqmap code.
> >...
> 
> Another compile error for this platform is:
> 
> <--  snip  -->
> 
> ...
>   CC [M]  drivers/pcmcia/au1000_xxs1500.o
> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:33:26: 
> error: linux/tqueue.h: No such file or directory
> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:44:28: 
> error: pcmcia/bus_ops.h: No such file or directory
> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:51:24: 
> error: asm/au1000.h: No such file or directory
> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:52:31: 
> error: asm/au1000_pcmcia.h: No such file or directory ...
> make[3]: *** [drivers/pcmcia/au1000_xxs1500.o] Error 1
> 
> <--  snip  -->
> 
> include/linux/tqueue.h was removed on Sep 30, 2002 (sic) 
> which was even before 2.6.0 .
> 
> Obviously no 2.6 kernel ever ran on these boards.
> 
> If you have such a board and want to run kernel 2.6 on it 
> that's fine with me, but otherwise i don't see much point in 
> keeping the support for this board.
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> 
> 
