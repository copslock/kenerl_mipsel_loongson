Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BAhERw024371
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 03:43:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BAhEC6024370
	for linux-mips-outgoing; Thu, 11 Jul 2002 03:43:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BAh2Rw024361;
	Thu, 11 Jul 2002 03:43:02 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6BAkdXb011496;
	Thu, 11 Jul 2002 03:46:39 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA08157;
	Thu, 11 Jul 2002 03:46:38 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6BAkcb01181;
	Thu, 11 Jul 2002 12:46:38 +0200 (MEST)
Message-ID: <3D2D620D.95E1BF30@mips.com>
Date: Thu, 11 Jul 2002 12:46:37 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
CC: Ralf Baechle <ralf@oss.sgi.com>, Jon Burgess <Jon_Burgess@eur.3com.com>,
   linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <80256BF2.004ECBE6.00@notesmta.eur.3com.com> <20020711021554.A3207@dea.linux-mips.net> <3D2D465C.FA06D50A@niisi.msk.ru> <3D2D4D83.B2694DF1@mips.com> <3D2D58A6.2E5D9695@niisi.msk.ru> <3D2D5AD2.1B254721@mips.com> <3D2D5FA5.5D964B68@niisi.msk.ru>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Gleb O. Raiko" wrote:

> Carsten Langgaard wrote:
> >
> > "Gleb O. Raiko" wrote:
> > > Basically, requirement of uncached run makes hadrware logic much simpler
> > > and allows  to save silicon a bit.
> >
> > That could be true, but then again I suggest making specific cache routines for those
> > CPUs.
> > It would be a real performance hit for the rest of us, if we have to operate from
> > uncached space.
> >
>
> In theory, yes, there is a performance penalty. In practice, I doubt
> this penalty is significant. Sure, Linux likes to flush cahces, not to
> say more. But, did somebody measure the penalty of uncached runs? Even
> with microbencnmarks like lmbench.

Yes, I have tried running linux this way, because I wanted to eliminate the reason I sow
cache problems on one of our tests chip, was due to execute the cache operating
instruction from cached space.
I didn't thought it was that big a penalty, because you are flushing the cache anyway, but
I didn't had to run any benchmarks, so obviously was it when I booted my system.


>
> Regards,
> Gleb.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
