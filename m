Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4GA7gnC016418
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 16 May 2002 03:07:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4GA7g2I016417
	for linux-mips-outgoing; Thu, 16 May 2002 03:07:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4GA7anC016414
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 03:07:36 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id DAA01114;
	Thu, 16 May 2002 03:06:36 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA11608;
	Thu, 16 May 2002 03:06:37 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g4GA6cb29525;
	Thu, 16 May 2002 12:06:38 +0200 (MEST)
Message-ID: <3CE384AD.8DE96FEF@mips.com>
Date: Thu, 16 May 2002 12:06:37 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Ken Aaker <kenaaker@silverbacksystems.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: Mangled struct hd_driveid with MIPSEB.
References: <Pine.GSO.4.21.0205161035150.14918-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:

> On Thu, 16 May 2002, Carsten Langgaard wrote:
> > I send Ralf a fix a couple of weeks ago, which introduced the byteswapping,
> > which really is necessary.
> > This fix is probably only necessary for bigendian systems with large IDE
> > disks (>8GB), which support LBA mode.
> > I send this patch over a year ago. I discovered that when I ran on a disk,
> > which was larger than 8GB, it was only treated as 8GB.
> > The problem with the fix is, it is not backward compatible. After the fix
> > I needed to reinstall my bigendian system.
> > As I told Ralf, this fix will be a pain for everyone, but I guess we need
> > the fix eventually.
>
> Why would you have to reinstall the system?
> Isn't this just a problem with ide_fix_driveid() (new field for disks larger
> than 8 GiB, which we don't byteswap yet)?

I'm trying to do things like other bigendian architectures. I can see your mail
address is linux-m68k and the fix is more or less stolen from the m68k part.

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
