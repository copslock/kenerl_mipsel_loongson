Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2007 23:31:53 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:46727 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022957AbXDOWbv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2007 23:31:51 +0100
Received: from lagash (88-106-169-123.dynamic.dsl.as9105.com [88.106.169.123])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id D4D7EBBCA3;
	Mon, 16 Apr 2007 00:28:12 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HdDDD-0000Nx-8U; Sun, 15 Apr 2007 23:28:47 +0100
Date:	Sun, 15 Apr 2007 23:28:47 +0100
To:	tiansm@lemote.com
Cc:	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 2/16] arch related Makefile update for lemote fulong mini-PC
Message-ID: <20070415222847.GA1402@networkno.de>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11766507661726-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

tiansm@lemote.com wrote:
[snip]
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 92bca6a..2a6742d 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -118,6 +118,7 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
>  cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
>  cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
>  cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
> +cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap

I wonder why this is r4600. I heard the Loongson2 is MIPS IV compatible,
so r5000 / r8000 / r10000 would be better choices.


Thiemo
