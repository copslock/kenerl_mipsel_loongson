Received:  by oss.sgi.com id <S553753AbQJRV0q>;
	Wed, 18 Oct 2000 14:26:46 -0700
Received: from u-11.karlsruhe.ipdial.viaginterkom.de ([62.180.19.11]:23310
        "EHLO u-11.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553752AbQJRV0W>; Wed, 18 Oct 2000 14:26:22 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869077AbQJRUbD>;
        Wed, 18 Oct 2000 22:31:03 +0200
Date:   Wed, 18 Oct 2000 22:31:03 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jay Carlson <nop@nop.com>
Cc:     Mike Klar <mfklar@ponymail.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001018223103.H7865@bacchus.dhis.org>
References: <20001016140005.C17878@bacchus.dhis.org> <KEEOIBGCMINLAHMMNDJNAECECAAA.nop@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <KEEOIBGCMINLAHMMNDJNAECECAAA.nop@nop.com>; from nop@nop.com on Tue, Oct 17, 2000 at 09:59:49PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 17, 2000 at 09:59:49PM -0400, Jay Carlson wrote:

> Ah yes, this has bit me a few times even with my hacked 2.95.2.  I think
> this is what the libc-hacker people were talking about in terms of glibc
> mistakenly reexporting the exception handing stuff.  I don't remember them
> being very happy about it.

It's FAQ.  In short their answer is to not use a newer compiler than
egcs 2.7.2 (or was it 2.8.1?).  Hardly acceptable for us.  Anyway, glibc 2.2
cleans up with that; a few programs need recompiling and where this is
not an option there is a small library that can be pre-loaded and which
will satisfy any references.

> > I would prefer to see that this patch using some mechanism which detects
> > the precense / absence of hardware fp at runtime and behaves accordingly.
> 
> I don't think this is necessary for any correctly built and linked
> executable.
> 
> On platforms with no hardware FPU and no kernel emulation, any main program
> or library trying to touch a floating point variable will immediately bomb,
> so there is no chance of undiagnosed incorrect behavior.
> 
> On machines with FPUs, setjmp/longjmp between modules that disagree on
> __HAVE_FPU__ will result in the callee-saved FPU registers not being
> saved/restored properly, and that will be a silent failure.  On the other
> hand, any intercall between modules where a float as an argument or return
> value will silently fail too.
> 
> The most plausible failure case I can think of is on a machine with
> hardware/kernel FPU.  A softfloat main program calls some kind of hardfloat
> plugin .so, solely using integer arguments/return values.  However, the
> plugin was built hardfp, and gets upset when the FP control word isn't
> initialized...
> 
> I dunno.  I just don't see softfp binaries ever showing up on hardfp
> platforms, aside from the proposed Linux VR transition to hardfp.

Ok.  Then we just need to make sure that people don't mix objects.

  Ralf
