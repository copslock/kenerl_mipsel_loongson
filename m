Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UC8fRw006448
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 05:08:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UC8fdb006447
	for linux-mips-outgoing; Tue, 30 Jul 2002 05:08:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UC8URw006437;
	Tue, 30 Jul 2002 05:08:30 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6UC9BXb016981;
	Tue, 30 Jul 2002 05:09:11 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA03673;
	Tue, 30 Jul 2002 05:09:10 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6UC99b24887;
	Tue, 30 Jul 2002 14:09:09 +0200 (MEST)
Message-ID: <3D4681DE.7BE793C9@mips.com>
Date: Tue, 30 Jul 2002 14:09:09 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
References: <Pine.GSO.3.96.1020729163359.22288I-100000@delta.ds2.pg.gda.pl> <3D45A13E.79C882B5@mips.com> <3D46393D.37D36612@mips.com> <20020730132955.A28302@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Tue, Jul 30, 2002 at 08:59:17AM +0200, Carsten Langgaard wrote:
>
> > We have been discussing this before, but I really don't like the idea of
> > solving the hazard problem with a branch. The branch will on some CPUs
> > (especially if they have a long pipeline) be a much bigger penalty than
> > we actually wants to solve the hazard. On other CPU (with branch
> > prediction) we may not even solve the hazard problem.
>
> The branch - which is used by other OSes btw. - for the R4000 / R4400 where
> this kind of taken branch implies a total delay of three cycles.  One for
> the branch delay slot plus two extra cycles for the killed instructions
> following the branch delay slot.  For R4600, R4700, R5000 and a bunch of
> derivates I've verified that according to the documentation this extra
> penalty of two cycles does not exist nor we need two extra cycles to handle
> the hazard.  In other words the branch trick - which also is used by
> some other commercial OS btw. - is providing best possible performance on
> a wide range of processors.

If we are going to make the exception generic and usable for as many CPUs as
possible, I don't thing the branch trick is save.
Why not make a hazard barrier that contains 0, 1 or 2 'ssnop's depending on
the CPU configuration ?
This way we will have the exact number of 'ssnop' to solve the hazard, without
adding extra penalty for other CPUs.


>
> > The 'nop' I used is not the solution either, instead we should use
> > 'ssnop' instructions, which will make sure we also solve the hazard
> > problem on superscalar CPUs.  We also need to have a hazard barrier in
> > the code labeled "not_vmalloc".
>
> Above trick was written with single issue CPUs in mind.  I'd have to
> verify the pipeline timing again against CPU manuals but off my memory
> at least SB1 and R1x000 are fully protected against the hazards in
> question.
>

Yes, I guess that is true.
I guess most dual issue CPUs has fully protection against these type of
hazard, because it would be hard to say exactly how many 'ssnop' are need to
solve the hazard in software.


>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
