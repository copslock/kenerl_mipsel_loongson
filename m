Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4OFBlh19355
	for linux-mips-outgoing; Thu, 24 May 2001 08:11:47 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4OFBlF19352
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 08:11:47 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA20012;
	Thu, 24 May 2001 08:11:36 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA28775;
	Thu, 24 May 2001 08:11:33 -0700 (PDT)
Message-ID: <001101c0e464$72c130e0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Joe deBlaquiere" <jadb@redhat.com>, <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010524113444.6990B-100000@delta.ds2.pg.gda.pl>
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
Date: Thu, 24 May 2001 17:15:53 +0200
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

> > The problem is that, out in industry, not everyone wants to
> > build their entire userland from source, and nobody particularly 
> > wants to deal with  the product management problems of making, 
> > maintaining,  testing, and distributing all the permutations of BE/LE, 
> > FP/noFP, LLSC/noLLSC, etc, etc.
> 
>  First, we are talking about glibc and not the entire userland.

But since essentially the entire userland is linked with glibc,
I'm not sure how much that distinction matters, in practical
terms.

> I insist on having the performance-wise implementation in glibc.

Joe and I likewise insist on having a high-performance
implementation of glibc as the default.  The question is
whether it's to be one optimised for performance on R3000's
or on contemporary parts.  As has been stated by others,
of *course* one wants to be able to build it either way.
I'm simply saying that if one just does "./configure"
and "make" for glibc with a mips target, it should default
to use ll/sc, and that if one simply builds RPMs for binary
distribution of MIPS/Linux binaries, they should be linked
with a glibc that uses ll/sc.  And that therefore the MIPS/Linux
kernel for R3000's (and R4100's) should have ll/sc emulation 
support built in by default.

>  Second, do you expect everyone compiling the entire userland from
> sources?  I don't.  The normal approach is to take a distribution and
> build only these pieces which are not satisfying for one reason or
> another.  Just take an ISA I, ISA II or whatever version you need.

>From where?  I'd love to find a decently complete (with compilers,
networking tools, X, etc.) mipsel distribution of any MIPS ISA level 
less that MIPS V to replace the antique crud that runs on my mipsel 
platform.

>  Fourth, maintaining differently optimized distributions is not that
> troublesome.

Please don't get me wrong here, because I tremendously
respect the work that you've been doing for MIPS/Linux,
but how many differently optimised distributions do you
presonally build, distribute, support, and maintain?

            Regards,

            Kevin K.
