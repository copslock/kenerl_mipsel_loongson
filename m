Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 17:38:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59504 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013045AbbE1PiJDqADv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 May 2015 17:38:09 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4SFcAQq008494;
        Thu, 28 May 2015 17:38:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4SFc9fC008493;
        Thu, 28 May 2015 17:38:09 +0200
Date:   Thu, 28 May 2015 17:38:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Laurent Fasnacht <l@libres.ch>
Cc:     linux-mips@linux-mips.org, trivial@kernel.org
Subject: Re: [PATCH] MIPS: ath79: fix build problem if CONFIG_BLK_DEV_INITRD
 is not set
Message-ID: <20150528153808.GA7012@linux-mips.org>
References: <556603C8.5010502@libres.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556603C8.5010502@libres.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, May 27, 2015 at 07:50:00PM +0200, Laurent Fasnacht wrote:

> initrd_start is defined in init/do_mounts_initrd.c, which is only
> included in kernel if CONFIG_BLK_DEV_INITRD=y.
> 
> Signed-off-by: Laurent Fasnacht <l@libres.ch>
> ---
>  arch/mips/ath79/prom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
> index e1fe630..597899a 100644
> --- a/arch/mips/ath79/prom.c
> +++ b/arch/mips/ath79/prom.c
> @@ -1,6 +1,7 @@
>  /*
>   *  Atheros AR71XX/AR724X/AR913X specific prom routines
>   *
> + *  Copyright (C) 2015 Laurent Fasnacht <l@libres.ch>
>   *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
>   *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
>   *
> @@ -25,12 +26,14 @@ void __init prom_init(void)
>  {
>  	fw_init_cmdline();
XXX
>  +#ifdef CONFIG_BLK_DEV_INITRD
>  	/* Read the initrd address from the firmware environment */
>  	initrd_start = fw_getenvl("initrd_start");
>  	if (initrd_start) {
>  		initrd_start = KSEG0ADDR(initrd_start);
>  		initrd_end = initrd_start + fw_getenvl("initrd_size");
>  	}
> +#endif
>  }
XXX
>   void __init prom_free_prom_memory(void)

This patch is corrupt.  Please check how you send out your patches.
The lines which I marked with XXX should be blank lines containing just
one space character.  Instead the lines were removed and the space
inserted into the following line.  Because this patch is trivial I
fix that manually but please sort our your patch submission process
for the future.

Also note that adding two lines in most jurisdictions doesn't constitute
something copyrightable, adding a copyright notice or not.

Thanks,

  Ralf
