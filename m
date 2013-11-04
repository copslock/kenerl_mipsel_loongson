Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2013 17:04:54 +0100 (CET)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:62240 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817664Ab3KDQEuglZNb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Nov 2013 17:04:50 +0100
Received: by mail-ob0-f171.google.com with SMTP id wn1so7313616obc.30
        for <multiple recipients>; Mon, 04 Nov 2013 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=MsGN1RM9js1vJx4PYblB1xjJVpDluJquyBznxt/WXpU=;
        b=JkbojX/8Mx1gatk+LYErO1t/qqnk7R/0K8OBtVOJAXmv9fqtO8r4HZ76k5up0F+WL/
         bd3M4cOvrvk6GZtRldbtnAaXQGhLmflXrPq22SJ5F7wh20ka6NGm8M55HDI1zZL4LHJ2
         0rm98Z5DXtE8D+IonM+HpNRfoCnhe0Xr/cfAYbFMApRYj4ag2Cl2wS9bQhLLLWFO6ZBP
         n4eZlvti+9vKV9o0q/WQaEsY0WM5bxdfQVuwHzE/tgMDU2a7XObiOgDJjQUCF4poF9HN
         zL/IbIYUgeKvvvZU36EzLUekkP8WZZVAR1AWkpPIxnPefJXFoYHIX5R7JWxonpMu+G8e
         jKlA==
X-Received: by 10.182.18.9 with SMTP id s9mr15070715obd.15.1383581083876;
        Mon, 04 Nov 2013 08:04:43 -0800 (PST)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPSA id jz7sm41086099oeb.4.2013.11.04.08.04.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Nov 2013 08:04:43 -0800 (PST)
Message-ID: <5277C59C.8050009@gmail.com>
Date:   Mon, 04 Nov 2013 10:04:44 -0600
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Netlogic: replace early_init_devtree() call
References: <20131031154816.GX25884@linux-mips.org> <1383567714-5164-1-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1383567714-5164-1-git-send-email-jchandra@broadcom.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On 11/04/2013 06:21 AM, Jayachandran C wrote:
> The early_init_devtree() API was removed in linux-next for 3.13 with
> commit "mips: use early_init_dt_scan". This causes Netlogic XLP compile
> to fail:
> 
> arch/mips/netlogic/xlp/setup.c:101: undefined reference to `early_init_devtree'
> 
> Add xlp_early_init_devtree() which uses the __dt_setup_arch() to
> handle early device tree related initialization to fix this.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  arch/mips/include/asm/netlogic/xlp-hal/xlp.h |    1 +
>  arch/mips/netlogic/xlp/dt.c                  |   18 ++++++++++++++----
>  arch/mips/netlogic/xlp/setup.c               |    2 +-
>  3 files changed, 16 insertions(+), 5 deletions(-)

If there are no objections, I'll apply this to my tree. I don't really
like this being platform specific, but I can't make sense of all the per
platform stuff in MIPS land to come up with a better solution. It
shouldn't really be a platform decision when to do DT scanning and
initialization. Just looking at the command line handling makes me run away.

Rob

> diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
> index 17daffb2..470f209 100644
> --- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
> +++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
> @@ -69,6 +69,7 @@ void nlm_hal_init(void);
>  int xlp_get_dram_map(int n, uint64_t *dram_map);
>  
>  /* Device tree related */
> +void xlp_early_init_devtree(void);
>  void *xlp_dt_init(void *fdtp);
>  
>  static inline int cpu_is_xlpii(void)
> diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
> index 88df445..8316d54 100644
> --- a/arch/mips/netlogic/xlp/dt.c
> +++ b/arch/mips/netlogic/xlp/dt.c
> @@ -39,8 +39,11 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_device.h>
>  
> +#include <asm/prom.h>
> +
>  extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[],
>  	__dtb_xlp_fvp_begin[], __dtb_start[];
> +static void *xlp_fdt_blob;
>  
>  void __init *xlp_dt_init(void *fdtp)
>  {
> @@ -67,19 +70,26 @@ void __init *xlp_dt_init(void *fdtp)
>  			break;
>  		}
>  	}
> -	initial_boot_params = fdtp;
> +	xlp_fdt_blob = fdtp;
>  	return fdtp;
>  }
>  
> +void __init xlp_early_init_devtree(void)
> +{
> +	__dt_setup_arch(xlp_fdt_blob);
> +	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> +}
> +
>  void __init device_tree_init(void)
>  {
>  	unsigned long base, size;
> +	struct boot_param_header *fdtp = xlp_fdt_blob;
>  
> -	if (!initial_boot_params)
> +	if (!fdtp)
>  		return;
>  
> -	base = virt_to_phys((void *)initial_boot_params);
> -	size = be32_to_cpu(initial_boot_params->totalsize);
> +	base = virt_to_phys(fdtp);
> +	size = be32_to_cpu(fdtp->totalsize);
>  
>  	/* Before we do anything, lets reserve the dt blob */
>  	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
> diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
> index 76a7131..6d981bb 100644
> --- a/arch/mips/netlogic/xlp/setup.c
> +++ b/arch/mips/netlogic/xlp/setup.c
> @@ -98,7 +98,7 @@ void __init plat_mem_setup(void)
>  	pm_power_off	= nlm_linux_exit;
>  
>  	/* memory and bootargs from DT */
> -	early_init_devtree(initial_boot_params);
> +	xlp_early_init_devtree();
>  
>  	if (boot_mem_map.nr_map == 0) {
>  		pr_info("Using DRAM BARs for memory map.\n");
> 
