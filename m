Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 20:53:30 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:58142 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008309AbbILSxZhFSiO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 20:53:25 +0200
Received: from [192.168.178.24] (p5DE957C9.dip0.t-ipconnect.de [93.233.87.201])
        by hauke-m.de (Postfix) with ESMTPSA id D81F81004E0;
        Sat, 12 Sep 2015 20:53:24 +0200 (CEST)
Subject: Re: [PATCH 3/3] MIPS: make MIPS_CMDLINE_DTB default
To:     Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org
References: <1442075174-30414-1-git-send-email-jogo@openwrt.org>
 <1442075174-30414-4-git-send-email-jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <55F474A4.4030308@hauke-m.de>
Date:   Sat, 12 Sep 2015 20:53:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1442075174-30414-4-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 09/12/2015 06:26 PM, Jonas Gorski wrote:
> Seval of-enabled machines (bmips, lantiq, xlp, pistachio, ralink) copied
> the arguments from dtb to arcs_command_line to prevent the kernel from
> overwriting them.
> 
> Since there is now an option to keep the dtb arguments, default to the
> new option remove the "backup" to arcs_command_line in case of USE_OF is
> enabled, except for those platforms that still take the bootloader
> arguments or do not use any at all.
> 
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>  arch/mips/Kconfig           | 3 +++
>  arch/mips/bmips/setup.c     | 1 -
>  arch/mips/lantiq/prom.c     | 2 --
>  arch/mips/netlogic/xlp/dt.c | 1 -
>  arch/mips/pistachio/init.c  | 1 -
>  arch/mips/ralink/of.c       | 2 --
>  6 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3753437..703142b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2730,6 +2730,9 @@ endchoice
>  
>  choice
>  	prompt "Kernel command line type" if !CMDLINE_OVERRIDE
> +	default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATh79 && !MACH_INGENIC && \

ATh79 does not exist, ATH79 does.

> +					 !MIPS_MALTA && !MIPS_SEAD3 && \
> +					 !CAVIUM_OCTEON_SOC
>  	default MIPS_CMDLINE_FROM_BOOTLOADER
>  
>  	config MIPS_CMDLINE_FROM_DTB
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index 526ec27..5b16d29 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -157,7 +157,6 @@ void __init plat_mem_setup(void)
>  		panic("no dtb found");
>  
>  	__dt_setup_arch(dtb);
> -	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  
>  	for (q = bmips_quirk_list; q->quirk_fn; q++) {
>  		if (of_flat_dt_is_compatible(of_get_flat_dt_root(),
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index 0db099e..297bcaa 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -77,8 +77,6 @@ void __init plat_mem_setup(void)
>  	 * parsed resulting in our memory appearing
>  	 */
>  	__dt_setup_arch(__dtb_start);
> -
> -	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  }
>  
>  void __init device_tree_init(void)
> diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
> index a625bdb..856a6e6 100644
> --- a/arch/mips/netlogic/xlp/dt.c
> +++ b/arch/mips/netlogic/xlp/dt.c
> @@ -87,7 +87,6 @@ void __init *xlp_dt_init(void *fdtp)
>  void __init xlp_early_init_devtree(void)
>  {
>  	__dt_setup_arch(xlp_fdt_blob);
> -	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  }
>  
>  void __init device_tree_init(void)
> diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
> index 8bd8ebb..96ba2cc 100644
> --- a/arch/mips/pistachio/init.c
> +++ b/arch/mips/pistachio/init.c
> @@ -58,7 +58,6 @@ void __init plat_mem_setup(void)
>  		panic("Device-tree not present");
>  
>  	__dt_setup_arch((void *)fw_arg1);
> -	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  
>  	plat_setup_iocoherency();
>  }
> diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
> index 0d30dcd..f9eda5d 100644
> --- a/arch/mips/ralink/of.c
> +++ b/arch/mips/ralink/of.c
> @@ -74,8 +74,6 @@ void __init plat_mem_setup(void)
>  	 */
>  	__dt_setup_arch(__dtb_start);
>  
> -	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> -
>  	of_scan_flat_dt(early_init_dt_find_memory, NULL);
>  	if (memory_dtb)
>  		of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> 
