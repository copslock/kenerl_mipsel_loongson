Received:  by oss.sgi.com id <S553714AbRBGWr5>;
	Wed, 7 Feb 2001 14:47:57 -0800
Received: from mx.mips.com ([206.31.31.226]:7361 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553724AbRBGWru>;
	Wed, 7 Feb 2001 14:47:50 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA04217;
	Wed, 7 Feb 2001 14:47:48 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA04845;
	Wed, 7 Feb 2001 14:47:45 -0800 (PST)
Message-ID: <005101c09158$85941d40$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jun Sun" <jsun@mvista.com>, "Florian Lohoff" <flo@rfc822.org>
Cc:     <linux-mips@oss.sgi.com>, <ralf@oss.sgi.com>
References: <20010207144857.B24485@paradigm.rfc822.org> <3A819B80.7946F866@mvista.com>
Subject: Re: NON FPU cpus - way to go
Date:   Wed, 7 Feb 2001 23:51:25 +0100
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

> Moving forward I see MIPS mainly used in embedded systems.  I think need
of
> using the same kernel binary for multiple CPUs is rare, especially for the
> "same" CPU with or without FPU.  Therefore having run-time detection is a
> waste of effort.  Half-config-half-runtime solution is pretty messy too.
>
> For CPUs with the same PrID that may or may not have a FPU, we can add an
> optional FPU selection in the config.in file.b
>
> To be complete, I probably would add a check for the existence of FPU, if
we
> can infer from PrID, when FPU config option is enabled.

A few comments here:

Moving forward,  MIPS CPUs will have a specific FPU-present bit
in one of the CP0 Config registers, as specified by MIPS32/MIPS64.
So the effort wasted in run-time detection will be pretty damned small.

As other people have observed, having the FPU emulator in
the kernel is necessary for full IEEE math even if one *has*
an FPU.  When I bolted the Algorithmics emulator into the 2.2
kernel at MIPS, I made it optional so that people could regress
to Ralf's old not-fully-compliant mini-emulator if they were really
desperate for memory and didn't need full IEEE.  Maybe I
should have just nuked it and made the full emulator mandatory.

As far as the library-versus-kernel-emulation debate is
concerned, yes, user-level emulation will always be faster.
However, you end up with a rather unpleasant configration
management problem - every application and library
distributed needs to be built both with and without FP.
And this affects *every* binary - even those that do zero
FP computation will try to save and restore FPU state
on setjmp/longjmp operations in the best of cases,
and in the existing subobtimal reality, whatever the
hell GCC calls crt0.o touches the floating control
registers on program startup.   My own opinion has
been that people who care about FP performance
run their applications on CPUs with hardware FP,
so the performance advantage of library-based
FP emulation is largely wasted on those who don't
care about it.  But I would understand if the Vr-Linux guys
disagreed with me on that!

            Regards,

            Kevin K.
