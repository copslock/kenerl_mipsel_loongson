Received:  by oss.sgi.com id <S553781AbQJPLYt>;
	Mon, 16 Oct 2000 04:24:49 -0700
Received: from chmls06.mediaone.net ([24.147.1.144]:63228 "EHLO
        chmls06.mediaone.net") by oss.sgi.com with ESMTP id <S553774AbQJPLYb>;
	Mon, 16 Oct 2000 04:24:31 -0700
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls06.mediaone.net (8.8.7/8.8.7) with SMTP id HAA08318;
	Mon, 16 Oct 2000 07:24:24 -0400 (EDT)
From:   "Jay Carlson" <nop@nop.com>
To:     "Mike Klar" <mfklar@ponymail.com>,
        "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Jay Carlson" <nop@place.org>, <linux-mips@fnet.fr>,
        <linux-mips@oss.sgi.com>
Subject: RE: stable binutils, gcc, glibc ...
Date:   Mon, 16 Oct 2000 07:26:19 -0400
Message-ID: <KEEOIBGCMINLAHMMNDJNOECBCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <NDBBIDGAOKMNJNDAHDDMAENPCMAA.mfklar@ponymail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

OK, might as well get this into the list archives......

Mike Klar writes:

> Ralf Baechle wrote:
>
> > Have the other tools - in particular binutils and gcc actually
> > been modified
> > except maybe changing defaults?
>
> binutils we use unmodified from the cross- SRPM on ftp://oss.sgi.com.

Right.  Exact version of 2.8.1 was: cross-binutils-2.8.1-1.src.rpm

> egcs-1.0.3a did require a small patch, which Jay has at:
> ftp://ftp.place.org/pub/nop/linuxce/egcs-1.0.3a-mips-softfloat.patch
> I've reworked it slightly to patch cleanly against the latest Linux-MIPS
> egcs-1.0.3a release, but the server that's on is a bit whacked at
> the moment
> (the patch conflict was pretty trivial, though...).

The patch does three things:

1) turns on multilib support for -msoft-float.  (This makes gcc install two
versions of libgcc.a etc: one in the lib/libgcc.a, one in
lib/softfloat/libgcc.a.)

2) asks the build process to include the actual soft float implementation
(fp-bit.c) in libgcc.a.  Note that this is probably not the optimal place
for it in the long run, because these functions should be shared.  I'm
pretty sure glibc 2.2 has them there, which isn't so bad a spot.

3) chooses the soft float API (function names, arg order).  Because every
other MIPS configuration included with gcc ignores the native GNU naming
convention in favor of the GOFAST API, I chose GOFAST.  I figured that the
sins of GOFAST's namespace pollution could be overlooked because Cygnus
would be more likely to fix mips softfloat problems that affected paying
embedded customers.   glibc's choice of native GNU naming convention makes
me regret this.

I think there will have to be a flag day eventually  because of 2 and/or 3.
Luckily, we can rebuild all the binaries we have without TOO much pain.  The
issue can be put off until we're ready to start using glibc 2.2, which may
be a while.

Does anyone know if gcc 2.97 can build glibc 2.0.x?

All of this is making me reconsider my request to install softfloat multilib
into gcc 2.97.  I don't understand how it will interact with glibc 2.2 yet.

> We actually did not change the compiler default from hard-float,

That's right.  For linux-vr, CC="mipsel-linux-gcc -msoft-float".

For the record, the glibc patch does two things:

1) longjmp/setjmp will only save FPU registers if __HAVE_FPU__ is defined.
In unmodified egcs 1.0.3a, "%{!msoft-float: -D__HAVE_FPU__ }".

2) conditionalizes _FPU_GETCW and _FPU_SETCW in fpu_control.h.  If I recall
correctly, _FPU_SETCW() is called early in program startup, even for
programs that will never touch the FPU.  This of course causes instant death
unless the kernel can emulate "ctc1 foo,$31"....

Let me know if this is boring you decstation folks.  By the way, anybody in
the Boston area want a free 5000/120?

Jay
