Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5Q8kZ724192
	for linux-mips-outgoing; Tue, 26 Jun 2001 01:46:35 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5Q8kXV24189
	for <linux-mips@oss.sgi.com>; Tue, 26 Jun 2001 01:46:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA01081;
	Tue, 26 Jun 2001 01:46:26 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA24707;
	Tue, 26 Jun 2001 01:46:23 -0700 (PDT)
Message-ID: <008a01c0fe1d$1fbd9a00$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <carlson@sibyte.com>
Cc: <linux-mips@oss.sgi.com>
References: <3B34BE3B.B72D40F1@mvista.com> <20010624214232.A18389@mvista.com> <001f01c0fd43$3865b680$0deca8c0@Ulysses> <0106251042380I.00703@plugh.sibyte.com>
Subject: Re: CONFIG_MIPS_UNCACHED
Date: Tue, 26 Jun 2001 10:50:50 +0200
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

> > That's a position that would sound reasonable to someone working
> > on Linux for legacy DEC/SGI systems, but not one that I would
> > expect to satisfy someone working on embedded Linux.  It would
> > need to be governed by a config option, but I would think
> > that ultimately we need to have a Linux that can be ROMed
> > and branched to directly from the reset vector.  Why force
> > everyone doing an embedded MIPS/Linux widget to re-invent
> > the wheel?
>
> Because there are very good reasons for having a firmware seperate from
> the OS.

Yes, and there are also very good reasons for minimizing
the size and functionality of that bootloader.  One could have
a minimalist but functional MIPS bootloader that runs in kseg1
and hasn't the faintest idea what a cache is.  As I said in
an earlier message on this thread, we should either be explicit
about what we assume the bootloader will have done for us, or
prepare to have the relevant CPU/cache intitialization done
by the kernel.

> Otherwise, you're more or less proposing a new run-time-environment
> that has to do all the hardware sanitizations and initializations before
we
> get to the bootstrap environment. That's going to be so system-specific
and
> disparate from the kernel that it doesn't, IMHO, make any sense to put it
> there.

Cache tag initialization is CPU-specific, not system specific.

>              This is especially true since *not* having it in the kernel
gives you
> the chance to exploit the same firmware environment for non-linux OS'es.

The systems I'm worried about don't *have* any non-Linux OSes.
I do not advocate unconditionally putting proper cache initialization
code into every MIPS/Linux kernel!  I wouldn't dream of preventing
some one else from putting their full faith in the perfectly understood
and well-documented bootloaders on their Indy or DECstation. ;-)
And people who have otherwise found it to be a reasonable design
trade off to build a cache-aware bootloader should not have to pay
the time or footprint to initialize the cache twice.

But so long as there are people who want to build new, specialized devices
running embedded Linux, it is in their interest that the MIPS/Linux kernel
distribution provide them with as much of the generic processor startup
functionality as possible, so that they can concentrate their energies
on making their products different and better instead of re-re-implementing
cache initialization code (and maybe getting it wrong).

But in any case, have no fear, I'm unlikely to be submitting
any such patch any time soon!

            Regards,

            Kevin K.
