Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4L8BgnC028752
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 21 May 2002 01:11:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4L8BgSx028751
	for linux-mips-outgoing; Tue, 21 May 2002 01:11:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4L8BbnC028748
	for <linux-mips@oss.sgi.com>; Tue, 21 May 2002 01:11:37 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id BAA09440;
	Tue, 21 May 2002 01:12:14 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA04846;
	Tue, 21 May 2002 01:12:14 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g4L8CEb12172;
	Tue, 21 May 2002 10:12:15 +0200 (MEST)
Message-ID: <3CEA015E.65E15A1A@mips.com>
Date: Tue, 21 May 2002 10:12:14 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Aaker <kaaker@silverbacksystems.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Mangled struct hd_driveid with MIPSEB.
References: <3CE2C834.2010302@silverbacksystems.com> <3CE3578C.CF29A2D6@mips.com> <3CE3CB16.1040503@silverbacksystems.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I just noticed that Ralf hadn't merged in the full IDE patch I send, so that's
why it doesn't work for you.
Ralf has just checked in the rest yesterday, so try check out the latest
sources and see if that helps.

/Carsten


Ken Aaker wrote:

> The problem with the difference isn't that it's byte swapped, its that
> the byte swapping isn't respecting the data types inside the structure.
> It fixes all of the "short" entities, but it re-orders the fields that
> happen to be two chars next to each other, and the "shorts" that are
> part of the two "ints" for lba capacity and capacity values are in the
> wrong order, even though the bytes within the "shorts" are in the right
> order. So, when the fixup code in ide.h is run, the values are still wrong.
>
> old ----
> 0070: 3f0010fc fb000001 80ac7e03 00000704   "?.........~....."
> 0080: 03007800 78007800 78000000 00000000   "..x.x.x.x......."
> new---
> 0070: 003ffc10 00fb0100 ac80037e 00000407   ".?.........~...."
> 0080: 00030078 00780078 00780000 00000000   "...x.x.x.x......"
>
> proper--- (after fix up).
> 0070: 003f00fb fc100001 037eac80 00000407   ".?.......~......"
> 0080: 00030078 00780078 00780000 00000000   "...x.x.x.x......"
>
> Ken

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
