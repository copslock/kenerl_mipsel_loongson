Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 22:02:06 +0200 (CEST)
Received: from pfepa.post.tele.dk ([195.41.46.235]:42065 "EHLO
        pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492389Ab0FAUCB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 22:02:01 +0200
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepa.post.tele.dk (Postfix) with ESMTP id 4EAD6A50006;
        Tue,  1 Jun 2010 22:01:59 +0200 (CEST)
Date:   Tue, 1 Jun 2010 22:02:00 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH -queue v2] MIPS: Move Alchemy Makefile parts to their
        own Platform file.
Message-ID: <20100601200200.GA5438@merkur.ravnborg.org>
References: <1275405795-9009-1-git-send-email-manuel.lauss@googlemail.com> <20100601163528.GA5216@merkur.ravnborg.org> <AANLkTikIiKmqjhuZKnguhyNeuCXnPeBLHSSeolCTf3d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTikIiKmqjhuZKnguhyNeuCXnPeBLHSSeolCTf3d0@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 26973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 678

On Tue, Jun 01, 2010 at 06:47:59PM +0200, Manuel Lauss wrote:
> On Tue, Jun 1, 2010 at 6:35 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Tue, Jun 01, 2010 at 05:23:15PM +0200, Manuel Lauss wrote:
> >> Cc: Sam Ravnborg <sam@ravnborg.org>
> >> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> >> ---
> >> On top of latest mips-queue.  The changes to the mtx1/xx1500 Makefiles were
> >> necessary to work around vmlinux link failures.
> >
> > Was this something the platform patches introduced or
> > is it needed to fix the build?
> 
> Maybe.  Link failures with the "lib-y" parts do crop up occasionally.
> Usually, the lib-y parts are built as the last files (along with other
> arch/mips/lib code); with your changes they're built with the other
> files in a directory:
>  CC      arch/mips/alchemy/mtx-1/platform.o
>   LD      arch/mips/alchemy/mtx-1/built-in.o
>   CC      arch/mips/alchemy/mtx-1/board_setup.o
>   CC      arch/mips/alchemy/mtx-1/init.o
>   AR      arch/mips/alchemy/mtx-1/lib.a
> 
> That lib.a is apparently not picked up by the linker:
>   LD      .tmp_vmlinux1

...

> > ...
> >> +#
> >> +# 4G-Systems eval board
> >> +#
> >> +platform-$(CONFIG_MIPS_MTX1) += alchemy/mtx-1/
> >> +load-$(CONFIG_MIPS_MTX1)     += 0xffffffff80100000
> >
> >> diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
> >> index 4a53815..4d1367e 100644
> >> --- a/arch/mips/alchemy/mtx-1/Makefile
> >> +++ b/arch/mips/alchemy/mtx-1/Makefile
> >> @@ -6,7 +6,6 @@
> >>  # Makefile for 4G Systems MTX-1 board.
> >>  #
> >>
> >> -lib-y := init.o board_setup.o
> >> -obj-y := platform.o
> >> +obj-y := init.o board_setup.o platform.o
> >>
> >>  EXTRA_CFLAGS += -Werror
> >

So the original ocde looked like this:

arch/mips/Makefile:
libs-$(CONFIG_MIPS_MTX1)        += arch/mips/alchemy/mtx-1/

The above is used to tell that it shall look for a lib.a
in the directory: arch/mips/alchemy/mtx-1/
It also tell kbuild to build any built-in or modules in the same dir. 

In your conversion this became:
platform-$(CONFIG_MIPS_MTX1) += alchemy/mtx-1/

The above tells kbuild to build objects as built-in or modules
in the directory. It does not say anything about libs.

So we loose the information about the lib.a in the directory.
I know that kbuild will build it - but it happens
to forget all about it when done.

The right fixs seems to keep the libs-$(...) assignments in
the Platform files and let kbuild pick them up due to
the include in arch/mips/Makefile.

This is not optimal and we may address this later.
But for now this looks like the simplest/safest way forward.

Getting rid of the libs like you did is also an option.
And if this is OK then this is the niver way to do it.
But I have not looked into this enough to judge.
Does the lib files contain stuff that is only used in some
confgurations or does the content end up being linked
in always anyway?
Also are there any linker order constrains to tke care of?

Lots of questions I know - sorry.

	Sam
