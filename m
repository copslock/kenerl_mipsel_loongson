Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4SGLJQ30012
	for linux-mips-outgoing; Mon, 28 May 2001 09:21:19 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4SGLId30009
	for <linux-mips@oss.sgi.com>; Mon, 28 May 2001 09:21:18 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA17192;
	Mon, 28 May 2001 09:21:12 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA29013;
	Mon, 28 May 2001 09:21:09 -0700 (PDT)
Message-ID: <00d001c0e792$d48b14e0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010528173758.15200K-100000@delta.ds2.pg.gda.pl>
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
Date: Mon, 28 May 2001 18:25:28 +0200
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

> > Export the existance of ll/sc via /proc/cpuinfo or whatever.
>
>  That's a valid approach and also nothing new to glibc -- see Alpha and
> in()/out() support.  But do we want an extra overhead due to an indirect
> call?  Especially as _test_and_set() gets usually inlined?

Use a global variable testable by the inline code?

> > I dont think this is true necessarly - There are still people building
> > embedded x86 systems based on 386 cores. Look at the vr41xx systems -
They
> > do also lack the ll/sc afaik. This is nowadays the most commonly
> > used embedded/pda cpu.
>
>  Are vr41xx plain ISA I or crippled ISA II+ CPUs?

Actually, they are crippled MIPS III+ 64-bit CPUs
(with added stuff like16x16 bit MAC instructions!).

            Kevin K.
