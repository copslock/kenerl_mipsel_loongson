Received:  by oss.sgi.com id <S553834AbQJNPJy>;
	Sat, 14 Oct 2000 08:09:54 -0700
Received: from u-97.karlsruhe.ipdial.viaginterkom.de ([62.180.10.97]:30474
        "EHLO u-97.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553827AbQJNPJo>; Sat, 14 Oct 2000 08:09:44 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870076AbQJNPJ2>;
        Sat, 14 Oct 2000 17:09:28 +0200
Date:   Sat, 14 Oct 2000 17:09:28 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jay Carlson <nop@nop.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001014170928.B6499@bacchus.dhis.org>
References: <20001014055550.B3816@bacchus.dhis.org> <KEEOIBGCMINLAHMMNDJNKECACAAA.nop@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <KEEOIBGCMINLAHMMNDJNKECACAAA.nop@nop.com>; from nop@nop.com on Sat, Oct 14, 2000 at 10:51:37AM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 10:51:37AM -0400, Jay Carlson wrote:

> Hey, don't blame me for the 2.0.6->2.0.7 version bump.  I just grabbed the
> biggest version number on oss.sgi.com at the time and made my *trivial*
> patches to add softfloat to the build.
> 
> Let me say that again: 2.0.7 is NOT MY FAULT.

I didn't blame you - I didn't even know how came up with 2.0.7-mips.  When I
receive bug reports against the various 2.0.7 incarnations I just usually
find that they're that particular 2.0.7 version has bugs which were fixed
eternities ago.

2.0.7 as used by the distributors is probably a reasonably sane libc.

Do your softfp patches somehow cause problems with hardware fp machines?
If not we could throw all things together.

> Seriously, I think the best thing we can do in this situation is start
> assigning our own linux-mips version numbers to combinations of upstream
> sources and our patches.  So, we'd have something like:
> 
>   glibc 2.0.6 + 05lm patches (whatever) == glibc2.0.6 delta 1.0
>   glibc 2.0.6 + 06lm patches (whatever) == glibc2.0.6 delta 1.1
> 
>   egcs 1.0.3a + ralf's current patches == egcs 1.0.3a delta 1.0
>   egcs 1.0.3a + ralf's patches tomorrow == egcs 1.0.3a delta 2.0
> 
>   binutils 2.8.1 + standard patches == binutils 2.8.1 delta 1.0
>   binutils 2.10.x on 20001014 == binutils 2.10.x delta 1.0
>   binutils 2.10.x on 20001015 == binutils 2.10.x delta 2.1
> 
> We need to give *names* to the versions of the software we're testing
> against.  I haven't bothered trying a world rebuild against gcc 2.96.x
> because telling people it worked wouldn't mean anything.  Other people would
> not know that they could reproduce my success by getting the same bits as
> me.
> 
> What I really want to hear is: "I rebuilt gcc, binutils, the kernel,
> modutils, and GNU fileutils using gcc 2.96 delta 7.3, binutils 2.10.x delta
> 5.2, and glibc 2.1.95 delta 1.0", and then know EXACTLY how to reproduce
> that at home.  Just saying "current CVS with patches" doesn't help with
> reproducibility.

Actually I'm trying to kill this entire naming problem by getting all
patches back to the respective maintainers.  Result:  no pending patches
for cvs binutils, only tiny ones for glibc-current and egcs-current.

Naming the patches is a nice idea but frequently I find my own patches
again on some server with creativly changed names.  There is just nobody
who controls the namespace for those patches.

  Ralf
