Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 15:04:49 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:36571 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903693Ab2FFNEn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jun 2012 15:04:43 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id AFB8A23C007C;
        Wed,  6 Jun 2012 15:04:37 +0200 (CEST)
Message-ID: <4FCF5565.2040909@openwrt.org>
Date:   Wed, 06 Jun 2012 15:04:37 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 06/35] MIPS: ath79: Cleanup firmware support for the ath79
 platform.
References: <1338931179-9611-1-git-send-email-sjhill@mips.com> <1338931179-9611-7-git-send-email-sjhill@mips.com>
In-Reply-To: <1338931179-9611-7-git-send-email-sjhill@mips.com>
X-Enigmail-Version: 1.4.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-archive-position: 33573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Steven,

2012.06.05. 23:19 keltezéssel, Steven J. Hill írta:
> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/ath79/prom.c |   20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
> index e9cbd7c..adbe614 100644
> --- a/arch/mips/ath79/prom.c
> +++ b/arch/mips/ath79/prom.c
> @@ -14,7 +14,7 @@
>  #include <linux/io.h>
>  #include <linux/string.h>
>  
> -#include <asm/bootinfo.h>
> +#include <asm/fw/fw.h>
>  #include <asm/addrspace.h>
>  
>  #include "common.h"
> @@ -32,23 +32,11 @@ static inline int is_valid_ram_addr(void *addr)
>  	return 0;
>  }
>  
> -static __init void ath79_prom_init_cmdline(int argc, char **argv)
> -{
> -	int i;
> -
> -	if (!is_valid_ram_addr(argv))
> -		return;
> -
> -	for (i = 0; i < argc; i++)
> -		if (is_valid_ram_addr(argv[i])) {

Please don't remove this validation. The Atheros AR7xxx/AR9xxx based boards are
using various bootloaders. Some of them puts insane values in argv, and this
validation ensures that the kernel will not crash with them.

> -			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
> -			strlcat(arcs_cmdline, argv[i], sizeof(arcs_cmdline));
> -		}
> -}
> -
>  void __init prom_init(void)
>  {
> -	ath79_prom_init_cmdline(fw_arg0, (char **)fw_arg1);
> +	if (!is_valid_ram_addr((int *)fw_arg1))

The 'is_valid_ram_addr' function requires a 'void *' argument, so it would be
more precise to use that instead of 'int *' in the cast.

> +		return;
> +	fw_init_cmdline();
>  }
>  
>  void __init prom_free_prom_memory(void)

-Gabor
