Received:  by oss.sgi.com id <S553722AbRBIMx0>;
	Fri, 9 Feb 2001 04:53:26 -0800
Received: from mx.mips.com ([206.31.31.226]:61154 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553704AbRBIMxK>;
	Fri, 9 Feb 2001 04:53:10 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA23444;
	Fri, 9 Feb 2001 04:53:09 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA29940;
	Fri, 9 Feb 2001 04:53:05 -0800 (PST)
Message-ID: <009c01c09297$c78b8360$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     "Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010209123643.4645B-100000@delta.ds2.pg.gda.pl>
Subject: Re: config option vs. run-time detection (the debate continues ...)
Date:   Fri, 9 Feb 2001 13:56:44 +0100
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

> Let me remind the actual problem the discussion started from was whether
> we want to hardcode FP hw presence based on a CPU identification or to
> check for it explicitly.  I hope we agree the latter is saner.

Absolutely.

>  But the code that needs to know whether there is a real FPU present is
> indeed minimal (as it should be) thus the gain from removing the detection
> altogether in favour to a config option is at least questionable if not
> insane.

Well, I might not have put it that strongly, but I quite agree.

> > My own recommendation would be to either have
> > full FP support for binaries or none at all.  If someone
> > really wants to put the FPU-specific assembler
> > routines under a different conditional, that's cool, but
> > the configuration options should be such that the
> > (c) cannot be generated by the config scripts.
>
>  I think I may research what the gain from leaving parts of the FPU
> emulator apart would be for systems that have FP hw.

Surprisingly little.  Basically, you could remove emulation
for moves, loads, and stores.  Any instruction that actually
computes a value can potentially turn out to be unimplemented,
depending on the inputs.  If you *knew* you had an FPU, you
could also make the emulation fractionallly more efficient by
having it operate directly on the FP registers.  When the current
kernels emulate an instruction that failed on a HW FPU,
they copy the HW FPU state into the software FPU
registers, invoke the emulator, and when the emulation
has completed, restore the HW FPU state.  It made for
a clean interface to do things that way, and my
judgement was that the operation was too infrequent
to justify complicating things further.

> It's not a priority
> task for me at the moment -- the current configuration works and having
> unused code in a running kernel is ugly but non-fatal.

"If it ain't broke..."

            Kevin K.
