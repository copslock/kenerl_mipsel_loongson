Received:  by oss.sgi.com id <S553762AbRAHORQ>;
	Mon, 8 Jan 2001 06:17:16 -0800
Received: from mx.mips.com ([206.31.31.226]:16584 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553743AbRAHOQ7>;
	Mon, 8 Jan 2001 06:16:59 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA17947;
	Mon, 8 Jan 2001 06:16:54 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA24047;
	Mon, 8 Jan 2001 06:16:51 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id PAA24266;
	Mon, 8 Jan 2001 15:16:17 +0100 (MET)
Message-ID: <3A59CBB0.24160437@mips.com>
Date:   Mon, 08 Jan 2001 15:16:16 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     linux-mips@oss.sgi.com, Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
References: <3A598AFC.83204F56@mips.com> <3A59C0FB.62E52EF0@jungo.com> <00d801c0797d$5cc410c0$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:

> > > When a new user process is started will its user space be cleared by the
> > > kernel or is there a potential leak from an older user process ?
> >
> > Usually it is defied by the loader. If the data section contents is set to
> > LOAD, then the contents of the section will be loaded from disk (no leak),
> > if not -- whatever values left i nmemory will be there, or exactly, the
> > virtual page of some other proccess that was swapped out or ended.
>
> Note that what you are describing here is the "exec()" behavior.
> I believe Carsten was talking about what happens on a "fork()".
>
> > > What about the registers values, are they cleared for each new user
> > > application or will it simply contain the current value it got when the
> > > user application is started ?
> >
> > It depends on the context switch algorithm of the processor, I think.
>
> On a fork() (or presumably clone()) operation, the set of registers
> is copied.  Loading a new program ("exec()") should set up the
> registers that point to the base of the new stack, the environment,
> etc.  Historically, it's up to the runtime startup code ("crt0" in old
> Unix systems) to do any other register initialization.
>
> > > How can you flush the data and instruction cashes from a user
> > > application ?
> > >
> >
> > As far as I understand, ASID must take care of it. It contains unique IDs
> > per process virtual space, so that even
> > though virtual addresses may be found in TLB, their ASID will be
> different,
> > causing TLB miss and probably page fault.
>
> That won't necessarily affect the caches, though.  While it
> would be possible to do so, I don't believe any existing
> MIPS implementations include ASID in the cache tags.
> Hits are determined by an address match, period.
>
> Back in the Ancient Old Days of System V, every architecture
> had an architecture-specific system call entry, the first parameter
> of which expressed what needed to be done.  Do we have
> such a thing in Linux?   That would be the logical place to
> things like cache flush and the atomic operations that were
> being discussed here a couple of weeks ago.

I think I just found it.
The system call is sysmips(FLUSH_CACHE).

>
>             Regards,
>
>             Kevin K.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
