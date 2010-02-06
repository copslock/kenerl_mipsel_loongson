Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2010 13:16:54 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:37339 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492034Ab0BFMQv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Feb 2010 13:16:51 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1Ndjak-0005vF-00; Sat, 06 Feb 2010 13:16:50 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 234DCC2C7A; Sat,  6 Feb 2010 13:16:22 +0100 (CET)
Date:   Sat, 6 Feb 2010 13:16:22 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: add 8250/16550 serial early printk driver
Message-ID: <20100206121622.GA8775@alpha.franken.de>
References: <20100205232857.eb65967f.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100205232857.eb65967f.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Feb 05, 2010 at 11:28:57PM +0900, Yoichi Yuasa wrote:
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  arch/mips/Kconfig.debug              |    8 ++++
>  arch/mips/include/asm/setup.h        |    9 ++++
>  arch/mips/kernel/Makefile            |    1 +
>  arch/mips/kernel/early_printk_8250.c |   68 ++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/kernel/early_printk_8250.c
> 
> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> index 32a010d..f5d739c 100644
> --- a/arch/mips/Kconfig.debug
> +++ b/arch/mips/Kconfig.debug
> @@ -20,6 +20,14 @@ config EARLY_PRINTK
>  	  doesn't cooperate with an X server. You should normally say N here,
>  	  unless you want to debug such a crash.
>  
> +config EARLY_PRINTK_8250
> [..]

have you looked at drivers/serial/8250_early.c ? It looks like it
was invented for some sort of early console on 8250 devices...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
