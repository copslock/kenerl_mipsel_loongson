Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g72B8tRw031369
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 04:08:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g72B8tFe031368
	for linux-mips-outgoing; Fri, 2 Aug 2002 04:08:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g72B8iRw031359;
	Fri, 2 Aug 2002 04:08:45 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g72B9bXb029611;
	Fri, 2 Aug 2002 04:09:37 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA10346;
	Fri, 2 Aug 2002 04:09:37 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g72B9ab18657;
	Fri, 2 Aug 2002 13:09:36 +0200 (MEST)
Message-ID: <3D4A6868.FBBB36CB@mips.com>
Date: Fri, 02 Aug 2002 13:09:35 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
References: <20020731223158.A6394@dea.linux-mips.net> <Pine.GSO.3.96.1020801171104.8256E-100000@delta.ds2.pg.gda.pl> <20020801191804.D22824@dea.linux-mips.net> <3D4A519B.3EF5459@mips.com> <20020802130552.C27824@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Fri, Aug 02, 2002 at 11:32:18AM +0200, Carsten Langgaard wrote:
>
> > > >  After looking at the generated assembly I discovered the handlers don't
> > > > fit in 128 bytes.  They didn't crash since I have modules disabled for
> > > > now, so the vmalloc path didn't get hit and the user path happened to fit,
> > > > but it was pure luck.  The path got hit before I fixed a bug in gas though
> > > > -- that's the explanation of the false cache error exceptions I used to
> > > > observe.
> > >
> > > Ouch.  It was a known problem but we simply ignored it for a while as that
> > > handler just overwrites the cache error handler which normally should be
> > > used extremly rarely, if at all.  The problem is somewhat itching by now
> > > as we're supporting the SB1 core which in it's revision one may throw
> > > spurious cache errors, so the handler is actually used ...
> > >
> >
> > Maybe it's time for some intelligent check for the size of these exception
> > routine.
>
> Easy trick at compile time which will just inflate the object code a little
> bit:
>
>         .align  5
> LEAF(except_vec1_r4k)
>         [...]
>         END(except_vec1_r4k)
>         .org    except_vec1_r4k + 0x80
>
> This will result in an assembler error if the body of the except_vec1_r4k
> function is bigger than 0x80.
>

Great idea, please put it in the code.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
