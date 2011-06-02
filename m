Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 03:51:56 +0200 (CEST)
Received: from mprc.pku.edu.cn ([162.105.203.9]:45663 "EHLO mprc.pku.edu.cn"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491784Ab1FBBvt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Jun 2011 03:51:49 +0200
Received: from [192.168.0.106] ([162.105.80.111])
        (authenticated bits=0)
        by mprc.pku.edu.cn (8.13.8/8.13.8) with ESMTP id p52282b3006876;
        Thu, 2 Jun 2011 10:08:02 +0800
Subject: Re: [PATCH] Fix build warning of the defconfigs
From:   Guan Xuetao <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
To:     Wanlong Gao <wanlong.gao@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux@arm.linux.org.uk, hans-christian.egtvedt@atmel.com,
        vapier@gentoo.org, ralf@linux-mips.org, benh@kernel.crashing.org,
        paulus@samba.org, lethal@linux-sh.org, david.woodhouse@intel.com,
        akpm@linux-foundation.org, u.kleine-koenig@pengutronix.de,
        mingo@elte.hu, rientjes@google.com, w.sang@pengutronix.de,
        sam@ravnborg.org, manuel.lauss@googlemail.com, anton@samba.org,
        arnd@arndb.de
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: MPRC, PKU
Date:   Thu, 02 Jun 2011 17:49:17 +0800
Message-ID: <1307008157.1652.4.camel@epip-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gxt@mprc.pku.edu.cn
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1429

On Thu, 2011-06-02 at 00:29 +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---
>  arch/arm/configs/davinci_all_defconfig     |    2 +-
>  arch/arm/configs/mxs_defconfig             |    2 +-
>  arch/arm/configs/netx_defconfig            |    2 +-
>  arch/arm/configs/viper_defconfig           |    2 +-
>  arch/arm/configs/xcep_defconfig            |    2 +-
>  arch/arm/configs/zeus_defconfig            |    2 +-
>  arch/avr32/configs/atngw100_mrmt_defconfig |    2 +-
>  arch/blackfin/configs/CM-BF548_defconfig   |    2 +-
>  arch/mips/configs/mtx1_defconfig           |    2 +-
>  arch/powerpc/configs/52xx/pcm030_defconfig |    2 +-
>  arch/powerpc/configs/ps3_defconfig         |    2 +-
>  arch/sh/configs/titan_defconfig            |    2 +-
>  arch/unicore32/configs/debug_defconfig     |    2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/unicore32/configs/debug_defconfig b/arch/unicore32/configs/debug_defconfig
> index b5fbde9..1c367f0 100644
> --- a/arch/unicore32/configs/debug_defconfig
> +++ b/arch/unicore32/configs/debug_defconfig
> @@ -168,7 +168,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  
>  #	Real Time Clock
>  CONFIG_RTC_LIB=m
> -CONFIG_RTC_CLASS=m
> +CONFIG_RTC_CLASS=y
>  
>  ### File systems
>  CONFIG_EXT2_FS=m

I adjust this config option recently, and enable it with y.
So please just drop the modification in unicore32 config file.

Thanks & Regards.

Guan Xuetao
