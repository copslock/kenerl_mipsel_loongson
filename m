Received:  by oss.sgi.com id <S553767AbQJPS3n>;
	Mon, 16 Oct 2000 11:29:43 -0700
Received: from u-55.karlsruhe.ipdial.viaginterkom.de ([62.180.19.55]:49931
        "EHLO u-55.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553760AbQJPS33>; Mon, 16 Oct 2000 11:29:29 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869487AbQJPMAF>;
        Mon, 16 Oct 2000 14:00:05 +0200
Date:   Mon, 16 Oct 2000 14:00:05 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jay Carlson <nop@nop.com>
Cc:     Mike Klar <mfklar@ponymail.com>, Jay Carlson <nop@place.org>,
        linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001016140005.C17878@bacchus.dhis.org>
References: <NDBBIDGAOKMNJNDAHDDMAENPCMAA.mfklar@ponymail.com> <KEEOIBGCMINLAHMMNDJNOECBCAAA.nop@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <KEEOIBGCMINLAHMMNDJNOECBCAAA.nop@nop.com>; from nop@nop.com on Mon, Oct 16, 2000 at 07:26:19AM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 16, 2000 at 07:26:19AM -0400, Jay Carlson wrote:

> 1) turns on multilib support for -msoft-float.  (This makes gcc install two
> versions of libgcc.a etc: one in the lib/libgcc.a, one in
> lib/softfloat/libgcc.a.)
> 
> 2) asks the build process to include the actual soft float implementation
> (fp-bit.c) in libgcc.a.  Note that this is probably not the optimal place
> for it in the long run, because these functions should be shared.  I'm
> pretty sure glibc 2.2 has them there, which isn't so bad a spot.
> 
> 3) chooses the soft float API (function names, arg order).  Because every
> other MIPS configuration included with gcc ignores the native GNU naming
> convention in favor of the GOFAST API, I chose GOFAST.  I figured that the
> sins of GOFAST's namespace pollution could be overlooked because Cygnus
> would be more likely to fix mips softfloat problems that affected paying
> embedded customers.   glibc's choice of native GNU naming convention makes
> me regret this.
> 
> I think there will have to be a flag day eventually  because of 2 and/or 3.
> Luckily, we can rebuild all the binaries we have without TOO much pain.  The
> issue can be put off until we're ready to start using glibc 2.2, which may
> be a while.
> 
> Does anyone know if gcc 2.97 can build glibc 2.0.x?

As I already wrote in my other email this seems to work.  However there is
a little minefiled hidden there which I should warn you about.  Sometimes
gcc emits references to __register_frame_info which is a libgcc defined
symbol.  This function happened to be defined coincidntally in libtermcap
and a few others such that these references so far usually were satisfied.
Now built with gcc 2.97 libtermcap no longer defines this symbol and so a
few programs like for example mutt2 or bash2 will die therefore.

If you then go and rebuild mutt / bash2 themselfes the static linker will
pull this function from libgcc.a and things will work again.  By then
everything will be like it was intended to be but still this means some
compatibility problem with older shared binaries..

> All of this is making me reconsider my request to install softfloat multilib
> into gcc 2.97.  I don't understand how it will interact with glibc 2.2 yet.

> For the record, the glibc patch does two things:
> 
> 1) longjmp/setjmp will only save FPU registers if __HAVE_FPU__ is defined.
> In unmodified egcs 1.0.3a, "%{!msoft-float: -D__HAVE_FPU__ }".
> 
> 2) conditionalizes _FPU_GETCW and _FPU_SETCW in fpu_control.h.  If I recall
> correctly, _FPU_SETCW() is called early in program startup, even for
> programs that will never touch the FPU.  This of course causes instant death
> unless the kernel can emulate "ctc1 foo,$31"....

I would prefer to see that this patch using some mechanism which detects
the precense / absence of hardware fp at runtime and behaves accordingly.

You can implement this by protecting the ctc instruction in _FPU_SETCW with
a signal handler.  This already happens during the early libc startup, so
we can remember if we got have a FPU and use this again in setjmp & co.

> Let me know if this is boring you decstation folks.  By the way, anybody in
> the Boston area want a free 5000/120?

Anybody got me a free Indy power supply ...

  Ralf
