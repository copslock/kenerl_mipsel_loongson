Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Dec 2002 13:08:49 +0100 (MET)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:4087 "EHLO
	mx2.mips.com") by ralf.linux-mips.org with ESMTP id <S868962AbSLBMIj>;
	Mon, 2 Dec 2002 13:08:39 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB2CALNf008949;
	Mon, 2 Dec 2002 04:10:22 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA13260;
	Mon, 2 Dec 2002 04:10:09 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB2CA8b06808;
	Mon, 2 Dec 2002 13:10:09 +0100 (MET)
Message-ID: <3DEB4DA0.E8200A58@mips.com>
Date: Mon, 02 Dec 2002 13:10:08 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: atlas_serial_{in,out}
References: <Pine.GSO.4.21.0212021213490.10713-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

They should have been in arch/mips/mips-boards/generic/printf.c, but they have
been removed, apparently.
Ralf, do you have any comment on why this code has been removed.

/Carsten



Geert Uytterhoeven wrote:

>         Hi,
>
> The MIPS 2.4.x drivers/char/serial.c differs from the upstream version by the
> addition of hooks for the Atlas serial ports. However, I cannot find where
> those hooks (atlas_serial_{in,out}) are actualy defined.
>
> Did I overlook something, or is this a leftover from obsolete code?
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
