Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3792FO18261
	for linux-mips-outgoing; Sat, 7 Apr 2001 02:02:15 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3792EM18258
	for <linux-mips@oss.sgi.com>; Sat, 7 Apr 2001 02:02:14 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA19127;
	Sat, 7 Apr 2001 02:02:13 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA05582;
	Sat, 7 Apr 2001 02:02:03 -0700 (PDT)
Message-ID: <004f01c0bf41$fe823720$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Florian Lohoff" <flo@rfc822.org>, <debian-mips@lists.debian.org>,
   <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010406182059.15958E-100000@delta.ds2.pg.gda.pl>
Subject: Re: first packages for mipsel
Date: Sat, 7 Apr 2001 11:05:56 +0200
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

Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> On Fri, 6 Apr 2001, Kevin D. Kissell wrote:
>
> > What advantage would there be to using sysmips() as opposed
> > to doing the ll/sc emulation?  It seems to me that the decode path
> > in the kernel would be just as fast, and there would be a single
> > "ABI" for all programs - the ll/sc instructions themselves.
>
>  It was discussed a few times already.  It's ugly and is an overkill for
> UP machines -- you take at least two faults for ll/sc emulation and only a
> single syscall for TAS.

Depends on your point of view.  Syscalls will be faster than
emulation on processors without LL/SC support, certainly,
but much slower than just executing the instructions on processors
that do support LL/SC.  Intuitively, emulation would be roughly
2x worse for an R3K, but a syscall will be 10-100 times worse
for an R4K.  If we gave an equal weight to both families, that
would argue in favor of LL/SC emulation - and working for
MIPS Technologies (where all our designs for the past
10 years have supported LL/SC) I would consider equal
weighting to be very generous!  ;-)

I've seen the hybrid proposal of having libc determine the LL/SC
capability of the processor and either executing the instructions
or doing the syscall as appropriate. While that would allow
near-optimal performance on all systems, I find it troublesome,
both on the principle that the OS should conceal hardware
implementation details from the user, and on the practical basis
that glibc is the last place I would want to put more CPU-specific
cruft.  But reasonable people can disagree.

            Kevin K.
