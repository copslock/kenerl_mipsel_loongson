Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B9FWRw022631
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 02:15:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B9FWeA022630
	for linux-mips-outgoing; Thu, 11 Jul 2002 02:15:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B9FNRw022621;
	Thu, 11 Jul 2002 02:15:23 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6B9J2Xb011289;
	Thu, 11 Jul 2002 02:19:02 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA05438;
	Thu, 11 Jul 2002 02:19:00 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6B9J0b24488;
	Thu, 11 Jul 2002 11:19:00 +0200 (MEST)
Message-ID: <3D2D4D83.B2694DF1@mips.com>
Date: Thu, 11 Jul 2002 11:18:59 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
CC: Ralf Baechle <ralf@oss.sgi.com>, Jon Burgess <Jon_Burgess@eur.3com.com>,
   linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <80256BF2.004ECBE6.00@notesmta.eur.3com.com> <20020711021554.A3207@dea.linux-mips.net> <3D2D465C.FA06D50A@niisi.msk.ru>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Gleb O. Raiko" wrote:

> Ralf Baechle wrote:
> >
> > On Wed, Jul 10, 2002 at 03:16:21PM +0100, Jon Burgess wrote:
> >
> > > This may be caused by the cache routines running from the a cached kseg0, it
> > > looks like it can be fixed by making sure that the are always called via
> > > KSEG1ADDR(fn) which looks like it could be done with a bit of fiddling of the
> > > setup_cache_funcs code. I have included a patch below which starts this, but I
> > > haven't caught all combinations of how the routines are called.
> >
> > While that could be done it's not a good idea; running code in KSEG1 is
> > very slow.
> >
>
> Unfortunately, it's required by manuals for some processors. As I know,
> IDT HW manuals clearly state cache flush routines must operate from
> uncached code and must access uncached data only. Examples are R30x1 CPU
> series.

Yes, that's true.
But that code belongs in the R30xx specific cache routines, not in the MIPS32 cache
routines.

>
> Regards,
> Gleb.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
