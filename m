Received:  by oss.sgi.com id <S42223AbQG0NS3>;
	Thu, 27 Jul 2000 06:18:29 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14386 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42211AbQG0NSE>; Thu, 27 Jul 2000 06:18:04 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA09127
	for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 06:23:15 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA73348
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Jul 2000 06:17:01 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from styx.cs.kuleuven.ac.be (styx.cs.kuleuven.ac.be [134.58.40.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA06890
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Jul 2000 06:16:55 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from cassiopeia.home (root@dialup001.cs.kuleuven.ac.be [134.58.47.130])
	by styx.cs.kuleuven.ac.be (8.10.1/8.10.1) with ESMTP id e6RDGhJ18637;
	Thu, 27 Jul 2000 15:16:43 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id OAA00471;
	Thu, 27 Jul 2000 14:26:02 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Thu, 27 Jul 2000 14:26:02 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     =?ks_c_5601-1987?B?sejH0by6?= <khs@digital-digital.com>
cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: IGS5050 Driver
In-Reply-To: <000001bff6fe$34021120$8d19ebcb@khs>
Message-ID: <Pine.LNX.4.10.10007271423280.434-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 26 Jul 2000, [ks_c_5601-1987] ±èÇÑ¼º wrote:
> I want to know that there is a IGS5050 Grpahic chip driver for linux-mips.
> If yes, where is the driver files?

linux/drivers/video/cyber2000fb.c is a driver for the IGS CyberPro 2000, 2010
and 5000 in the NetWinder, which has an ARM CPU. If the 5050 is sufficient
compatible with the 5000 it should not be too difficult to get cyber2000fb to
work on the 5050 on the MIPS.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
