Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BACFRw023686
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 03:12:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BACFd9023685
	for linux-mips-outgoing; Thu, 11 Jul 2002 03:12:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BAC7Rw023676;
	Thu, 11 Jul 2002 03:12:07 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6BAFmXb011430;
	Thu, 11 Jul 2002 03:15:48 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA07218;
	Thu, 11 Jul 2002 03:15:47 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6BAFlb28861;
	Thu, 11 Jul 2002 12:15:47 +0200 (MEST)
Message-ID: <3D2D5AD2.1B254721@mips.com>
Date: Thu, 11 Jul 2002 12:15:46 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
CC: Ralf Baechle <ralf@oss.sgi.com>, Jon Burgess <Jon_Burgess@eur.3com.com>,
   linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <80256BF2.004ECBE6.00@notesmta.eur.3com.com> <20020711021554.A3207@dea.linux-mips.net> <3D2D465C.FA06D50A@niisi.msk.ru> <3D2D4D83.B2694DF1@mips.com> <3D2D58A6.2E5D9695@niisi.msk.ru>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Gleb O. Raiko" wrote:

> Carsten Langgaard wrote:
> > > Unfortunately, it's required by manuals for some processors. As I know,
> > > IDT HW manuals clearly state cache flush routines must operate from
> > > uncached code and must access uncached data only. Examples are R30x1 CPU
> > > series.
> >
> > Yes, that's true.
> > But that code belongs in the R30xx specific cache routines, not in the MIPS32 cache
> > routines.
>
> I don't wonder if other IDT CPUs also require this, including those that
> conform MIPS32.
> Basically, requirement of uncached run makes hadrware logic much simpler
> and allows  to save silicon a bit.

That could be true, but then again I suggest making specific cache routines for those
CPUs.
It would be a real performance hit for the rest of us, if we have to operate from
uncached space.


>
> Regards,
> Gleb.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
