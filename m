Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4P22QnC021773
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 24 May 2002 19:02:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4P22QOL021772
	for linux-mips-outgoing; Fri, 24 May 2002 19:02:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4P22KnC021768
	for <linux-mips@oss.sgi.com>; Fri, 24 May 2002 19:02:20 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020525020323.UCNI11426.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Sat, 25 May 2002 02:03:23 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 970A5125C2; Fri, 24 May 2002 19:03:22 -0700 (PDT)
Date: Fri, 24 May 2002 19:03:22 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: cgd@broadcom.com, linux-mips@oss.sgi.com
Subject: Re: linux.h patch for mips
Message-ID: <20020524190322.C10735@lucon.org>
References: <1022278283.25829.46.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1022278283.25829.46.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Fri, May 24, 2002 at 03:11:23PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I will leave it to the Linux mips people. Any comments?


H.J.
---
On Fri, May 24, 2002 at 03:11:23PM -0700, Eric Christopher wrote:
> Hey, wanted to run this by you.
> 
> I've noticed a tendency for the linux kernel people to test
> _MIPS_ISA_MIPSXX when writing defines for 32 v. 64 bit code in the asm
> headers (and other places). Personally I'd prefer they check something
> else like -D__mips_fpr=32/64, but it's not something I have time to fix
> in the kernel right now (and for gpr I'd have to define something new,
> which wouldn't be hard).
> 
> Thought I'd check with you and see if you had any other ideas how better
> to do that kind of interface?
> 
> -eric
> 
> ps. I'm checking the following patch in momentarily to fix a problem I
> noticed.
> 
> -- 
> I will not carve gods
> 
> Index: linux.h
> ===================================================================
> RCS file: /cvs/gcc/gcc/gcc/config/mips/linux.h,v
> retrieving revision 1.44
> diff -u -p -w -r1.44 linux.h
> --- linux.h	20 May 2002 17:11:53 -0000	1.44
> +++ linux.h	24 May 2002 21:56:01 -0000
> @@ -155,6 +155,8 @@ void FN ()							\
>  %{mips2: -D_MIPS_ISA=_MIPS_ISA_MIPS2} \
>  %{mips3: -D_MIPS_ISA=_MIPS_ISA_MIPS3} \
>  %{mips4: -D_MIPS_ISA=_MIPS_ISA_MIPS4} \
> +%{mips32: -D_MIPS_ISA=_MIPS_ISA_MIPS32} \
> +%{mips64: -D_MIPS_ISA=_MIPS_ISA_MIPS64} \
>  %{!mips*: -D_MIPS_ISA=_MIPS_ISA_MIPS1} \
>  %{mabi=32: -D_MIPS_SIM=_MIPS_SIM_ABI32}	\
>  %{mabi=n32: -D_ABIN32=2 -D_MIPS_SIM=_ABIN32} \
