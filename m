Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PIDGnC003969
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 11:13:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4PIDGwU003968
	for linux-mips-outgoing; Sat, 25 May 2002 11:13:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4PID9nC003965
	for <linux-mips@oss.sgi.com>; Sat, 25 May 2002 11:13:10 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17Bg2a-0006Bq-00; Sat, 25 May 2002 20:13:20 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17Bg3I-0000AD-00; Sat, 25 May 2002 20:14:04 +0200
Date: Sat, 25 May 2002 20:14:04 +0200
To: "H . J . Lu" <hjl@lucon.org>
Cc: Eric Christopher <echristo@redhat.com>, cgd@broadcom.com,
   linux-mips@oss.sgi.com
Subject: Re: linux.h patch for mips
Message-ID: <20020525181404.GI21557@rembrandt.csv.ica.uni-stuttgart.de>
References: <1022278283.25829.46.camel@ghostwheel.cygnus.com> <20020524190322.C10735@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020524190322.C10735@lucon.org>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H . J . Lu wrote:
> I will leave it to the Linux mips people. Any comments?
> 
> 
> H.J.
> ---
> On Fri, May 24, 2002 at 03:11:23PM -0700, Eric Christopher wrote:
> > Hey, wanted to run this by you.
> > 
> > I've noticed a tendency for the linux kernel people to test
> > _MIPS_ISA_MIPSXX when writing defines for 32 v. 64 bit code in the asm
> > headers (and other places). Personally I'd prefer they check something
> > else like -D__mips_fpr=32/64, but it's not something I have time to fix
> > in the kernel right now (and for gpr I'd have to define something new,
> > which wouldn't be hard).
> > 
> > Thought I'd check with you and see if you had any other ideas how better
> > to do that kind of interface?
> > 
> > -eric
> > 
> > ps. I'm checking the following patch in momentarily to fix a problem I
> > noticed.
> > 
> > -- 
> > I will not carve gods
> > 
> > Index: linux.h
> > ===================================================================
> > RCS file: /cvs/gcc/gcc/gcc/config/mips/linux.h,v
> > retrieving revision 1.44
> > diff -u -p -w -r1.44 linux.h
> > --- linux.h	20 May 2002 17:11:53 -0000	1.44
> > +++ linux.h	24 May 2002 21:56:01 -0000
> > @@ -155,6 +155,8 @@ void FN ()							\
> >  %{mips2: -D_MIPS_ISA=_MIPS_ISA_MIPS2} \
> >  %{mips3: -D_MIPS_ISA=_MIPS_ISA_MIPS3} \
> >  %{mips4: -D_MIPS_ISA=_MIPS_ISA_MIPS4} \

At least for completeness there should be also _MIPS_ISA_MIPS5
(the -mips5 swich would cause _MIPS_ISA_MIPS1 otherwise).

> > +%{mips32: -D_MIPS_ISA=_MIPS_ISA_MIPS32} \
> > +%{mips64: -D_MIPS_ISA=_MIPS_ISA_MIPS64} \
> >  %{!mips*: -D_MIPS_ISA=_MIPS_ISA_MIPS1} \
> >  %{mabi=32: -D_MIPS_SIM=_MIPS_SIM_ABI32}	\
> >  %{mabi=n32: -D_ABIN32=2 -D_MIPS_SIM=_ABIN32} \
