Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 06:33:26 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:46053 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827363Ab3IQEcy73Acr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 06:32:54 +0200
Message-ID: <5237DB64.1020805@phrozen.org>
Date:   Tue, 17 Sep 2013 06:32:36 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 15/28] mips: use early_init_dt_scan
References: <1379372965-22359-1-git-send-email-robherring2@gmail.com> <1379372965-22359-16-git-send-email-robherring2@gmail.com>
In-Reply-To: <1379372965-22359-16-git-send-email-robherring2@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 17/09/13 01:09, Rob Herring wrote:
> From: Rob Herring<rob.herring@calxeda.com>
>
> Convert mips to use new early_init_dt_scan function.
>
> Remove early_init_dt_scan_memory_arch
>
> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---

Acked-by: John Crispin <blogic@openwrt.org>


Thanks for this series ...







>   arch/mips/include/asm/prom.h |  3 ---
>   arch/mips/kernel/prom.c      | 39 +++------------------------------------
>   2 files changed, 3 insertions(+), 39 deletions(-)
>
> diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
> index 1e7e096..e3dbd0e 100644
> --- a/arch/mips/include/asm/prom.h
> +++ b/arch/mips/include/asm/prom.h
> @@ -17,9 +17,6 @@
>   #include<linux/types.h>
>   #include<asm/bootinfo.h>
>
> -extern int early_init_dt_scan_memory_arch(unsigned long node,
> -	const char *uname, int depth, void *data);
> -
>   extern void device_tree_init(void);
>
>   static inline unsigned long pci_address_to_pio(phys_addr_t address)
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> index 0fa0b69..67a4c53 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -17,8 +17,6 @@
>   #include<linux/debugfs.h>
>   #include<linux/of.h>
>   #include<linux/of_fdt.h>
> -#include<linux/of_irq.h>
> -#include<linux/of_platform.h>
>
>   #include<asm/page.h>
>   #include<asm/prom.h>
> @@ -40,13 +38,6 @@ char *mips_get_machine_name(void)
>   }
>
>   #ifdef CONFIG_OF
> -int __init early_init_dt_scan_memory_arch(unsigned long node,
> -					  const char *uname, int depth,
> -					  void *data)
> -{
> -	return early_init_dt_scan_memory(node, uname, depth, data);
> -}
> -
>   void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>   {
>   	return add_memory_region(base, size, BOOT_MEM_RAM);
> @@ -78,36 +69,12 @@ int __init early_init_dt_scan_model(unsigned long node,	const char *uname,
>   	return 0;
>   }
>
> -void __init early_init_devtree(void *params)
> -{
> -	/* Setup flat device-tree pointer */
> -	initial_boot_params = params;
> -
> -	/* Retrieve various informations from the /chosen node of the
> -	 * device-tree, including the platform type, initrd location and
> -	 * size, and more ...
> -	 */
> -	of_scan_flat_dt(early_init_dt_scan_chosen, arcs_cmdline);
> -
> -
> -	/* Scan memory nodes */
> -	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> -	of_scan_flat_dt(early_init_dt_scan_memory_arch, NULL);
> -
> -	/* try to load the mips machine name */
> -	of_scan_flat_dt(early_init_dt_scan_model, NULL);
> -}
> -
>   void __init __dt_setup_arch(struct boot_param_header *bph)
>   {
> -	if (be32_to_cpu(bph->magic) != OF_DT_HEADER) {
> -		pr_err("DTB has bad magic, ignoring builtin OF DTB\n");
> -
> +	if (!early_init_dt_scan(bph))
>   		return;
> -	}
> -
> -	initial_boot_params = bph;
>
> -	early_init_devtree(initial_boot_params);
> +	/* try to load the mips machine name */
> +	of_scan_flat_dt(early_init_dt_scan_model, NULL);
>   }
>   #endif
