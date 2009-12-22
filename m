Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2009 02:36:13 +0100 (CET)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:50975 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1495126AbZLVBgJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2009 02:36:09 +0100
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAMaxL0urRN+J/2dsb2JhbADAK5ZBhC4E
X-IronPort-AV: E=Sophos;i="4.47,434,1257120000"; 
   d="scan'208";a="66029901"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-4.cisco.com with ESMTP; 22 Dec 2009 01:35:47 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nBM1ZlmA007641;
        Tue, 22 Dec 2009 01:35:47 GMT
Date:   Mon, 21 Dec 2009 17:35:47 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/5] MIPS: remove powertv mips_machine_halt()
Message-ID: <20091222013547.GC24784@dvomlehn-lnx2.corp.sa.net>
References: <20091218212917.f42e8180.yuasa@linux-mips.org> <20091218213018.79a9fc11.yuasa@linux-mips.org> <20091218213346.01f63eac.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091218213346.01f63eac.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Fri, Dec 18, 2009 at 09:33:46PM +0900, Yoichi Yuasa wrote:
> mips_machine_halt() is same as mips_machine_restart().
> In addition, the registration of _machine_halt and pm_power_off are deleted.
> because mips_machine_halt() is restart function.
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  arch/mips/powertv/reset.c |   18 ------------------
>  1 files changed, 0 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/mips/powertv/reset.c b/arch/mips/powertv/reset.c
> index 494c652..0007652 100644
> --- a/arch/mips/powertv/reset.c
> +++ b/arch/mips/powertv/reset.c
> @@ -28,9 +28,6 @@
>  #include <asm/mach-powertv/asic_regs.h>
>  #include "reset.h"
>  
> -static void mips_machine_restart(char *command);
> -static void mips_machine_halt(void);
> -
>  static void mips_machine_restart(char *command)
>  {
>  #ifdef CONFIG_BOOTLOADER_DRIVER
> @@ -44,22 +41,7 @@ static void mips_machine_restart(char *command)
>  #endif
>  }
>  
> -static void mips_machine_halt(void)
> -{
> -#ifdef CONFIG_BOOTLOADER_DRIVER
> -	/*
> -	 * Call the bootloader's reset function to ensure
> -	 * that persistent data is flushed before hard reset
> -	 */
> -	kbldr_SetCauseAndReset();
> -#else
> -	writel(0x1, asic_reg_addr(watchdog));
> -#endif
> -}
> -
>  void mips_reboot_setup(void)
>  {
>  	_machine_restart = mips_machine_restart;
> -	_machine_halt = mips_machine_halt;
> -	pm_power_off = mips_machine_halt;
>  }
> -- 
> 1.6.5.7
> 
> 

oks good, thanks!
Reviewed-by: David VomLehn (dvomlehn@cisco.com)
