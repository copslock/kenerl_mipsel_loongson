Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 23:19:00 +0200 (CEST)
Received: from pqueuea.post.tele.dk ([193.162.153.9]:58109 "EHLO
        pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492232Ab0EaVS5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 May 2010 23:18:57 +0200
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
        by pqueuea.post.tele.dk (Postfix) with ESMTP id 0A846DBEE5
        for <linux-mips@linux-mips.org>; Mon, 31 May 2010 23:18:56 +0200 (CEST)
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepb.post.tele.dk (Postfix) with ESMTP id 730A5F84028;
        Mon, 31 May 2010 23:18:42 +0200 (CEST)
Date:   Mon, 31 May 2010 23:18:42 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH -queue] MIPS: Move Alchemy Makefile parts to their own
        Platform file.
Message-ID: <20100531211842.GA795@merkur.ravnborg.org>
References: <1275332878-19762-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275332878-19762-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

Hi Manuel.

A few comments below.

> 
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index 681b2d4..18eff23 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -1,6 +1,6 @@
>  # All platforms listed in alphabetic order
>  
> -platforms += ar7
> +platforms += alchemy ar7

One line per paltform is better.
Then the risk for conflicts are less and merging in easier.
Like this:

platforms += ar7
platforms += alchemy

But this is a nitpick only.

> diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
> new file mode 100644
> index 0000000..1994fdc
> --- /dev/null
> +++ b/arch/mips/alchemy/Platform
> @@ -0,0 +1,103 @@
> +#
> +# Common Alchemy Au1x00 stuff
> +#
> +core-$(CONFIG_SOC_AU1X00)	+= arch/mips/alchemy/common/

The above is actually wrong - despite that it works.
You are supposed to use:

platform-$(CONFIG_SOC_AU1X00) += alchemy/common/

Then arch/mips/Kbuild will pick it up.
And then subdirs-ccflags-y := -Werror will also take effect.

The reason why it works now is that the core-y assignment is
picked up by arch/mips/Makefile.

I could do something to avoid this but I hope this is not needed.

You use core-$(...) in many places that all needs fixing.

	Sam
