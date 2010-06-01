Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 18:35:50 +0200 (CEST)
Received: from pqueuea.post.tele.dk ([193.162.153.9]:35291 "EHLO
        pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491190Ab0FAQfn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 18:35:43 +0200
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
        by pqueuea.post.tele.dk (Postfix) with ESMTP id 2FEEFDBBFA
        for <linux-mips@linux-mips.org>; Tue,  1 Jun 2010 18:35:42 +0200 (CEST)
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepb.post.tele.dk (Postfix) with ESMTP id 44931F84031;
        Tue,  1 Jun 2010 18:35:28 +0200 (CEST)
Date:   Tue, 1 Jun 2010 18:35:28 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH -queue v2] MIPS: Move Alchemy Makefile parts to their
        own Platform file.
Message-ID: <20100601163528.GA5216@merkur.ravnborg.org>
References: <1275405795-9009-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275405795-9009-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 26969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 503

On Tue, Jun 01, 2010 at 05:23:15PM +0200, Manuel Lauss wrote:
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> On top of latest mips-queue.  The changes to the mtx1/xx1500 Makefiles were
> necessary to work around vmlinux link failures.

Was this something the platform patches introduced or
is it needed to fix the build?
In the first case I have broken something I need to fix.
In the latter case this should be a seperate patch (that comes first).

> diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
> new file mode 100644
> index 0000000..495cc9a
> --- /dev/null
> +++ b/arch/mips/alchemy/Platform

...
> +#
> +# 4G-Systems eval board
> +#
> +platform-$(CONFIG_MIPS_MTX1)	+= alchemy/mtx-1/
> +load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000

> diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
> index 4a53815..4d1367e 100644
> --- a/arch/mips/alchemy/mtx-1/Makefile
> +++ b/arch/mips/alchemy/mtx-1/Makefile
> @@ -6,7 +6,6 @@
>  # Makefile for 4G Systems MTX-1 board.
>  #
>  
> -lib-y := init.o board_setup.o
> -obj-y := platform.o
> +obj-y := init.o board_setup.o platform.o
>  
>  EXTRA_CFLAGS += -Werror

In the above we added alchemy/mtx-1/ to platform-y
so mtx-1/ is automatically covered by -Werror by arch/mips/Kbuild

So the above assignment to EXTRA_CFLAGS is now redundant and can be dropped.

	Sam
