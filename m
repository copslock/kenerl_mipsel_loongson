Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PEtiE16690
	for linux-mips-outgoing; Mon, 25 Mar 2002 06:55:44 -0800
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PEtcq16669
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 06:55:38 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id GAA18384;
	Mon, 25 Mar 2002 06:57:54 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id GAA00048;
	Mon, 25 Mar 2002 06:57:51 -0800 (PST)
Message-ID: <00e901c1d40d$a257a200$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Johannes Stezenbach" <js@convergence.de>, <linux-mips@oss.sgi.com>
References: <20020325135834.GA1736@convergence.de>
Subject: Re: Mips16 toolchain?
Date: Mon, 25 Mar 2002 15:59:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I saw that the algorithmics toolchain (which Dominic Sweetman
> offered to the Linux/MIPS community here a month ago) claims
> to have full support for the mips16 instruction set.
> 
> My questions:
> Does anyone here have experiences with mips16 and/or with the
> algorithmics toolchain?

Yes.  Both Algorithmics and Green Hills embedded
tool chains support it reasonably well.  GHS has no
Linux target, though.  Algorithmics has been working
on one, but I'm not sure what it's current status is.

> Is there working support for mips16 in any other gcc-version?

Cygnus (now part of Red Hat) did the very first MIPS16
support for gcc, most of which found its way into the
main development/maintence stream.  But apparently
not enough of it, based on your experience.

> How about gcc-3.x from CVS?

No data there.

> Any other comments or recommendations regarding mips16?

MIPS16 requires more than just gcc support.
One needs a binutils that can distinguish a MIPS16
binary module (or function if you want to be fancy and 
mix/match within modules)  from a MIPS32/64 module
and perform fixups so that the right selections are made
between JAL and JALX on function invocations.  
If you've got that, you should not need a seperate 
MIPS16 libc.

To correctly support MIPS16, the Linux kernel does
need to be tweaked in those cases where user-mode
instructions are decoded and interpreted, as in
arch/mips/kernel/branch.c and unaligned.c.
I believe that code has been prototyped somewhere,
but it's not yet in any commonly used repository to
the best of my knowledge.  If you avoid throwing
executing non-instructions, performing unaligned 
accesses, etc, you should be able to tiptoe around
that deficiency.

            Regards,

            Kevin K.
