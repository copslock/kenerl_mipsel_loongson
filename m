Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UE9YRw010665
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 07:09:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UE9Y73010664
	for linux-mips-outgoing; Tue, 30 Jul 2002 07:09:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UE9IRw010655
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 07:09:18 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6UE9gXb017254;
	Tue, 30 Jul 2002 07:09:42 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA06597;
	Tue, 30 Jul 2002 07:09:42 -0700 (PDT)
Received: from coplin18.mips.com (IDENT:dant@coplin18 [192.168.205.88])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6UE9cb00987;
	Tue, 30 Jul 2002 16:09:38 +0200 (MEST)
Date: Tue, 30 Jul 2002 16:09:37 +0200 (CEST)
From: Dan Temple <dant@mips.com>
To: Carsten Langgaard <carstenl@mips.com>
cc: cgd@broadcom.com, <hjl@lucon.org>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, <linux-mips@oss.sgi.com>,
   <binutils@sources.redhat.com>
Subject: Re: PATCH: Update E_MIP_ARCH_XXX (Re: [patch] linux:  RFC:elf_check_arch()
 rework)
In-Reply-To: <3D44F31D.55155E24@mips.com>
Message-ID: <Pine.LNX.4.44.0207301606350.31951-100000@coplin18.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.7 required=5.0 tests=IN_REP_TO,PORN_10,SUPERLONG_LINE version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've now heard a bit of the history from Nigel at Algorithmics, and to summarize, they chose the 6 and 7 values for MIPS32/64 after Cygnus, who were also producing a MIPS32/64 toolchain, had chosen these. (Algor had originally used the value of 5 for MIPS32, but had to changed when both SGI (who assigned it to something else) and Cygnus chose otherwise). Hence ARCH_ALGOR_32.

A little research also reveals that the value of 5 for ARCH_32 was first checked into CVS in Dec 2000 by Nick Clifton at Redhat.

Anyway, that's why things are the way they are, but may not help much as to a resolution :(

My personal take on this is that the two main commercial providers (Cygnus and Algor) of MIPS32/64-capable GNU toolchains have been using 6 & 7 for quite a while, SGI "agree", and that this is quite a precedent. Hopefully the ABI process will soon shake any other issues out too.

/Dan

On Mon, 29 Jul 2002, Carsten Langgaard wrote:

> First of all I will like to thank you for all the replies, we really appreciate
> it, because it helps us in our process of making a proper ABI spec.
> I known it's a relative late state we are trying to provide the community with an
> ABI document, but I guess it's better to be late than to never show up.
> I believe we all could benefit from such a document, it's only in a internal draft
> version right now, but it might be a good idea to send it out to the community for
> comments, before the finally version.
> But we are still in an early state and on the learning curve.
> 
> Regarding the ELF header arch values, we did try to select whose in order not to
> break things for anyone.
> I'm also a little surprised to see these value out in binutils, it really surprise
> me, if we got a linux toolchain that can generate mips32/mips64 code.
> 
> MIPS32R2 and MIPS64R2 is a new enhanced version of MIPS32 and MIPS64 architecture,
> which among other things include some new instructions.
> 
> Regarding Algorithmics, I don't know if everybody are aware of it, but we have
> just acquired Algorithmics.
> That among other things, is done in order to play a stronger part in the
> development of the toolchain. And their work will be pushed back to the community.
> 
> Algorithmics have done a MIPS32 compiler for us, which is very close to be
> released.
> 
> I hope this clarify a little bit, what our motivation are.
> /Carsten
> 
> 
> cgd@broadcom.com wrote:
> 
> > At Thu, 25 Jul 2002 15:26:19 +0000 (UTC), "H. J. Lu" wrote:
> > > I'd like to fix binutils ASAP. Here is a patch.
> >
> > OK, so, I've seen no response so far that indicates that binutils
> > should actually be changed.
> >
> > to recap:
> >
> > * Binutils has deployed these values in several releases now, and I
> >   know for a fact that people are using binaries with these values.
> >
> > * SGI has followed binutils' lead in selecting values.
> >
> > * Algorithmics did something else, though it's not clear what the
> >   difference between "ARCH_ALGOR_32" and "ARCH_32" really is.
> >
> > It seems obvious that the simplest solution that causes the least pain
> > all around is to go with the numbering binutils currently uses.  This
> > will probably cause a little bit of pain for Algorithmics, but, well,
> > they could have sent something to binutils to indicate use of that
> > number, and i'm quite sure that most of the rest of us have had to put
> > temporary backward-compat hacks in our own codebases for incompatible
> > changes made by others in the past.  It's not that hard and doesn't
> > cause long-term pain.
> >
> > I could understand that MIPS or Algorithmics might like that, but I
> > think there're a bunch of morals to this story: if you want to lead on
> > ABI issues, get out in front of them (you can't lead from the back
> > 8-); interact with the tool development and use communities about such
> > issues _before_ solutions are needed and agreed upon in those
> > communities; and, you're hacking open source code like binutils,
> > contribute your changes back as soon as you possibly can.
> >
> > I'd also like to point out that saying "mips will be defining this
> > ABI, so you should all change your code to work with it" without,
> > AFAIK, even providing a draft of said ABI... is unlikely to produce
> > positive results even _if_ there's no precedent that would go against
> > the requested change.  (if somebody has a ptr, i'd be glad to be
> > corrected 8-)
> >
> > (I wonder what other incompatibilities may exist between this new ABI
> > and the current binutils MIPS ELF headers...)
> >
> > cgd
> > --
> > Chris Demetriou                                            Broadcom Corporation
> > Senior Staff Design Engineer                  Broadband Processor Business Unit
> >   Any opinions expressed in this message are mine, not necessarily Broadcom's.
> 
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com
> 
> 
> 
> 

-- 
Dan Temple, Eng. Mgr.     Tel: +45-44865512     
  MIPS Denmark              Fax: +45-44865556     
  Lautrupvang 4B            mailto:dant@mips.com  
  DK-2750 Ballerup          http://www.mips.com
  Denmark                  
