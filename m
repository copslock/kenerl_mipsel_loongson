Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Dec 2013 21:26:22 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:48178 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816383Ab3LAU0TlbYaL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Dec 2013 21:26:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 7D3155A70DB;
        Sun,  1 Dec 2013 22:26:16 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id 9d+ym8UhXpwl; Sun,  1 Dec 2013 22:26:12 +0200 (EET)
Received: from musicnaut.iki.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with SMTP id 879785BC008;
        Sun,  1 Dec 2013 22:26:11 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sun, 01 Dec 2013 22:26:08 +0200
Date:   Sun, 1 Dec 2013 22:26:08 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, sergei.shtylyov@cogentembedded.com,
        zajec5@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/2] MIPS: BCM47XX: Remove CFE support
Message-ID: <20131201202608.GE30823@blackmetal.musicnaut.iki.fi>
References: <1380062216-24031-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380062216-24031-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Sep 25, 2013 at 12:36:55AM +0200, Hauke Mehrtens wrote:
> bcm47xx only uses the CFE code for early print to a console, but that
> is also possible with a early print serial 8250 driver.
> 
> The CFE api init causes hangs somewhere in prom_init_cfe() on some
> devices like the Buffalo WHR-HP-G54 and the Asus WL-520GU.
> This was reported in https://dev.openwrt.org/ticket/4061 and
> https://forum.openwrt.org/viewtopic.php?id=17063
> 
> This will remove all the CFE handling code from bcm47xx.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/mips/Kconfig        |    2 -
>  arch/mips/bcm47xx/prom.c |   91 ----------------------------------------------
>  2 files changed, 93 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index e70cf31..f73cb81 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -111,14 +111,12 @@ config BCM47XX
>  	select CEVT_R4K
>  	select CSRC_R4K
>  	select DMA_NONCOHERENT
> -	select FW_CFE
>  	select HW_HAS_PCI
>  	select IRQ_CPU
>  	select SYS_HAS_CPU_MIPS32_R1
>  	select NO_EXCEPT_FILL
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> -	select SYS_HAS_EARLY_PRINTK
>  	help
>  	 Support for BCM47XX based boards
>  
> diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
> index 53b9a3fb..99c3ce2 100644
> --- a/arch/mips/bcm47xx/prom.c
> +++ b/arch/mips/bcm47xx/prom.c
> @@ -30,12 +30,9 @@
>  #include <linux/spinlock.h>
>  #include <linux/smp.h>
>  #include <asm/bootinfo.h>
> -#include <asm/fw/cfe/cfe_api.h>
> -#include <asm/fw/cfe/cfe_error.h>
>  #include <bcm47xx.h>
>  #include <bcm47xx_board.h>
>  
> -static int cfe_cons_handle;
>  
>  static char bcm47xx_system_type[20] = "Broadcom BCM47XX";
>  
> @@ -52,91 +49,6 @@ __init void bcm47xx_set_system_type(u16 chip_id)
>  		 chip_id);
>  }
>  
> -void prom_putchar(char c)
> -{
> -	while (cfe_write(cfe_cons_handle, &c, 1) == 0)
> -		;
> -}
> -
> -static __init void prom_init_cfe(void)
> -{
> -	uint32_t cfe_ept;
> -	uint32_t cfe_handle;
> -	uint32_t cfe_eptseal;
> -	int argc = fw_arg0;
> -	char **envp = (char **) fw_arg2;
> -	int *prom_vec = (int *) fw_arg3;
> -
> -	/*
> -	 * Check if a loader was used; if NOT, the 4 arguments are
> -	 * what CFE gives us (handle, 0, EPT and EPTSEAL)
> -	 */
> -	if (argc < 0) {
> -		cfe_handle = (uint32_t)argc;
> -		cfe_ept = (uint32_t)envp;
> -		cfe_eptseal = (uint32_t)prom_vec;
> -	} else {
> -		if ((int)prom_vec < 0) {
> -			/*
> -			 * Old loader; all it gives us is the handle,
> -			 * so use the "known" entrypoint and assume
> -			 * the seal.
> -			 */
> -			cfe_handle = (uint32_t)prom_vec;
> -			cfe_ept = 0xBFC00500;
> -			cfe_eptseal = CFE_EPTSEAL;
> -		} else {
> -			/*
> -			 * Newer loaders bundle the handle/ept/eptseal
> -			 * Note: prom_vec is in the loader's useg
> -			 * which is still alive in the TLB.
> -			 */
> -			cfe_handle = prom_vec[0];
> -			cfe_ept = prom_vec[2];
> -			cfe_eptseal = prom_vec[3];
> -		}
> -	}
> -
> -	if (cfe_eptseal != CFE_EPTSEAL) {
> -		/* too early for panic to do any good */
> -		printk(KERN_ERR "CFE's entrypoint seal doesn't match.");
> -		while (1) ;
> -	}
> -
> -	cfe_init(cfe_handle, cfe_ept);
> -}
> -
> -static __init void prom_init_console(void)
> -{
> -	/* Initialize CFE console */
> -	cfe_cons_handle = cfe_getstdhandle(CFE_STDHANDLE_CONSOLE);
> -}
> -
> -static __init void prom_init_cmdline(void)
> -{
> -	static char buf[COMMAND_LINE_SIZE] __initdata;
> -
> -	/* Get the kernel command line from CFE */
> -	if (cfe_getenv("LINUX_CMDLINE", buf, COMMAND_LINE_SIZE) >= 0) {
> -		buf[COMMAND_LINE_SIZE - 1] = 0;
> -		strcpy(arcs_cmdline, buf);
> -	}
> -
> -	/* Force a console handover by adding a console= argument if needed,
> -	 * as CFE is not available anymore later in the boot process. */
> -	if ((strstr(arcs_cmdline, "console=")) == NULL) {
> -		/* Try to read the default serial port used by CFE */
> -		if ((cfe_getenv("BOOT_CONSOLE", buf, COMMAND_LINE_SIZE) < 0)
> -		    || (strncmp("uart", buf, 4)))
> -			/* Default to uart0 */
> -			strcpy(buf, "uart0");
> -
> -		/* Compute the new command line */
> -		snprintf(arcs_cmdline, COMMAND_LINE_SIZE, "%s console=ttyS%c,115200",
> -			 arcs_cmdline, buf[4]);
> -	}
> -}
> -
>  static __init void prom_init_mem(void)
>  {
>  	unsigned long mem;
> @@ -184,9 +96,6 @@ static __init void prom_init_mem(void)
>  
>  void __init prom_init(void)
>  {
> -	prom_init_cfe();
> -	prom_init_console();
> -	prom_init_cmdline();
>  	prom_init_mem();
>  }
>  
> -- 
> 1.7.10.4
> 
> 
