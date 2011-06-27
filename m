Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 14:58:02 +0200 (CEST)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:40981 "EHLO
        mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491917Ab1F0M5z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jun 2011 14:57:55 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id 428F51B4241;
        Mon, 27 Jun 2011 21:57:51 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Mon, 27 Jun 2011 21:57:51 +0900 (JST)
Date:   Mon, 27 Jun 2011 21:57:47 +0900 (JST)
Message-Id: <20110627.215747.208961032.anemo@mba.ocn.ne.jp>
To:     ralf@linux-mips.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] NET: TC35815: Only build driver on Toshiba eval boards.
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20110625165409.GA1760@linux-mips.org>
References: <20110625165409.GA1760@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 30520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21819

On Sat, 25 Jun 2011 17:54:09 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> That's the only place where the TC35815 is known to be used.
> 
>   Ralf
> 
>  drivers/net/Kconfig |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index be25e92..2b4ebfb 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -1516,7 +1516,8 @@ config CS89x0_NONISA_IRQ
>  
>  config TC35815
>  	tristate "TOSHIBA TC35815 Ethernet support"
> -	depends on NET_PCI && PCI && MIPS
> +	depends on NET_PCI && PCI && MACH_TXX9
> +	default y
>  	select PHYLIB
>  
>  config E100

Yes, OK for me.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
