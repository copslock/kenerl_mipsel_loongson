Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 16:56:48 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:65411 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022843AbXCZP4q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2007 16:56:46 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 1D0C6B8419;
	Mon, 26 Mar 2007 17:56:11 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HVrYg-0004gx-0U; Mon, 26 Mar 2007 16:56:34 +0100
Date:	Mon, 26 Mar 2007 16:56:33 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	kumba@gentoo.org, linux-mips@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Message-ID: <20070326155633.GE23564@networkno.de>
References: <4606AA74.3070907@gentoo.org> <20070325221919.GA12088@linux-mips.org> <cda58cb80703260654u4435b90axa28507f6c9011c00@mail.gmail.com> <20070326.234821.30439266.anemo@mba.ocn.ne.jp> <cda58cb80703260831t576ff7c5wef1e34e3367e7c45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80703260831t576ff7c5wef1e34e3367e7c45@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Hi Atsushi,
> 
> On 3/26/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >One thing I noticed recently: Your patchset dropped gcc test for
> >availability of -msym32, so may not work with gcc 3.x.
> >
> 
> I suspect you're asking why I did not do this:
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 3ec0c12..b0d8240 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -627,7 +627,7 @@ ifdef CONFIG_64BIT
>   endif
> 
>   ifeq ($(KBUILD_SYM32), y)
> -    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
> +    cflags-y += $(call cc-option,-msym32) -DKBUILD_64BIT_SYM32
>   endif
> endif
> 
> I remove the call to cc-option because this function removes
> _silently_ '-msym32' option if it's not supported by the compiler. IOW
> it's really not what we want.

It is _exactly_ what we want. -msym32 is always an optional optimization.


Thiemo
