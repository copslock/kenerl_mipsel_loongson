Received:  by oss.sgi.com id <S553736AbRAEWTP>;
	Fri, 5 Jan 2001 14:19:15 -0800
Received: from mx.mips.com ([206.31.31.226]:56748 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553699AbRAEWSy>;
	Fri, 5 Jan 2001 14:18:54 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA06583;
	Fri, 5 Jan 2001 14:18:48 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA11050;
	Fri, 5 Jan 2001 14:18:34 -0800 (PST)
Message-ID: <006c01c07765$fdd26440$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        <Lisa.Hsu@taec.toshiba.com>
Cc:     <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010105214251.9384G-100000@delta.ds2.pg.gda.pl>
Subject: Re: questions on the cross-compiler
Date:   Fri, 5 Jan 2001 23:22:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > With the help from Kevin Kissell,  I've found out that  the compilation
> > directives "set .mips3[4]" were turned on before cpu_probe() and
cpu_probe
> > () functions in my head.S file.  This is the reason why I've got that
wrong
> > code generated although I've specified mip1 in the gcc options.
> >
> > I 've temporarily used #define to add "set .mips1" in the code to fix
the
> > problem.   My question now,  is: how can we make the kernel code
flexible
> > to free from the problem of the one that I've got?
>
> 1. Don't use "set .mips*" unless absolutely needed.  The right ISA level
> is already set via a compiler option depending on the host CPU selected
> upon kernel configuration.

Lisa's underlying problem may be that there isn't a Config
option for the R39xx CPUs, and she's ended up getting an
R4000 (or whatever) configuration by default.

At some point specific support for the R3900 features
(MIPS II ISA, seperate hardware interrupt vector, etc.)
should go into the kernel, but for the moment, you should
make sure that when you do the initial "make config"
(or xconfig or menuconfig or whatever) you select an
R3000 CPU.  You won't get it by default.  You may
also need to hack the head.S code to detect an R39xx PrID
value and replace it with an R3000  value before it gets used
by the kernel.  Otherwise, you may need to generate additional
cases/conditionals for R3900 wherever you see R3000 called
out in the existing code.  If your kernel base has my cpu_probe()
in C, adding R39xx support will be much easier, but while
I *think* I set it up such that, if the R4K_EXCEPTION_MODEL
option bit isn't set, the kernel assumes an R3K model, I never
tested that option - not having any R3xxx platforms in
the lab!

            Kevin K.
