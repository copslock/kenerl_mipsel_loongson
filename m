Received:  by oss.sgi.com id <S553705AbQJRB6M>;
	Tue, 17 Oct 2000 18:58:12 -0700
Received: from chmls06.mediaone.net ([24.147.1.144]:40098 "EHLO
        chmls06.mediaone.net") by oss.sgi.com with ESMTP id <S553717AbQJRB56>;
	Tue, 17 Oct 2000 18:57:58 -0700
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls06.mediaone.net (8.8.7/8.8.7) with SMTP id VAA22895;
	Tue, 17 Oct 2000 21:57:55 -0400 (EDT)
From:   "Jay Carlson" <nop@nop.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>, "Jay Carlson" <nop@place.org>
Cc:     "Mike Klar" <mfklar@ponymail.com>, "Jay Carlson" <nop@place.org>,
        <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
Subject: RE: stable binutils, gcc, glibc ...
Date:   Tue, 17 Oct 2000 21:59:49 -0400
Message-ID: <KEEOIBGCMINLAHMMNDJNAECECAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20001016140005.C17878@bacchus.dhis.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle [mailto:ralf@oss.sgi.com] writes:

> > Does anyone know if gcc 2.97 can build glibc 2.0.x?
>
> As I already wrote in my other email this seems to work.  However there is
> a little minefiled hidden there which I should warn you about.  Sometimes
> gcc emits references to __register_frame_info which is a libgcc defined
> symbol.  This function happened to be defined coincidntally in libtermcap
> and a few others such that these references so far usually were satisfied.
> Now built with gcc 2.97 libtermcap no longer defines this symbol and so a
> few programs like for example mutt2 or bash2 will die therefore.

Ah yes, this has bit me a few times even with my hacked 2.95.2.  I think
this is what the libc-hacker people were talking about in terms of glibc
mistakenly reexporting the exception handing stuff.  I don't remember them
being very happy about it.

> > For the record, the glibc patch does two things:
> >
> > 1) longjmp/setjmp will only save FPU registers if __HAVE_FPU__
> is defined.
> > In unmodified egcs 1.0.3a, "%{!msoft-float: -D__HAVE_FPU__ }".
> >
> > 2) conditionalizes _FPU_GETCW and _FPU_SETCW in fpu_control.h.
> If I recall
> > correctly, _FPU_SETCW() is called early in program startup, even for
> > programs that will never touch the FPU.  This of course causes
> instant death
> > unless the kernel can emulate "ctc1 foo,$31"....
>
> I would prefer to see that this patch using some mechanism which detects
> the precense / absence of hardware fp at runtime and behaves accordingly.

I don't think this is necessary for any correctly built and linked
executable.

On platforms with no hardware FPU and no kernel emulation, any main program
or library trying to touch a floating point variable will immediately bomb,
so there is no chance of undiagnosed incorrect behavior.

On machines with FPUs, setjmp/longjmp between modules that disagree on
__HAVE_FPU__ will result in the callee-saved FPU registers not being
saved/restored properly, and that will be a silent failure.  On the other
hand, any intercall between modules where a float as an argument or return
value will silently fail too.

The most plausible failure case I can think of is on a machine with
hardware/kernel FPU.  A softfloat main program calls some kind of hardfloat
plugin .so, solely using integer arguments/return values.  However, the
plugin was built hardfp, and gets upset when the FP control word isn't
initialized...

I dunno.  I just don't see softfp binaries ever showing up on hardfp
platforms, aside from the proposed Linux VR transition to hardfp.

Jay
