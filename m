Received:  by oss.sgi.com id <S553751AbRAHNxq>;
	Mon, 8 Jan 2001 05:53:46 -0800
Received: from mx.mips.com ([206.31.31.226]:4296 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553759AbRAHNxZ>;
	Mon, 8 Jan 2001 05:53:25 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA17844;
	Mon, 8 Jan 2001 05:52:49 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA23644;
	Mon, 8 Jan 2001 05:52:46 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id OAA23151;
	Mon, 8 Jan 2001 14:52:11 +0100 (MET)
Message-ID: <3A59C60A.71FA35E0@mips.com>
Date:   Mon, 08 Jan 2001 14:52:10 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Michael Shmulevich <michaels@jungo.com>
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: User applications
References: <3A598AFC.83204F56@mips.com> <3A59C0FB.62E52EF0@jungo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Michael Shmulevich wrote:

> Carsten Langgaard wrote:
>
> > I have a few questions about user applications.
> >
> > When a new user process is started will its user space be cleared by the
> > kernel or is there a potential leak from an older user process ?
>
> Usually it is defied by the loader. If the data section contents is set to
> LOAD, then the contents of the section will be loaded from disk (no leak),
> if not -- whatever values left i nmemory will be there, or exactly, the
> virtual page of some other proccess that was swapped out or ended.
>
> > What about the registers values, are they cleared for each new user
> > application or will it simply contain the current value it got when the
> > user application is started ?
>
> It depends on the context switch algorithm of the processor, I think.
>
> > How can you flush the data and instruction cashes from a user
> > application ?
> >
>
> As far as I understand, ASID must take care of it. It contains unique IDs
> per process virtual space, so that even
> though virtual addresses may be found in TLB, their ASID will be different,
> causing TLB miss and probably page fault.
>

My problem is that I want to make self-modified code, so I need to flush both
the instruction and data cache.

>
> >
> > /Carsten
> >
> > --
> > _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> > |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> > | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
> >   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
> >                    Denmark            http://www.mips.com
>
> Michael.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
