Received:  by oss.sgi.com id <S553879AbRAIPrQ>;
	Tue, 9 Jan 2001 07:47:16 -0800
Received: from mx.mips.com ([206.31.31.226]:31962 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553876AbRAIPrI>;
	Tue, 9 Jan 2001 07:47:08 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA29351;
	Tue, 9 Jan 2001 07:47:03 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA01638;
	Tue, 9 Jan 2001 07:47:01 -0800 (PST)
Message-ID: <012801c07a53$ed06e460$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Florian Lohoff" <flo@rfc822.org>, <linux-mips@oss.sgi.com>
References: <20010109004101.B27674@paradigm.rfc822.org> <000501c079d3$fefe1a60$0deca8c0@Ulysses> <20010109130958.B1047@bacchus.dhis.org>
Subject: Re: MIPS32 patches breaking DecStation
Date:   Tue, 9 Jan 2001 16:50:34 +0100
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

> > Yes, the code fragment in question is R4K-specific, but
> > we really need to migrate towards the use of consistent
> > mechanisms that work across the full range of MIPS
> > CPUs.  Ideally, *all* CP0 hazards should some day be
> > padded out with "ssnops" (sll $0,$0,1, if I recall), which
> > force a 1 cycle delay per instruction even on superscalar
> > MIPS CPUs.
>
> While we could come up with a common TLB fault handler I really don't want
> to.  For many applications this TLB fault handler is extremly performance
> sensitive; every single cycle directly translates into application
> performance.  Seems like we'll need some more TLB fault handler.  And a
> complete TLB fault handler rewrite would be a good ide anyway, sigh ...

Sorry if I wasn't clear.  I am not suggesting a "one size
fits all" TLB handler - though as the old SGI hardware
gets retired and the newer, more standardized MIPS32
and MIPS64 parts become the principal targets, we
may see a greater convergence.  I am simply suggesting
that, even if there are differences in policy necessitated
by different CPU implementations, they should use the
same mechanisms.  If all CP0 hazards are avoided by
using ssnops, for example, we could evolve from writing
a new handler for every R4K variant to having a routine
that generates a handler with the right pipeline hazard
management, based on a set of paramters for the CPU.
And, while Ralf and I sometimes disagree on the importance
of this, in my own opinion, being consistent in these small
details helps avoid errors when a systems programmer
new to the architecture and/or the OS needs to work on
the system.

You may say that I'm a dreamer, but I'm not the only one.  ;-)

            Regards,

            Kevin K.
