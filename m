Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 04:00:50 +0000 (GMT)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:39956 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S23625890AbYKLEAn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Nov 2008 04:00:43 +0000
Received: from 71.145.173.151 ([71.145.173.151]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Wed, 12 Nov 2008 04:00:34 +0000
Received: from kh-d820-ubuntu by webmail.razamicroelectronics.com; 11 Nov 2008 22:00:33 -0600
Subject: Re: [PATCH 2/3] Alchemy: Move evalboard code to common directory
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>
In-Reply-To: <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>
	 <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net>
	 <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 11 Nov 2008 22:00:33 -0600
Message-Id: <1226462433.9026.12.camel@kh-d820-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Manuel,

And in keeping with my other email, I think that the evalboards
directory is a good idea (though I would recommend the name
"develboards" as that is what DB stands for), but it should contain
subdirectories for each board and a common directory for common DB code.
Smashing all of the board code into one file doesn't leave any room to
grow if that file gets too big.  Also, a single common.c will not be
sufficient in the future.

=Kevin

On Sat, 2008-11-08 at 13:08 +0100, Manuel Lauss wrote:
> Move all code of the Pb/Db boards to a single subdirectory and extract
> some common code.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  arch/mips/Makefile                             |   24 +-
>  arch/mips/alchemy/common/setup.c               |   25 --
>  arch/mips/alchemy/db1x00/Makefile              |    8 -
>  arch/mips/alchemy/db1x00/board_setup.c         |  198 ---------------
>  arch/mips/alchemy/evalboards/Makefile          |   17 ++
>  arch/mips/alchemy/evalboards/common.c          |   62 +++++
>  arch/mips/alchemy/evalboards/db1x00.c          |  206 +++++++++++++++
>  arch/mips/alchemy/evalboards/pb1000.c          |  196 +++++++++++++++
>  arch/mips/alchemy/evalboards/pb1100.c          |  150 +++++++++++
>  arch/mips/alchemy/evalboards/pb1200.c          |  301 ++++++++++++++++++++++
>  arch/mips/alchemy/evalboards/pb1200_platform.c |  166 +++++++++++++
>  arch/mips/alchemy/evalboards/pb1500.c          |  156 ++++++++++++
>  arch/mips/alchemy/evalboards/pb1550.c          |   86 +++++++
>  arch/mips/alchemy/mtx-1/board_setup.c          |    8 +
>  arch/mips/alchemy/pb1000/Makefile              |    8 -
>  arch/mips/alchemy/pb1000/board_setup.c         |  197 ---------------
>  arch/mips/alchemy/pb1100/Makefile              |    8 -
>  arch/mips/alchemy/pb1100/board_setup.c         |  147 -----------
>  arch/mips/alchemy/pb1200/Makefile              |    8 -
>  arch/mips/alchemy/pb1200/board_setup.c         |  316 ------------------------
>  arch/mips/alchemy/pb1200/platform.c            |  166 -------------
>  arch/mips/alchemy/pb1500/Makefile              |    8 -
>  arch/mips/alchemy/pb1500/board_setup.c         |  161 ------------
>  arch/mips/alchemy/pb1550/Makefile              |    8 -
>  arch/mips/alchemy/pb1550/board_setup.c         |   97 --------
>  arch/mips/alchemy/xxs1500/board_setup.c        |    9 +
>  26 files changed, 1369 insertions(+), 1367 deletions(-)
>  delete mode 100644 arch/mips/alchemy/db1x00/Makefile
>  delete mode 100644 arch/mips/alchemy/db1x00/board_setup.c
>  create mode 100644 arch/mips/alchemy/evalboards/Makefile
>  create mode 100644 arch/mips/alchemy/evalboards/common.c
>  create mode 100644 arch/mips/alchemy/evalboards/db1x00.c
>  create mode 100644 arch/mips/alchemy/evalboards/pb1000.c
>  create mode 100644 arch/mips/alchemy/evalboards/pb1100.c
>  create mode 100644 arch/mips/alchemy/evalboards/pb1200.c
>  create mode 100644 arch/mips/alchemy/evalboards/pb1200_platform.c
>  create mode 100644 arch/mips/alchemy/evalboards/pb1500.c
>  create mode 100644 arch/mips/alchemy/evalboards/pb1550.c
>  delete mode 100644 arch/mips/alchemy/pb1000/Makefile
>  delete mode 100644 arch/mips/alchemy/pb1000/board_setup.c
>  delete mode 100644 arch/mips/alchemy/pb1100/Makefile
>  delete mode 100644 arch/mips/alchemy/pb1100/board_setup.c
>  delete mode 100644 arch/mips/alchemy/pb1200/Makefile
>  delete mode 100644 arch/mips/alchemy/pb1200/board_setup.c
>  delete mode 100644 arch/mips/alchemy/pb1200/platform.c
>  delete mode 100644 arch/mips/alchemy/pb1500/Makefile
>  delete mode 100644 arch/mips/alchemy/pb1500/board_setup.c
>  delete mode 100644 arch/mips/alchemy/pb1550/Makefile
>  delete mode 100644 arch/mips/alchemy/pb1550/board_setup.c
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 28c55f6..b31764e 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -184,84 +184,84 @@ cflags-$(CONFIG_SOC_AU1X00)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
>  #
>  # AMD Alchemy Pb1000 eval board
>  #
> -libs-$(CONFIG_MIPS_PB1000)	+= arch/mips/alchemy/pb1000/
> +core-$(CONFIG_MIPS_PB1000)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_PB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
>  load-$(CONFIG_MIPS_PB1000)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Pb1100 eval board
>  #
> -libs-$(CONFIG_MIPS_PB1100)	+= arch/mips/alchemy/pb1100/
> +core-$(CONFIG_MIPS_PB1100)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_PB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
>  load-$(CONFIG_MIPS_PB1100)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Pb1500 eval board
>  #
> -libs-$(CONFIG_MIPS_PB1500)	+= arch/mips/alchemy/pb1500/
> +core-$(CONFIG_MIPS_PB1500)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_PB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
>  load-$(CONFIG_MIPS_PB1500)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Pb1550 eval board
>  #
> -libs-$(CONFIG_MIPS_PB1550)	+= arch/mips/alchemy/pb1550/
> +core-$(CONFIG_MIPS_PB1550)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_PB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
>  load-$(CONFIG_MIPS_PB1550)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Pb1200 eval board
>  #
> -libs-$(CONFIG_MIPS_PB1200)	+= arch/mips/alchemy/pb1200/
> +core-$(CONFIG_MIPS_PB1200)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_PB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
>  load-$(CONFIG_MIPS_PB1200)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Db1000 eval board
>  #
> -libs-$(CONFIG_MIPS_DB1000)	+= arch/mips/alchemy/db1x00/
> +core-$(CONFIG_MIPS_DB1000)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_DB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
>  load-$(CONFIG_MIPS_DB1000)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Db1100 eval board
>  #
> -libs-$(CONFIG_MIPS_DB1100)	+= arch/mips/alchemy/db1x00/
> +core-$(CONFIG_MIPS_DB1100)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_DB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
>  load-$(CONFIG_MIPS_DB1100)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Db1500 eval board
>  #
> -libs-$(CONFIG_MIPS_DB1500)	+= arch/mips/alchemy/db1x00/
> +core-$(CONFIG_MIPS_DB1500)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_DB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
>  load-$(CONFIG_MIPS_DB1500)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Db1550 eval board
>  #
> -libs-$(CONFIG_MIPS_DB1550)	+= arch/mips/alchemy/db1x00/
> +core-$(CONFIG_MIPS_DB1550)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_DB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
>  load-$(CONFIG_MIPS_DB1550)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Db1200 eval board
>  #
> -libs-$(CONFIG_MIPS_DB1200)	+= arch/mips/alchemy/pb1200/
> +core-$(CONFIG_MIPS_DB1200)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
>  load-$(CONFIG_MIPS_DB1200)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Bosporus eval board
>  #
> -libs-$(CONFIG_MIPS_BOSPORUS)	+= arch/mips/alchemy/db1x00/
> +core-$(CONFIG_MIPS_BOSPORUS)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_BOSPORUS)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
>  load-$(CONFIG_MIPS_BOSPORUS)	+= 0xffffffff80100000
>  
>  #
>  # AMD Alchemy Mirage eval board
>  #
> -libs-$(CONFIG_MIPS_MIRAGE)	+= arch/mips/alchemy/db1x00/
> +core-$(CONFIG_MIPS_MIRAGE)	+= arch/mips/alchemy/evalboards/
>  cflags-$(CONFIG_MIPS_MIRAGE)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
>  load-$(CONFIG_MIPS_MIRAGE)	+= 0xffffffff80100000
>  
> diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
> index 1ac6b06..cd94985 100644
> --- a/arch/mips/alchemy/common/setup.c
> +++ b/arch/mips/alchemy/common/setup.c
> @@ -46,7 +46,6 @@ extern void set_cpuspec(void);
>  void __init plat_mem_setup(void)
>  {
>  	struct	cpu_spec *sp;
> -	char *argptr;
>  	unsigned long prid, cpufreq, bclk;
>  
>  	set_cpuspec();
> @@ -79,30 +78,6 @@ void __init plat_mem_setup(void)
>  		/* Clear to obtain best system bus performance */
>  		clear_c0_config(1 << 19); /* Clear Config[OD] */
>  
> -	argptr = prom_getcmdline();
> -
> -#ifdef CONFIG_SERIAL_8250_CONSOLE
> -	argptr = strstr(argptr, "console=");
> -	if (argptr == NULL) {
> -		argptr = prom_getcmdline();
> -		strcat(argptr, " console=ttyS0,115200");
> -	}
> -#endif
> -
> -#ifdef CONFIG_FB_AU1100
> -	argptr = strstr(argptr, "video=");
> -	if (argptr == NULL) {
> -		argptr = prom_getcmdline();
> -		/* default panel */
> -		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
> -	}
> -#endif
> -
> -#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
> -	/* au1000 does not support vra, au1500 and au1100 do */
> -	strcat(argptr, " au1000_audio=vra");
> -	argptr = prom_getcmdline();
> -#endif
>  	_machine_restart = au1000_restart;
>  	_machine_halt = au1000_halt;
>  	pm_power_off = au1000_power_off;
> diff --git a/arch/mips/alchemy/db1x00/Makefile b/arch/mips/alchemy/db1x00/Makefile
> deleted file mode 100644
> index 9924aa0..0000000
> --- a/arch/mips/alchemy/db1x00/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#
> -#  Copyright 2000, 2008 MontaVista Software Inc.
> -#  Author: MontaVista Software, Inc. <source@mvista.com>
> -#
> -# Makefile for the Alchemy Semiconductor DBAu1xx0 boards.
> -#
> -
> -lib-y := board_setup.o
> diff --git a/arch/mips/alchemy/db1x00/board_setup.c b/arch/mips/alchemy/db1x00/board_setup.c
> deleted file mode 100644
> index 507ded2..0000000
> --- a/arch/mips/alchemy/db1x00/board_setup.c
> +++ /dev/null
> @@ -1,198 +0,0 @@
> -/*
> - *
> - * BRIEF MODULE DESCRIPTION
> - *	Alchemy Db1x00 board support.
> - *
> - * Copyright 2003 Embedded Edge, LLC
> - *		dan@embeddededge.com
> - *
> - * Copyright 2000, 2008 MontaVista Software Inc.
> - * Author: MontaVista Software, Inc. <source@mvista.com>
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the  GNU General Public License along
> - *  with this program; if not, write  to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <asm/bootinfo.h>
> -#include <prom.h>
> -
> -#include <asm/mach-au1x00/au1000.h>
> -#include <asm/mach-db1x00/db1x00.h>
> -
> -#ifdef CONFIG_MIPS_DB1500
> -char irq_tab_alchemy[][5] __initdata = {
> -	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - HPT371   */
> -	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
> -};
> -#endif
> -
> -#ifdef CONFIG_MIPS_BOSPORUS
> -char irq_tab_alchemy[][5] __initdata = {
> -	[11] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 11 - miniPCI  */
> -	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - SN1741   */
> -	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
> -};
> -#endif
> -
> -#ifdef CONFIG_MIPS_MIRAGE
> -char irq_tab_alchemy[][5] __initdata = {
> -	[11] = { -1, INTD, INTX, INTX, INTX }, /* IDSEL 11 - SMI VGX */
> -	[12] = { -1, INTX, INTX, INTC, INTX }, /* IDSEL 12 - PNX1300 */
> -	[13] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 13 - miniPCI */
> -};
> -#endif
> -
> -#ifdef CONFIG_MIPS_DB1550
> -char irq_tab_alchemy[][5] __initdata = {
> -	[11] = { -1, INTC, INTX, INTX, INTX }, /* IDSEL 11 - on-board HPT371 */
> -	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left) */
> -	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
> -};
> -#endif
> -
> -
> -struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> -
> -#ifndef CONFIG_MIPS_MIRAGE
> -#ifdef CONFIG_MIPS_DB1550
> -	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
> -	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
> -#else
> -	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 Fully_Interted# */
> -	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 STSCHG# */
> -	{ AU1000_GPIO_2, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
> -
> -	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 Fully_Interted# */
> -	{ AU1000_GPIO_4, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 STSCHG# */
> -	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
> -#endif
> -#else
> -	{ AU1000_GPIO_7, INTC_INT_RISE_EDGE, 0 }, /* touchscreen pen down */
> -#endif
> -
> -};
> -
> -int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> -
> -static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
> -
> -const char *get_system_type(void)
> -{
> -#ifdef CONFIG_MIPS_BOSPORUS
> -	return "Alchemy Bosporus Gateway Reference";
> -#else
> -	return "Alchemy Db1x00";
> -#endif
> -}
> -
> -void __init prom_init(void)
> -{
> -	unsigned char *memsize_str;
> -	unsigned long memsize;
> -
> -	prom_argc = fw_arg0;
> -	prom_argv = (char **)fw_arg1;
> -	prom_envp = (char **)fw_arg2;
> -
> -	prom_init_cmdline();
> -
> -	memsize_str = prom_getenv("memsize");
> -	if (!memsize_str)
> -		memsize = 0x04000000;
> -	else
> -		strict_strtol(memsize_str, 0, &memsize);
> -	add_memory_region(0, memsize, BOOT_MEM_RAM);
> -}
> -
> -void board_reset(void)
> -{
> -	/* Hit BCSR.SW_RESET[RESET] */
> -	bcsr->swreset = 0x0000;
> -}
> -
> -void __init board_setup(void)
> -{
> -	u32 pin_func = 0;
> -
> -	/* Not valid for Au1550 */
> -#if defined(CONFIG_IRDA) && \
> -   (defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100))
> -	/* Set IRFIRSEL instead of GPIO15 */
> -	pin_func = au_readl(SYS_PINFUNC) | SYS_PF_IRF;
> -	au_writel(pin_func, SYS_PINFUNC);
> -	/* Power off until the driver is in use */
> -	bcsr->resets &= ~BCSR_RESETS_IRDA_MODE_MASK;
> -	bcsr->resets |=  BCSR_RESETS_IRDA_MODE_OFF;
> -	au_sync();
> -#endif
> -	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
> -
> -#ifdef CONFIG_MIPS_MIRAGE
> -	/* Enable GPIO[31:0] inputs */
> -	au_writel(0, SYS_PININPUTEN);
> -
> -	/* GPIO[20] is output, tristate the other input primary GPIOs */
> -	au_writel(~(1 << 20), SYS_TRIOUTCLR);
> -
> -	/* Set GPIO[210:208] instead of SSI_0 */
> -	pin_func = au_readl(SYS_PINFUNC) | SYS_PF_S0;
> -
> -	/* Set GPIO[215:211] for LEDs */
> -	pin_func |= 5 << 2;
> -
> -	/* Set GPIO[214:213] for more LEDs */
> -	pin_func |= 5 << 12;
> -
> -	/* Set GPIO[207:200] instead of PCMCIA/LCD */
> -	pin_func |= SYS_PF_LCD | SYS_PF_PC;
> -	au_writel(pin_func, SYS_PINFUNC);
> -
> -	/*
> -	 * Enable speaker amplifier.  This should
> -	 * be part of the audio driver.
> -	 */
> -	au_writel(au_readl(GPIO2_DIR) | 0x200, GPIO2_DIR);
> -	au_writel(0x02000200, GPIO2_OUTPUT);
> -#endif
> -
> -	au_sync();
> -
> -#ifdef CONFIG_MIPS_DB1000
> -	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
> -#endif
> -#ifdef CONFIG_MIPS_DB1500
> -	printk(KERN_INFO "AMD Alchemy Au1500/Db1500 Board\n");
> -#endif
> -#ifdef CONFIG_MIPS_DB1100
> -	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
> -#endif
> -#ifdef CONFIG_MIPS_BOSPORUS
> -	printk(KERN_INFO "AMD Alchemy Bosporus Board\n");
> -#endif
> -#ifdef CONFIG_MIPS_MIRAGE
> -	printk(KERN_INFO "AMD Alchemy Mirage Board\n");
> -#endif
> -#ifdef CONFIG_MIPS_DB1550
> -	printk(KERN_INFO "AMD Alchemy Au1550/Db1550 Board\n");
> -#endif
> -}
> diff --git a/arch/mips/alchemy/evalboards/Makefile b/arch/mips/alchemy/evalboards/Makefile
> new file mode 100644
> index 0000000..56a67c6
> --- /dev/null
> +++ b/arch/mips/alchemy/evalboards/Makefile
> @@ -0,0 +1,17 @@
> +#
> +# Alchemy demoboards (Db1xx0/Pb1xx0/Bosporus/Mirage series).
> +#
> +
> +obj-y	+= common.o
> +obj-$(CONFIG_MIPS_PB1000)	+= pb1000.o
> +obj-$(CONFIG_MIPS_PB1100)	+= pb1100.o
> +obj-$(CONFIG_MIPS_PB1200)	+= pb1200.o pb1200_platform.o
> +obj-$(CONFIG_MIPS_PB1500)	+= pb1500.o
> +obj-$(CONFIG_MIPS_PB1550)	+= pb1550.o
> +obj-$(CONFIG_MIPS_DB1000)	+= db1x00.o
> +obj-$(CONFIG_MIPS_DB1100)	+= db1x00.o
> +obj-$(CONFIG_MIPS_DB1200)	+= pb1200.o pb1200_platform.o
> +obj-$(CONFIG_MIPS_DB1500)	+= db1x00.o
> +obj-$(CONFIG_MIPS_DB1550)	+= db1x00.o
> +obj-$(CONFIG_MIPS_BOSPORUS)	+= db1x00.o
> +obj-$(CONFIG_MIPS_MIRAGE)	+= db1x00.o
> diff --git a/arch/mips/alchemy/evalboards/common.c b/arch/mips/alchemy/evalboards/common.c
> new file mode 100644
> index 0000000..baf8300
> --- /dev/null
> +++ b/arch/mips/alchemy/evalboards/common.c
> @@ -0,0 +1,62 @@
> +/*
> + * Common code used by all Alchemy evalboards.
> + *
> + * Extracted from files which had this to say:
> + *
> + * Copyright 2000, 2008 MontaVista Software Inc.
> + * Author: MontaVista Software, Inc. <source@mvista.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <asm/bootinfo.h>
> +#include <asm/mach-au1x00/au1000.h>
> +#include <prom.h>
> +
> +#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_DB1000) || \
> +    defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100) || \
> +    defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500) || \
> +    defined(CONFIG_MIPS_BOSPORUS) || defined(CONFIG_MIPS_MIRAGE)
> +#define ALCHEMY_BOARD_DEFAULT_MEMSIZE	0x04000000
> +
> +#else	/* Au1550/Au1200-based evalboards */
> +#define ALCHEMY_BOARD_DEFAULT_MEMSIZE	0x08000000
> +#endif
> +
> +void __init prom_init(void)
> +{
> +	unsigned char *memsize_str;
> +	unsigned long memsize;
> +
> +	prom_argc = (int)fw_arg0;
> +	prom_argv = (char **)fw_arg1;
> +	prom_envp = (char **)fw_arg2;
> +
> +	prom_init_cmdline();
> +	memsize_str = prom_getenv("memsize");
> +	if (!memsize_str)
> +		memsize = ALCHEMY_BOARD_DEFAULT_MEMSIZE;
> +	else
> +		strict_strtol(memsize_str, 0, &memsize);
> +	add_memory_region(0, memsize, BOOT_MEM_RAM);
> +}
> diff --git a/arch/mips/alchemy/evalboards/db1x00.c b/arch/mips/alchemy/evalboards/db1x00.c
> new file mode 100644
> index 0000000..2dacd74
> --- /dev/null
> +++ b/arch/mips/alchemy/evalboards/db1x00.c
> @@ -0,0 +1,206 @@
> +/*
> + *
> + * BRIEF MODULE DESCRIPTION
> + *	Alchemy Db1x00 board support.
> + *
> + * Copyright 2003 Embedded Edge, LLC
> + *		dan@embeddededge.com
> + *
> + * Copyright 2000, 2008 MontaVista Software Inc.
> + * Author: MontaVista Software, Inc. <source@mvista.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-db1x00/db1x00.h>
> +#include <prom.h>
> +
> +
> +#ifdef CONFIG_MIPS_DB1500
> +char irq_tab_alchemy[][5] __initdata = {
> +	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - HPT371   */
> +	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
> +};
> +#endif
> +
> +#ifdef CONFIG_MIPS_BOSPORUS
> +char irq_tab_alchemy[][5] __initdata = {
> +	[11] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 11 - miniPCI  */
> +	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - SN1741   */
> +	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
> +};
> +#endif
> +
> +#ifdef CONFIG_MIPS_MIRAGE
> +char irq_tab_alchemy[][5] __initdata = {
> +	[11] = { -1, INTD, INTX, INTX, INTX }, /* IDSEL 11 - SMI VGX */
> +	[12] = { -1, INTX, INTX, INTC, INTX }, /* IDSEL 12 - PNX1300 */
> +	[13] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 13 - miniPCI */
> +};
> +#endif
> +
> +#ifdef CONFIG_MIPS_DB1550
> +char irq_tab_alchemy[][5] __initdata = {
> +	[11] = { -1, INTC, INTX, INTX, INTX }, /* IDSEL 11 - on-board HPT371 */
> +	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left) */
> +	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
> +};
> +#endif
> +
> +
> +struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> +
> +#ifndef CONFIG_MIPS_MIRAGE
> +#ifdef CONFIG_MIPS_DB1550
> +	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
> +	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
> +#else
> +	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 Fully_Interted# */
> +	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 STSCHG# */
> +	{ AU1000_GPIO_2, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
> +
> +	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 Fully_Interted# */
> +	{ AU1000_GPIO_4, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 STSCHG# */
> +	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
> +#endif
> +#else
> +	{ AU1000_GPIO_7, INTC_INT_RISE_EDGE, 0 }, /* touchscreen pen down */
> +#endif
> +
> +};
> +
> +int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> +
> +static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
> +
> +
> +const char *get_system_type(void)
> +{
> +#ifdef CONFIG_MIPS_BOSPORUS
> +	return "Alchemy Bosporus Gateway Reference";
> +#else
> +	return "Alchemy Db1x00";
> +#endif
> +}
> +
> +void board_reset(void)
> +{
> +	/* Hit BCSR.SW_RESET[RESET] */
> +	bcsr->swreset = 0x0000;
> +}
> +
> +void __init board_setup(void)
> +{
> +	u32 pin_func;
> +	char *argptr;
> +
> +	argptr = prom_getcmdline();
> +
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +	argptr = strstr(argptr, "console=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		strcat(argptr, " console=ttyS0,115200");
> +	}
> +#endif
> +
> +#ifdef CONFIG_FB_AU1100
> +	argptr = strstr(argptr, "video=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		/* default panel */
> +		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
> +	}
> +#endif
> +
> +#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
> +	/* au1000 does not support vra, au1500 and au1100 do */
> +	strcat(argptr, " au1000_audio=vra");
> +	argptr = prom_getcmdline();
> +#endif
> +
> +	pin_func = 0;		/* shut up "unused" warning */
> +
> +	/* Not valid for Au1550 */
> +#if defined(CONFIG_IRDA) && \
> +   (defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100))
> +	/* Set IRFIRSEL instead of GPIO15 */
> +	pin_func = au_readl(SYS_PINFUNC) | SYS_PF_IRF;
> +	au_writel(pin_func, SYS_PINFUNC);
> +	/* Power off until the driver is in use */
> +	bcsr->resets &= ~BCSR_RESETS_IRDA_MODE_MASK;
> +	bcsr->resets |=  BCSR_RESETS_IRDA_MODE_OFF;
> +	au_sync();
> +#endif
> +	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
> +
> +#ifdef CONFIG_MIPS_MIRAGE
> +	/* Enable GPIO[31:0] inputs */
> +	au_writel(0, SYS_PININPUTEN);
> +
> +	/* GPIO[20] is output, tristate the other input primary GPIOs */
> +	au_writel(~(1 << 20), SYS_TRIOUTCLR);
> +
> +	/* Set GPIO[210:208] instead of SSI_0 */
> +	pin_func = au_readl(SYS_PINFUNC) | SYS_PF_S0;
> +
> +	/* Set GPIO[215:211] for LEDs */
> +	pin_func |= 5 << 2;
> +
> +	/* Set GPIO[214:213] for more LEDs */
> +	pin_func |= 5 << 12;
> +
> +	/* Set GPIO[207:200] instead of PCMCIA/LCD */
> +	pin_func |= SYS_PF_LCD | SYS_PF_PC;
> +	au_writel(pin_func, SYS_PINFUNC);
> +
> +	/*
> +	 * Enable speaker amplifier.  This should
> +	 * be part of the audio driver.
> +	 */
> +	au_writel(au_readl(GPIO2_DIR) | 0x200, GPIO2_DIR);
> +	au_writel(0x02000200, GPIO2_OUTPUT);
> +#endif
> +
> +	au_sync();
> +
> +#ifdef CONFIG_MIPS_DB1000
> +	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
> +#endif
> +#ifdef CONFIG_MIPS_DB1500
> +	printk(KERN_INFO "AMD Alchemy Au1500/Db1500 Board\n");
> +#endif
> +#ifdef CONFIG_MIPS_DB1100
> +	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
> +#endif
> +#ifdef CONFIG_MIPS_BOSPORUS
> +	printk(KERN_INFO "AMD Alchemy Bosporus Board\n");
> +#endif
> +#ifdef CONFIG_MIPS_MIRAGE
> +	printk(KERN_INFO "AMD Alchemy Mirage Board\n");
> +#endif
> +#ifdef CONFIG_MIPS_DB1550
> +	printk(KERN_INFO "AMD Alchemy Au1550/Db1550 Board\n");
> +#endif
> +}
> diff --git a/arch/mips/alchemy/evalboards/pb1000.c b/arch/mips/alchemy/evalboards/pb1000.c
> new file mode 100644
> index 0000000..6cd3c2b
> --- /dev/null
> +++ b/arch/mips/alchemy/evalboards/pb1000.c
> @@ -0,0 +1,196 @@
> +/*
> + * Copyright 2000, 2008 MontaVista Software Inc.
> + * Author: MontaVista Software, Inc. <source@mvista.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-pb1x00/pb1000.h>
> +#include <prom.h>
> +
> +struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> +	{ AU1000_GPIO_15, INTC_INT_LOW_LEVEL, 0 },
> +};
> +
> +int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> +
> +const char *get_system_type(void)
> +{
> +	return "Alchemy Pb1000";
> +}
> +
> +void board_reset(void)
> +{
> +}
> +
> +void __init board_setup(void)
> +{
> +	u32 pin_func, static_cfg0;
> +	u32 sys_freqctrl, sys_clksrc;
> +	u32 prid = read_c0_prid();
> +	char *argptr;
> +
> +	argptr = prom_getcmdline();
> +
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +	argptr = strstr(argptr, "console=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		strcat(argptr, " console=ttyS0,115200");
> +	}
> +#endif
> +
> +#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
> +	/* au1000 does not support vra, au1500 and au1100 do */
> +	strcat(argptr, " au1000_audio=vra");
> +	argptr = prom_getcmdline();
> +#endif
> +
> +	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
> +	au_writel(8, SYS_AUXPLL);
> +	au_writel(0, SYS_PINSTATERD);
> +	udelay(100);
> +
> +	sys_freqctrl = sys_clksrc = 0;	/* shut up "unused" warnings */
> +
> +#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> +	/* Zero and disable FREQ2 */
> +	sys_freqctrl = au_readl(SYS_FREQCTRL0);
> +	sys_freqctrl &= ~0xFFF00000;
> +	au_writel(sys_freqctrl, SYS_FREQCTRL0);
> +
> +	/* Zero and disable USBH/USBD clocks */
> +	sys_clksrc = au_readl(SYS_CLKSRC);
> +	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
> +		        SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
> +	au_writel(sys_clksrc, SYS_CLKSRC);
> +
> +	sys_freqctrl = au_readl(SYS_FREQCTRL0);
> +	sys_freqctrl &= ~0xFFF00000;
> +
> +	sys_clksrc = au_readl(SYS_CLKSRC);
> +	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
> +		        SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
> +
> +	switch (prid & 0x000000FF) {
> +	case 0x00: /* DA */
> +	case 0x01: /* HA */
> +	case 0x02: /* HB */
> +		/* CPU core freq to 48 MHz to slow it way down... */
> +		au_writel(4, SYS_CPUPLL);
> +
> +		/*
> +		 * Setup 48 MHz FREQ2 from CPUPLL for USB Host
> +		 * FRDIV2 = 3 -> div by 8 of 384 MHz -> 48 MHz
> +		 */
> +		sys_freqctrl |= (3 << SYS_FC_FRDIV2_BIT) | SYS_FC_FE2;
> +		au_writel(sys_freqctrl, SYS_FREQCTRL0);
> +
> +		/* CPU core freq to 384 MHz */
> +		au_writel(0x20, SYS_CPUPLL);
> +
> +		printk(KERN_INFO "Au1000: 48 MHz OHCI workaround enabled\n");
> +		break;
> +
> +	default: /* HC and newer */
> +		/* FREQ2 = aux / 2 = 48 MHz */
> +		sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) |
> +				 SYS_FC_FE2 | SYS_FC_FS2;
> +		au_writel(sys_freqctrl, SYS_FREQCTRL0);
> +		break;
> +	}
> +
> +	/*
> +	 * Route 48 MHz FREQ2 into USB Host and/or Device
> +	 */
> +	sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MUH_BIT;
> +	au_writel(sys_clksrc, SYS_CLKSRC);
> +
> +	/* Configure pins GPIO[14:9] as GPIO */
> +	pin_func = au_readl(SYS_PINFUNC) & ~(SYS_PF_UR3 | SYS_PF_USB);
> +
> +	/* 2nd USB port is USB host */
> +	pin_func |= SYS_PF_USB;
> +
> +	au_writel(pin_func, SYS_PINFUNC);
> +	au_writel(0x2800, SYS_TRIOUTCLR);
> +	au_writel(0x0030, SYS_OUTPUTCLR);
> +#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
> +
> +	/* Make GPIO 15 an input (for interrupt line) */
> +	pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_IRF;
> +	/* We don't need I2S, so make it available for GPIO[31:29] */
> +	pin_func |= SYS_PF_I2S;
> +	au_writel(pin_func, SYS_PINFUNC);
> +
> +	au_writel(0x8000, SYS_TRIOUTCLR);
> +
> +	static_cfg0 = au_readl(MEM_STCFG0) & ~0xc00;
> +	au_writel(static_cfg0, MEM_STCFG0);
> +
> +	/* configure RCE2* for LCD */
> +	au_writel(0x00000004, MEM_STCFG2);
> +
> +	/* MEM_STTIME2 */
> +	au_writel(0x09000000, MEM_STTIME2);
> +
> +	/* Set 32-bit base address decoding for RCE2* */
> +	au_writel(0x10003ff0, MEM_STADDR2);
> +
> +	/*
> +	 * PCI CPLD setup
> +	 * Expand CE0 to cover PCI
> +	 */
> +	au_writel(0x11803e40, MEM_STADDR1);
> +
> +	/* Burst visibility on */
> +	au_writel(au_readl(MEM_STCFG0) | 0x1000, MEM_STCFG0);
> +
> +	au_writel(0x83, MEM_STCFG1);	     /* ewait enabled, flash timing */
> +	au_writel(0x33030a10, MEM_STTIME1);  /* slower timing for FPGA */
> +
> +	/* Setup the static bus controller */
> +	au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
> +	au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
> +	au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
> +
> +	/*
> +	 * Enable Au1000 BCLK switching - note: sed1356 must not use
> +	 * its BCLK (Au1000 LCLK) for any timings
> +	 */
> +	switch (prid & 0x000000FF) {
> +	case 0x00: /* DA */
> +	case 0x01: /* HA */
> +	case 0x02: /* HB */
> +		break;
> +	default:  /* HC and newer */
> +		/*
> +		 * Enable sys bus clock divider when IDLE state or no bus
> +		 * activity.
> +		 */
> +		au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
> +		break;
> +	}
> +}
> diff --git a/arch/mips/alchemy/evalboards/pb1100.c b/arch/mips/alchemy/evalboards/pb1100.c
> new file mode 100644
> index 0000000..73bc831
> --- /dev/null
> +++ b/arch/mips/alchemy/evalboards/pb1100.c
> @@ -0,0 +1,150 @@
> +/*
> + * Copyright 2002, 2008 MontaVista Software Inc.
> + * Author: MontaVista Software, Inc. <source@mvista.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-pb1x00/pb1100.h>
> +#include <prom.h>
> +
> +struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> +	{ AU1000_GPIO_9,  INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card Fully_Inserted# */
> +	{ AU1000_GPIO_10, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card STSCHG# */
> +	{ AU1000_GPIO_11, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card IRQ# */
> +	{ AU1000_GPIO_13, INTC_INT_LOW_LEVEL, 0 }, /* DC_IRQ# */
> +};
> +
> +int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> +
> +
> +const char *get_system_type(void)
> +{
> +	return "Alchemy Pb1100";
> +}
> +
> +void board_reset(void)
> +{
> +	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
> +	au_writel(0x00000000, PB1100_RST_VDDI);
> +}
> +
> +void __init board_setup(void)
> +{
> +	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
> +	char *argptr;
> +
> +	argptr = prom_getcmdline();
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +	argptr = strstr(argptr, "console=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		strcat(argptr, " console=ttyS0,115200");
> +	}
> +#endif
> +
> +#ifdef CONFIG_FB_AU1100
> +	argptr = strstr(argptr, "video=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		/* default panel */
> +		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
> +	}
> +#endif
> +
> +#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
> +	/* au1000 does not support vra, au1500 and au1100 do */
> +	strcat(argptr, " au1000_audio=vra");
> +	argptr = prom_getcmdline();
> +#endif
> +
> +	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
> +	au_writel(8, SYS_AUXPLL);
> +	au_writel(0, SYS_PININPUTEN);
> +	udelay(100);
> +
> +#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> +	{
> +		u32 pin_func, sys_freqctrl, sys_clksrc;
> +
> +		/* Configure pins GPIO[14:9] as GPIO */
> +		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
> +
> +		/* Zero and disable FREQ2 */
> +		sys_freqctrl = au_readl(SYS_FREQCTRL0);
> +		sys_freqctrl &= ~0xFFF00000;
> +		au_writel(sys_freqctrl, SYS_FREQCTRL0);
> +
> +		/* Zero and disable USBH/USBD/IrDA clock */
> +		sys_clksrc = au_readl(SYS_CLKSRC);
> +		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
> +		au_writel(sys_clksrc, SYS_CLKSRC);
> +
> +		sys_freqctrl = au_readl(SYS_FREQCTRL0);
> +		sys_freqctrl &= ~0xFFF00000;
> +
> +		sys_clksrc = au_readl(SYS_CLKSRC);
> +		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
> +
> +		/* FREQ2 = aux / 2 = 48 MHz */
> +		sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) |
> +				SYS_FC_FE2 | SYS_FC_FS2;
> +		au_writel(sys_freqctrl, SYS_FREQCTRL0);
> +
> +		/*
> +		 * Route 48 MHz FREQ2 into USBH/USBD/IrDA
> +		 */
> +		sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MIR_BIT;
> +		au_writel(sys_clksrc, SYS_CLKSRC);
> +
> +		/* Setup the static bus controller */
> +		au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
> +		au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
> +		au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
> +
> +		/*
> +		 * Get USB Functionality pin state (device vs host drive pins).
> +		 */
> +		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
> +		/* 2nd USB port is USB host. */
> +		pin_func |= SYS_PF_USB;
> +		au_writel(pin_func, SYS_PINFUNC);
> +	}
> +#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
> +
> +	/* Enable sys bus clock divider when IDLE state or no bus activity. */
> +	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
> +
> +	/* Enable the RTC if not already enabled. */
> +	if (!(readb(base + 0x28) & 0x20)) {
> +		writeb(readb(base + 0x28) | 0x20, base + 0x28);
> +		au_sync();
> +	}
> +	/* Put the clock in BCD mode. */
> +	if (readb(base + 0x2C) & 0x4) { /* reg B */
> +		writeb(readb(base + 0x2c) & ~0x4, base + 0x2c);
> +		au_sync();
> +	}
> +}
> diff --git a/arch/mips/alchemy/evalboards/pb1200.c b/arch/mips/alchemy/evalboards/pb1200.c
> new file mode 100644
> index 0000000..ccaae62
> --- /dev/null
> +++ b/arch/mips/alchemy/evalboards/pb1200.c
> @@ -0,0 +1,301 @@
> +/*
> + *
> + * BRIEF MODULE DESCRIPTION
> + *	Alchemy Pb1200/Db1200 board setup.
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <asm/mach-au1x00/au1000.h>
> +
> +#ifdef CONFIG_MIPS_PB1200
> +#include <asm/mach-pb1x00/pb1200.h>
> +#endif
> +
> +#ifdef CONFIG_MIPS_DB1200
> +#include <asm/mach-db1x00/db1200.h>
> +#define PB1200_INT_BEGIN DB1200_INT_BEGIN
> +#define PB1200_INT_END DB1200_INT_END
> +#endif
> +
> +#include <prom.h>
> +
> +
> +extern void (*board_init_irq)(void);
> +
> +struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> +	/* This is external interrupt cascade */
> +	{ AU1000_GPIO_7, INTC_INT_LOW_LEVEL, 0 },
> +};
> +
> +int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> +
> +
> +/*
> + * Support for External interrupts on the Pb1200 Development platform.
> + */
> +static volatile int pb1200_cascade_en;
> +
> +irqreturn_t pb1200_cascade_handler(int irq, void *dev_id)
> +{
> +	unsigned short bisr = bcsr->int_status;
> +	int extirq_nr = 0;
> +
> +	/* Clear all the edge interrupts. This has no effect on level. */
> +	bcsr->int_status = bisr;
> +	for ( ; bisr; bisr &= bisr - 1) {
> +		extirq_nr = PB1200_INT_BEGIN + __ffs(bisr);
> +		/* Ack and dispatch IRQ */
> +		do_IRQ(extirq_nr);
> +	}
> +
> +	return IRQ_RETVAL(1);
> +}
> +
> +inline void pb1200_enable_irq(unsigned int irq_nr)
> +{
> +	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
> +	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
> +}
> +
> +inline void pb1200_disable_irq(unsigned int irq_nr)
> +{
> +	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
> +	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
> +}
> +
> +static unsigned int pb1200_setup_cascade(void)
> +{
> +	return request_irq(AU1000_GPIO_7, &pb1200_cascade_handler,
> +			   0, "Pb1200 Cascade", &pb1200_cascade_handler);
> +}
> +
> +static unsigned int pb1200_startup_irq(unsigned int irq)
> +{
> +	if (++pb1200_cascade_en == 1) {
> +		int res;
> +
> +		res = pb1200_setup_cascade();
> +		if (res)
> +			return res;
> +	}
> +
> +	pb1200_enable_irq(irq);
> +
> +	return 0;
> +}
> +
> +static void pb1200_shutdown_irq(unsigned int irq)
> +{
> +	pb1200_disable_irq(irq);
> +	if (--pb1200_cascade_en == 0)
> +		free_irq(AU1000_GPIO_7, &pb1200_cascade_handler);
> +}
> +
> +static struct irq_chip external_irq_type = {
> +#ifdef CONFIG_MIPS_PB1200
> +	.name = "Pb1200 Ext",
> +#endif
> +#ifdef CONFIG_MIPS_DB1200
> +	.name = "Db1200 Ext",
> +#endif
> +	.startup  = pb1200_startup_irq,
> +	.shutdown = pb1200_shutdown_irq,
> +	.ack      = pb1200_disable_irq,
> +	.mask     = pb1200_disable_irq,
> +	.mask_ack = pb1200_disable_irq,
> +	.unmask   = pb1200_enable_irq,
> +};
> +
> +static void pb1200_init_irq(void)
> +{
> +	unsigned int irq;
> +
> +#ifdef CONFIG_MIPS_PB1200
> +	/* We have a problem with CPLD rev 3. */
> +	if (((bcsr->whoami & BCSR_WHOAMI_CPLD) >> 4) <= 3) {
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "Pb1200 must be at CPLD rev 4. Please have Pb1200\n");
> +		printk(KERN_ERR "updated to latest revision. This software will\n");
> +		printk(KERN_ERR "not work on anything less than CPLD rev 4.\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		printk(KERN_ERR "WARNING!!!\n");
> +		panic("Game over.  Your score is 0.");
> +	}
> +#endif
> +
> +	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++) {
> +		set_irq_chip_and_handler(irq, &external_irq_type,
> +					 handle_level_irq);
> +		pb1200_disable_irq(irq);
> +	}
> +
> +	/*
> +	 * GPIO_7 can not be hooked here, so it is hooked upon first
> +	 * request of any source attached to the cascade.
> +	 */
> +}
> +
> +const char *get_system_type(void)
> +{
> +	return "Alchemy Pb1200";
> +}
> +
> +void board_reset(void)
> +{
> +	bcsr->resets = 0;
> +	bcsr->system = 0;
> +}
> +
> +void __init board_setup(void)
> +{
> +	char *argptr;
> +
> +	argptr = prom_getcmdline();
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +	argptr = strstr(argptr, "console=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		strcat(argptr, " console=ttyS0,115200");
> +	}
> +#endif
> +#ifdef CONFIG_FB_AU1200
> +	strcat(argptr, " video=au1200fb:panel:bs");
> +#endif
> +
> +#if 0
> +	{
> +		u32 pin_func;
> +
> +		/*
> +		 * Enable PSC1 SYNC for AC97.  Normaly done in audio driver,
> +		 * but it is board specific code, so put it here.
> +		 */
> +		pin_func = au_readl(SYS_PINFUNC);
> +		au_sync();
> +		pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
> +		au_writel(pin_func, SYS_PINFUNC);
> +
> +		au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
> +		au_sync();
> +	}
> +#endif
> +
> +#if defined(CONFIG_I2C_AU1550)
> +	{
> +		u32 freq0, clksrc;
> +		u32 pin_func;
> +
> +		/* Select SMBus in CPLD */
> +		bcsr->resets &= ~BCSR_RESETS_PCS0MUX;
> +
> +		pin_func = au_readl(SYS_PINFUNC);
> +		au_sync();
> +		pin_func &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
> +		/* Set GPIOs correctly */
> +		pin_func |= 2 << 17;
> +		au_writel(pin_func, SYS_PINFUNC);
> +		au_sync();
> +
> +		/* The I2C driver depends on 50 MHz clock */
> +		freq0 = au_readl(SYS_FREQCTRL0);
> +		au_sync();
> +		freq0 &= ~(SYS_FC_FRDIV1_MASK | SYS_FC_FS1 | SYS_FC_FE1);
> +		freq0 |= 3 << SYS_FC_FRDIV1_BIT;
> +		/* 396 MHz / (3 + 1) * 2 == 49.5 MHz */
> +		au_writel(freq0, SYS_FREQCTRL0);
> +		au_sync();
> +		freq0 |= SYS_FC_FE1;
> +		au_writel(freq0, SYS_FREQCTRL0);
> +		au_sync();
> +
> +		clksrc = au_readl(SYS_CLKSRC);
> +		au_sync();
> +		clksrc &= ~(SYS_CS_CE0 | SYS_CS_DE0 | SYS_CS_ME0_MASK);
> +		/* Bit 22 is EXTCLK0 for PSC0 */
> +		clksrc |= SYS_CS_MUX_FQ1 << SYS_CS_ME0_BIT;
> +		au_writel(clksrc, SYS_CLKSRC);
> +		au_sync();
> +	}
> +#endif
> +
> +	/*
> +	 * The Pb1200 development board uses external MUX for PSC0 to
> +	 * support SMB/SPI. bcsr->resets bit 12: 0=SMB 1=SPI
> +	 */
> +#ifdef CONFIG_I2C_AU1550
> +	bcsr->resets &= ~BCSR_RESETS_PCS0MUX;
> +#endif
> +	au_sync();
> +
> +#ifdef CONFIG_MIPS_PB1200
> +	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
> +#endif
> +#ifdef CONFIG_MIPS_DB1200
> +	printk(KERN_INFO "AMD Alchemy Db1200 Board\n");
> +#endif
> +
> +	/* Setup Pb1200 External Interrupt Controller */
> +	board_init_irq = pb1200_init_irq;
> +}
> +
> +int board_au1200fb_panel(void)
> +{
> +	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
> +	int p;
> +
> +	p = bcsr->switches;
> +	p >>= 8;
> +	p &= 0x0F;
> +	return p;
> +}
> +
> +int board_au1200fb_panel_init(void)
> +{
> +	/* Apply power */
> +	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
> +
> +	bcsr->board |= BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD | BCSR_BOARD_LCDBL;
> +	/* printk(KERN_DEBUG "board_au1200fb_panel_init()\n"); */
> +	return 0;
> +}
> +
> +int board_au1200fb_panel_shutdown(void)
> +{
> +	/* Remove power */
> +	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
> +
> +	bcsr->board &= ~(BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
> +			 BCSR_BOARD_LCDBL);
> +	/* printk(KERN_DEBUG "board_au1200fb_panel_shutdown()\n"); */
> +	return 0;
> +}
> diff --git a/arch/mips/alchemy/evalboards/pb1200_platform.c b/arch/mips/alchemy/evalboards/pb1200_platform.c
> new file mode 100644
> index 0000000..9530329
> --- /dev/null
> +++ b/arch/mips/alchemy/evalboards/pb1200_platform.c
> @@ -0,0 +1,166 @@
> +/*
> + * Pb1200/DBAu1200 board platform device registration
> + *
> + * Copyright (C) 2008 MontaVista Software Inc. <source@mvista.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/init.h>
> +#include <linux/leds.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mach-au1x00/au1xxx.h>
> +#include <asm/mach-au1x00/au1100_mmc.h>
> +
> +static int mmc_activity;
> +
> +static void pb1200mmc0_set_power(void *mmc_host, int state)
> +{
> +	if (state)
> +		bcsr->board |= BCSR_BOARD_SD0PWR;
> +	else
> +		bcsr->board &= ~BCSR_BOARD_SD0PWR;
> +
> +	au_sync_delay(1);
> +}
> +
> +static int pb1200mmc0_card_readonly(void *mmc_host)
> +{
> +	return (bcsr->status & BCSR_STATUS_SD0WP) ? 1 : 0;
> +}
> +
> +static int pb1200mmc0_card_inserted(void *mmc_host)
> +{
> +	return (bcsr->sig_status & BCSR_INT_SD0INSERT) ? 1 : 0;
> +}
> +
> +static void pb1200_mmcled_set(struct led_classdev *led,
> +			enum led_brightness brightness)
> +{
> +	if (brightness != LED_OFF) {
> +		if (++mmc_activity == 1)
> +			bcsr->disk_leds &= ~(1 << 8);
> +	} else {
> +		if (--mmc_activity == 0)
> +			bcsr->disk_leds |= (1 << 8);
> +	}
> +}
> +
> +static struct led_classdev pb1200mmc_led = {
> +	.brightness_set	= pb1200_mmcled_set,
> +};
> +
> +#ifndef CONFIG_MIPS_DB1200
> +static void pb1200mmc1_set_power(void *mmc_host, int state)
> +{
> +	if (state)
> +		bcsr->board |= BCSR_BOARD_SD1PWR;
> +	else
> +		bcsr->board &= ~BCSR_BOARD_SD1PWR;
> +
> +	au_sync_delay(1);
> +}
> +
> +static int pb1200mmc1_card_readonly(void *mmc_host)
> +{
> +	return (bcsr->status & BCSR_STATUS_SD1WP) ? 1 : 0;
> +}
> +
> +static int pb1200mmc1_card_inserted(void *mmc_host)
> +{
> +	return (bcsr->sig_status & BCSR_INT_SD1INSERT) ? 1 : 0;
> +}
> +#endif
> +
> +const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
> +	[0] = {
> +		.set_power	= pb1200mmc0_set_power,
> +		.card_inserted	= pb1200mmc0_card_inserted,
> +		.card_readonly	= pb1200mmc0_card_readonly,
> +		.cd_setup	= NULL,		/* use poll-timer in driver */
> +		.led		= &pb1200mmc_led,
> +	},
> +#ifndef CONFIG_MIPS_DB1200
> +	[1] = {
> +		.set_power	= pb1200mmc1_set_power,
> +		.card_inserted	= pb1200mmc1_card_inserted,
> +		.card_readonly	= pb1200mmc1_card_readonly,
> +		.cd_setup	= NULL,		/* use poll-timer in driver */
> +		.led		= &pb1200mmc_led,
> +	},
> +#endif
> +};
> +
> +static struct resource ide_resources[] = {
> +	[0] = {
> +		.start	= IDE_PHYS_ADDR,
> +		.end 	= IDE_PHYS_ADDR + IDE_PHYS_LEN - 1,
> +		.flags	= IORESOURCE_MEM
> +	},
> +	[1] = {
> +		.start	= IDE_INT,
> +		.end	= IDE_INT,
> +		.flags	= IORESOURCE_IRQ
> +	}
> +};
> +
> +static u64 ide_dmamask = DMA_32BIT_MASK;
> +
> +static struct platform_device ide_device = {
> +	.name		= "au1200-ide",
> +	.id		= 0,
> +	.dev = {
> +		.dma_mask 		= &ide_dmamask,
> +		.coherent_dma_mask	= DMA_32BIT_MASK,
> +	},
> +	.num_resources	= ARRAY_SIZE(ide_resources),
> +	.resource	= ide_resources
> +};
> +
> +static struct resource smc91c111_resources[] = {
> +	[0] = {
> +		.name	= "smc91x-regs",
> +		.start	= SMC91C111_PHYS_ADDR,
> +		.end	= SMC91C111_PHYS_ADDR + 0xf,
> +		.flags	= IORESOURCE_MEM
> +	},
> +	[1] = {
> +		.start	= SMC91C111_INT,
> +		.end	= SMC91C111_INT,
> +		.flags	= IORESOURCE_IRQ
> +	},
> +};
> +
> +static struct platform_device smc91c111_device = {
> +	.name		= "smc91x",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(smc91c111_resources),
> +	.resource	= smc91c111_resources
> +};
> +
> +static struct platform_device *board_platform_devices[] __initdata = {
> +	&ide_device,
> +	&smc91c111_device
> +};
> +
> +static int __init board_register_devices(void)
> +{
> +	return platform_add_devices(board_platform_devices,
> +				    ARRAY_SIZE(board_platform_devices));
> +}
> +
> +arch_initcall(board_register_devices);
> diff --git a/arch/mips/alchemy/evalboards/pb1500.c b/arch/mips/alchemy/evalboards/pb1500.c
> new file mode 100644
> index 0000000..a65f100
> --- /dev/null
> +++ b/arch/mips/alchemy/evalboards/pb1500.c
> @@ -0,0 +1,156 @@
> +/*
> + * Copyright 2000, 2008 MontaVista Software Inc.
> + * Author: MontaVista Software, Inc. <source@mvista.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-pb1x00/pb1500.h>
> +#include <prom.h>
> +
> +char irq_tab_alchemy[][5] __initdata = {
> +	[12] = { -1, INTA, INTX, INTX, INTX },   /* IDSEL 12 - HPT370	*/
> +	[13] = { -1, INTA, INTB, INTC, INTD },   /* IDSEL 13 - PCI slot */
> +};
> +
> +struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> +	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
> +	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
> +	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
> +	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
> +	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
> +};
> +
> +int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> +
> +
> +const char *get_system_type(void)
> +{
> +	return "Alchemy Pb1500";
> +}
> +
> +void board_reset(void)
> +{
> +	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
> +	au_writel(0x00000000, PB1500_RST_VDDI);
> +}
> +
> +void __init board_setup(void)
> +{
> +	u32 pin_func;
> +	u32 sys_freqctrl, sys_clksrc;
> +	char *argptr;
> +
> +	argptr = prom_getcmdline();
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +	argptr = strstr(argptr, "console=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		strcat(argptr, " console=ttyS0,115200");
> +	}
> +#endif
> +#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
> +	/* au1000 does not support vra, au1500 and au1100 do */
> +	strcat(argptr, " au1000_audio=vra");
> +	argptr = prom_getcmdline();
> +#endif
> +
> +	sys_clksrc = sys_freqctrl = pin_func = 0;
> +	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
> +	au_writel(8, SYS_AUXPLL);
> +	au_writel(0, SYS_PINSTATERD);
> +	udelay(100);
> +
> +#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> +
> +	/* GPIO201 is input for PCMCIA card detect */
> +	/* GPIO203 is input for PCMCIA interrupt request */
> +	au_writel(au_readl(GPIO2_DIR) & ~((1 << 1) | (1 << 3)), GPIO2_DIR);
> +
> +	/* Zero and disable FREQ2 */
> +	sys_freqctrl = au_readl(SYS_FREQCTRL0);
> +	sys_freqctrl &= ~0xFFF00000;
> +	au_writel(sys_freqctrl, SYS_FREQCTRL0);
> +
> +	/* zero and disable USBH/USBD clocks */
> +	sys_clksrc = au_readl(SYS_CLKSRC);
> +	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
> +			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
> +	au_writel(sys_clksrc, SYS_CLKSRC);
> +
> +	sys_freqctrl = au_readl(SYS_FREQCTRL0);
> +	sys_freqctrl &= ~0xFFF00000;
> +
> +	sys_clksrc = au_readl(SYS_CLKSRC);
> +	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
> +			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
> +
> +	/* FREQ2 = aux/2 = 48 MHz */
> +	sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) | SYS_FC_FE2 | SYS_FC_FS2;
> +	au_writel(sys_freqctrl, SYS_FREQCTRL0);
> +
> +	/*
> +	 * Route 48MHz FREQ2 into USB Host and/or Device
> +	 */
> +	sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MUH_BIT;
> +	au_writel(sys_clksrc, SYS_CLKSRC);
> +
> +	pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
> +	/* 2nd USB port is USB host */
> +	pin_func |= SYS_PF_USB;
> +	au_writel(pin_func, SYS_PINFUNC);
> +#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
> +
> +#ifdef CONFIG_PCI
> +	/* Setup PCI bus controller */
> +	au_writel(0, Au1500_PCI_CMEM);
> +	au_writel(0x00003fff, Au1500_CFG_BASE);
> +#if defined(__MIPSEB__)
> +	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
> +#else
> +	au_writel(0xf, Au1500_PCI_CFG);
> +#endif
> +	au_writel(0xf0000000, Au1500_PCI_MWMASK_DEV);
> +	au_writel(0, Au1500_PCI_MWBASE_REV_CCL);
> +	au_writel(0x02a00356, Au1500_PCI_STATCMD);
> +	au_writel(0x00003c04, Au1500_PCI_HDRTYPE);
> +	au_writel(0x00000008, Au1500_PCI_MBAR);
> +	au_sync();
> +#endif
> +
> +	/* Enable sys bus clock divider when IDLE state or no bus activity. */
> +	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
> +
> +	/* Enable the RTC if not already enabled */
> +	if (!(au_readl(0xac000028) & 0x20)) {
> +		printk(KERN_INFO "enabling clock ...\n");
> +		au_writel((au_readl(0xac000028) | 0x20), 0xac000028);
> +	}
> +	/* Put the clock in BCD mode */
> +	if (au_readl(0xac00002c) & 0x4) { /* reg B */
> +		au_writel(au_readl(0xac00002c) & ~0x4, 0xac00002c);
> +		au_sync();
> +	}
> +}
> diff --git a/arch/mips/alchemy/evalboards/pb1550.c b/arch/mips/alchemy/evalboards/pb1550.c
> new file mode 100644
> index 0000000..bd7c3a9
> --- /dev/null
> +++ b/arch/mips/alchemy/evalboards/pb1550.c
> @@ -0,0 +1,86 @@
> +/*
> + *
> + * BRIEF MODULE DESCRIPTION
> + *	Alchemy Pb1550 board setup.
> + *
> + * Copyright 2000, 2008 MontaVista Software Inc.
> + * Author: MontaVista Software, Inc. <source@mvista.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-pb1x00/pb1550.h>
> +#include <prom.h>
> +
> +char irq_tab_alchemy[][5] __initdata = {
> +	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
> +	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
> +};
> +
> +struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> +	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 },
> +	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 },
> +};
> +
> +int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> +
> +
> +const char *get_system_type(void)
> +{
> +	return "Alchemy Pb1550";
> +}
> +
> +void board_reset(void)
> +{
> +	/* Hit BCSR.SYSTEM[RESET] */
> +	au_writew(au_readw(0xAF00001C) & ~BCSR_SYSTEM_RESET, 0xAF00001C);
> +}
> +
> +void __init board_setup(void)
> +{
> +	u32 pin_func;
> +
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +	char *argptr = prom_getcmdline();
> +	argptr = strstr(argptr, "console=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		strcat(argptr, " console=ttyS0,115200");
> +	}
> +#endif
> +
> +	/*
> +	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
> +	 * but it is board specific code, so put it here.
> +	 */
> +	pin_func = au_readl(SYS_PINFUNC);
> +	au_sync();
> +	pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
> +	au_writel(pin_func, SYS_PINFUNC);
> +
> +	au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
> +	au_sync();
> +
> +	printk(KERN_INFO "AMD Alchemy Pb1550 Board\n");
> +}
> diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
> index 2e26465..08d265c 100644
> --- a/arch/mips/alchemy/mtx-1/board_setup.c
> +++ b/arch/mips/alchemy/mtx-1/board_setup.c
> @@ -92,6 +92,14 @@ void board_reset(void)
>  
>  void __init board_setup(void)
>  {
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +	char *argptr = prom_getcmdline();
> +	argptr = strstr(argptr, "console=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		strcat(argptr, " console=ttyS0,115200");
> +	}
> +#endif
>  #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
>  	/* Enable USB power switch */
>  	au_writel(au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR);
> diff --git a/arch/mips/alchemy/pb1000/Makefile b/arch/mips/alchemy/pb1000/Makefile
> deleted file mode 100644
> index 4377ab3..0000000
> --- a/arch/mips/alchemy/pb1000/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#
> -#  Copyright 2000, 2008 MontaVista Software Inc.
> -#  Author: MontaVista Software, Inc. <source@mvista.com>
> -#
> -# Makefile for the Alchemy Semiconductor Pb1000 board.
> -#
> -
> -lib-y := board_setup.o
> diff --git a/arch/mips/alchemy/pb1000/board_setup.c b/arch/mips/alchemy/pb1000/board_setup.c
> deleted file mode 100644
> index bd0b6f4..0000000
> --- a/arch/mips/alchemy/pb1000/board_setup.c
> +++ /dev/null
> @@ -1,197 +0,0 @@
> -/*
> - * Copyright 2000, 2008 MontaVista Software Inc.
> - * Author: MontaVista Software, Inc. <source@mvista.com>
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the  GNU General Public License along
> - *  with this program; if not, write  to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <asm/bootinfo.h>
> -#include <asm/mach-au1x00/au1000.h>
> -#include <asm/mach-pb1x00/pb1000.h>
> -#include <prom.h>
> -
> -struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> -	{ AU1000_GPIO_15, INTC_INT_LOW_LEVEL, 0 },
> -};
> -
> -int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> -
> -const char *get_system_type(void)
> -{
> -	return "Alchemy Pb1000";
> -}
> -
> -void __init prom_init(void)
> -{
> -	unsigned char *memsize_str;
> -	unsigned long memsize;
> -
> -	prom_argc = (int)fw_arg0;
> -	prom_argv = (char **)fw_arg1;
> -	prom_envp = (char **)fw_arg2;
> -
> -	prom_init_cmdline();
> -	memsize_str = prom_getenv("memsize");
> -	if (!memsize_str)
> -		memsize = 0x04000000;
> -	else
> -		strict_strtol(memsize_str, 0, &memsize);
> -	add_memory_region(0, memsize, BOOT_MEM_RAM);
> -}
> -
> -void board_reset(void)
> -{
> -}
> -
> -void __init board_setup(void)
> -{
> -	u32 pin_func, static_cfg0;
> -	u32 sys_freqctrl, sys_clksrc;
> -	u32 prid = read_c0_prid();
> -
> -	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
> -	au_writel(8, SYS_AUXPLL);
> -	au_writel(0, SYS_PINSTATERD);
> -	udelay(100);
> -
> -#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> -	/* Zero and disable FREQ2 */
> -	sys_freqctrl = au_readl(SYS_FREQCTRL0);
> -	sys_freqctrl &= ~0xFFF00000;
> -	au_writel(sys_freqctrl, SYS_FREQCTRL0);
> -
> -	/* Zero and disable USBH/USBD clocks */
> -	sys_clksrc = au_readl(SYS_CLKSRC);
> -	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
> -		        SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
> -	au_writel(sys_clksrc, SYS_CLKSRC);
> -
> -	sys_freqctrl = au_readl(SYS_FREQCTRL0);
> -	sys_freqctrl &= ~0xFFF00000;
> -
> -	sys_clksrc = au_readl(SYS_CLKSRC);
> -	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
> -		        SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
> -
> -	switch (prid & 0x000000FF) {
> -	case 0x00: /* DA */
> -	case 0x01: /* HA */
> -	case 0x02: /* HB */
> -		/* CPU core freq to 48 MHz to slow it way down... */
> -		au_writel(4, SYS_CPUPLL);
> -
> -		/*
> -		 * Setup 48 MHz FREQ2 from CPUPLL for USB Host
> -		 * FRDIV2 = 3 -> div by 8 of 384 MHz -> 48 MHz
> -		 */
> -		sys_freqctrl |= (3 << SYS_FC_FRDIV2_BIT) | SYS_FC_FE2;
> -		au_writel(sys_freqctrl, SYS_FREQCTRL0);
> -
> -		/* CPU core freq to 384 MHz */
> -		au_writel(0x20, SYS_CPUPLL);
> -
> -		printk(KERN_INFO "Au1000: 48 MHz OHCI workaround enabled\n");
> -		break;
> -
> -	default: /* HC and newer */
> -		/* FREQ2 = aux / 2 = 48 MHz */
> -		sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) |
> -				 SYS_FC_FE2 | SYS_FC_FS2;
> -		au_writel(sys_freqctrl, SYS_FREQCTRL0);
> -		break;
> -	}
> -
> -	/*
> -	 * Route 48 MHz FREQ2 into USB Host and/or Device
> -	 */
> -	sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MUH_BIT;
> -	au_writel(sys_clksrc, SYS_CLKSRC);
> -
> -	/* Configure pins GPIO[14:9] as GPIO */
> -	pin_func = au_readl(SYS_PINFUNC) & ~(SYS_PF_UR3 | SYS_PF_USB);
> -
> -	/* 2nd USB port is USB host */
> -	pin_func |= SYS_PF_USB;
> -
> -	au_writel(pin_func, SYS_PINFUNC);
> -	au_writel(0x2800, SYS_TRIOUTCLR);
> -	au_writel(0x0030, SYS_OUTPUTCLR);
> -#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
> -
> -	/* Make GPIO 15 an input (for interrupt line) */
> -	pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_IRF;
> -	/* We don't need I2S, so make it available for GPIO[31:29] */
> -	pin_func |= SYS_PF_I2S;
> -	au_writel(pin_func, SYS_PINFUNC);
> -
> -	au_writel(0x8000, SYS_TRIOUTCLR);
> -
> -	static_cfg0 = au_readl(MEM_STCFG0) & ~0xc00;
> -	au_writel(static_cfg0, MEM_STCFG0);
> -
> -	/* configure RCE2* for LCD */
> -	au_writel(0x00000004, MEM_STCFG2);
> -
> -	/* MEM_STTIME2 */
> -	au_writel(0x09000000, MEM_STTIME2);
> -
> -	/* Set 32-bit base address decoding for RCE2* */
> -	au_writel(0x10003ff0, MEM_STADDR2);
> -
> -	/*
> -	 * PCI CPLD setup
> -	 * Expand CE0 to cover PCI
> -	 */
> -	au_writel(0x11803e40, MEM_STADDR1);
> -
> -	/* Burst visibility on */
> -	au_writel(au_readl(MEM_STCFG0) | 0x1000, MEM_STCFG0);
> -
> -	au_writel(0x83, MEM_STCFG1);	     /* ewait enabled, flash timing */
> -	au_writel(0x33030a10, MEM_STTIME1);  /* slower timing for FPGA */
> -
> -	/* Setup the static bus controller */
> -	au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
> -	au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
> -	au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
> -
> -	/*
> -	 * Enable Au1000 BCLK switching - note: sed1356 must not use
> -	 * its BCLK (Au1000 LCLK) for any timings
> -	 */
> -	switch (prid & 0x000000FF) {
> -	case 0x00: /* DA */
> -	case 0x01: /* HA */
> -	case 0x02: /* HB */
> -		break;
> -	default:  /* HC and newer */
> -		/*
> -		 * Enable sys bus clock divider when IDLE state or no bus
> -		 * activity.
> -		 */
> -		au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
> -		break;
> -	}
> -}
> diff --git a/arch/mips/alchemy/pb1100/Makefile b/arch/mips/alchemy/pb1100/Makefile
> deleted file mode 100644
> index 627a75c..0000000
> --- a/arch/mips/alchemy/pb1100/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#
> -#  Copyright 2000, 2001, 2008 MontaVista Software Inc.
> -#  Author: MontaVista Software, Inc. <source@mvista.com>
> -#
> -# Makefile for the Alchemy Semiconductor Pb1100 board.
> -#
> -
> -lib-y := board_setup.o
> diff --git a/arch/mips/alchemy/pb1100/board_setup.c b/arch/mips/alchemy/pb1100/board_setup.c
> deleted file mode 100644
> index 87da4a5..0000000
> --- a/arch/mips/alchemy/pb1100/board_setup.c
> +++ /dev/null
> @@ -1,147 +0,0 @@
> -/*
> - * Copyright 2002, 2008 MontaVista Software Inc.
> - * Author: MontaVista Software, Inc. <source@mvista.com>
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the  GNU General Public License along
> - *  with this program; if not, write  to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <asm/bootinfo.h>
> -#include <asm/mach-au1x00/au1000.h>
> -#include <asm/mach-pb1x00/pb1100.h>
> -#include <prom.h>
> -
> -struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> -	{ AU1000_GPIO_9,  INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card Fully_Inserted# */
> -	{ AU1000_GPIO_10, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card STSCHG# */
> -	{ AU1000_GPIO_11, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card IRQ# */
> -	{ AU1000_GPIO_13, INTC_INT_LOW_LEVEL, 0 }, /* DC_IRQ# */
> -};
> -
> -int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> -
> -
> -const char *get_system_type(void)
> -{
> -	return "Alchemy Pb1100";
> -}
> -
> -void __init prom_init(void)
> -{
> -	unsigned char *memsize_str;
> -	unsigned long memsize;
> -
> -	prom_argc = fw_arg0;
> -	prom_argv = (char **)fw_arg1;
> -	prom_envp = (char **)fw_arg3;
> -
> -	prom_init_cmdline();
> -
> -	memsize_str = prom_getenv("memsize");
> -	if (!memsize_str)
> -		memsize = 0x04000000;
> -	else
> -		strict_strtol(memsize_str, 0, &memsize);
> -
> -	add_memory_region(0, memsize, BOOT_MEM_RAM);
> -}
> -
> -void board_reset(void)
> -{
> -	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
> -	au_writel(0x00000000, PB1100_RST_VDDI);
> -}
> -
> -void __init board_setup(void)
> -{
> -	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
> -
> -	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
> -	au_writel(8, SYS_AUXPLL);
> -	au_writel(0, SYS_PININPUTEN);
> -	udelay(100);
> -
> -#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> -	{
> -		u32 pin_func, sys_freqctrl, sys_clksrc;
> -
> -		/* Configure pins GPIO[14:9] as GPIO */
> -		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
> -
> -		/* Zero and disable FREQ2 */
> -		sys_freqctrl = au_readl(SYS_FREQCTRL0);
> -		sys_freqctrl &= ~0xFFF00000;
> -		au_writel(sys_freqctrl, SYS_FREQCTRL0);
> -
> -		/* Zero and disable USBH/USBD/IrDA clock */
> -		sys_clksrc = au_readl(SYS_CLKSRC);
> -		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
> -		au_writel(sys_clksrc, SYS_CLKSRC);
> -
> -		sys_freqctrl = au_readl(SYS_FREQCTRL0);
> -		sys_freqctrl &= ~0xFFF00000;
> -
> -		sys_clksrc = au_readl(SYS_CLKSRC);
> -		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
> -
> -		/* FREQ2 = aux / 2 = 48 MHz */
> -		sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) |
> -				SYS_FC_FE2 | SYS_FC_FS2;
> -		au_writel(sys_freqctrl, SYS_FREQCTRL0);
> -
> -		/*
> -		 * Route 48 MHz FREQ2 into USBH/USBD/IrDA
> -		 */
> -		sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MIR_BIT;
> -		au_writel(sys_clksrc, SYS_CLKSRC);
> -
> -		/* Setup the static bus controller */
> -		au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
> -		au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
> -		au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
> -
> -		/*
> -		 * Get USB Functionality pin state (device vs host drive pins).
> -		 */
> -		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
> -		/* 2nd USB port is USB host. */
> -		pin_func |= SYS_PF_USB;
> -		au_writel(pin_func, SYS_PINFUNC);
> -	}
> -#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
> -
> -	/* Enable sys bus clock divider when IDLE state or no bus activity. */
> -	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
> -
> -	/* Enable the RTC if not already enabled. */
> -	if (!(readb(base + 0x28) & 0x20)) {
> -		writeb(readb(base + 0x28) | 0x20, base + 0x28);
> -		au_sync();
> -	}
> -	/* Put the clock in BCD mode. */
> -	if (readb(base + 0x2C) & 0x4) { /* reg B */
> -		writeb(readb(base + 0x2c) & ~0x4, base + 0x2c);
> -		au_sync();
> -	}
> -}
> diff --git a/arch/mips/alchemy/pb1200/Makefile b/arch/mips/alchemy/pb1200/Makefile
> deleted file mode 100644
> index e9b9d27..0000000
> --- a/arch/mips/alchemy/pb1200/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#
> -# Makefile for the Alchemy Semiconductor Pb1200/DBAu1200 boards.
> -#
> -
> -lib-y := board_setup.o
> -obj-y += platform.o
> -
> -EXTRA_CFLAGS += -Werror
> diff --git a/arch/mips/alchemy/pb1200/board_setup.c b/arch/mips/alchemy/pb1200/board_setup.c
> deleted file mode 100644
> index a336a7a..0000000
> --- a/arch/mips/alchemy/pb1200/board_setup.c
> +++ /dev/null
> @@ -1,316 +0,0 @@
> -/*
> - *
> - * BRIEF MODULE DESCRIPTION
> - *	Alchemy Pb1200/Db1200 board setup.
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the  GNU General Public License along
> - *  with this program; if not, write  to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <asm/bootinfo.h>
> -#include <asm/mach-au1x00/au1000.h>
> -
> -#ifdef CONFIG_MIPS_PB1200
> -#include <asm/mach-pb1x00/pb1200.h>
> -#endif
> -
> -#ifdef CONFIG_MIPS_DB1200
> -#include <asm/mach-db1x00/db1200.h>
> -#define PB1200_INT_BEGIN DB1200_INT_BEGIN
> -#define PB1200_INT_END DB1200_INT_END
> -#endif
> -
> -#include <prom.h>
> -
> -extern void (*board_init_irq)(void);
> -
> -struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> -	/* This is external interrupt cascade */
> -	{ AU1000_GPIO_7, INTC_INT_LOW_LEVEL, 0 },
> -};
> -
> -int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> -
> -/*
> - * Support for External interrupts on the Pb1200 Development platform.
> - */
> -static volatile int pb1200_cascade_en;
> -
> -irqreturn_t pb1200_cascade_handler(int irq, void *dev_id)
> -{
> -	unsigned short bisr = bcsr->int_status;
> -	int extirq_nr = 0;
> -
> -	/* Clear all the edge interrupts. This has no effect on level. */
> -	bcsr->int_status = bisr;
> -	for ( ; bisr; bisr &= bisr - 1) {
> -		extirq_nr = PB1200_INT_BEGIN + __ffs(bisr);
> -		/* Ack and dispatch IRQ */
> -		do_IRQ(extirq_nr);
> -	}
> -
> -	return IRQ_RETVAL(1);
> -}
> -
> -inline void pb1200_enable_irq(unsigned int irq_nr)
> -{
> -	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
> -	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
> -}
> -
> -inline void pb1200_disable_irq(unsigned int irq_nr)
> -{
> -	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
> -	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
> -}
> -
> -static unsigned int pb1200_setup_cascade(void)
> -{
> -	return request_irq(AU1000_GPIO_7, &pb1200_cascade_handler,
> -			   0, "Pb1200 Cascade", &pb1200_cascade_handler);
> -}
> -
> -static unsigned int pb1200_startup_irq(unsigned int irq)
> -{
> -	if (++pb1200_cascade_en == 1) {
> -		int res;
> -
> -		res = pb1200_setup_cascade();
> -		if (res)
> -			return res;
> -	}
> -
> -	pb1200_enable_irq(irq);
> -
> -	return 0;
> -}
> -
> -static void pb1200_shutdown_irq(unsigned int irq)
> -{
> -	pb1200_disable_irq(irq);
> -	if (--pb1200_cascade_en == 0)
> -		free_irq(AU1000_GPIO_7, &pb1200_cascade_handler);
> -}
> -
> -static struct irq_chip external_irq_type = {
> -#ifdef CONFIG_MIPS_PB1200
> -	.name = "Pb1200 Ext",
> -#endif
> -#ifdef CONFIG_MIPS_DB1200
> -	.name = "Db1200 Ext",
> -#endif
> -	.startup  = pb1200_startup_irq,
> -	.shutdown = pb1200_shutdown_irq,
> -	.ack      = pb1200_disable_irq,
> -	.mask     = pb1200_disable_irq,
> -	.mask_ack = pb1200_disable_irq,
> -	.unmask   = pb1200_enable_irq,
> -};
> -
> -static void pb1200_init_irq(void)
> -{
> -	unsigned int irq;
> -
> -#ifdef CONFIG_MIPS_PB1200
> -	/* We have a problem with CPLD rev 3. */
> -	if (((bcsr->whoami & BCSR_WHOAMI_CPLD) >> 4) <= 3) {
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "Pb1200 must be at CPLD rev 4. Please have Pb1200\n");
> -		printk(KERN_ERR "updated to latest revision. This software will\n");
> -		printk(KERN_ERR "not work on anything less than CPLD rev 4.\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		printk(KERN_ERR "WARNING!!!\n");
> -		panic("Game over.  Your score is 0.");
> -	}
> -#endif
> -
> -	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++) {
> -		set_irq_chip_and_handler(irq, &external_irq_type,
> -					 handle_level_irq);
> -		pb1200_disable_irq(irq);
> -	}
> -
> -	/*
> -	 * GPIO_7 can not be hooked here, so it is hooked upon first
> -	 * request of any source attached to the cascade.
> -	 */
> -}
> -
> -const char *get_system_type(void)
> -{
> -	return "Alchemy Pb1200";
> -}
> -
> -void __init prom_init(void)
> -{
> -	unsigned char *memsize_str;
> -	unsigned long memsize;
> -
> -	prom_argc = (int)fw_arg0;
> -	prom_argv = (char **)fw_arg1;
> -	prom_envp = (char **)fw_arg2;
> -
> -	prom_init_cmdline();
> -	memsize_str = prom_getenv("memsize");
> -	if (!memsize_str)
> -		memsize = 0x08000000;
> -	else
> -		strict_strtol(memsize_str, 0, &memsize);
> -	add_memory_region(0, memsize, BOOT_MEM_RAM);
> -}
> -
> -void board_reset(void)
> -{
> -	bcsr->resets = 0;
> -	bcsr->system = 0;
> -}
> -
> -void __init board_setup(void)
> -{
> -	char *argptr = NULL;
> -
> -#if 0
> -	{
> -		u32 pin_func;
> -
> -		/*
> -		 * Enable PSC1 SYNC for AC97.  Normaly done in audio driver,
> -		 * but it is board specific code, so put it here.
> -		 */
> -		pin_func = au_readl(SYS_PINFUNC);
> -		au_sync();
> -		pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
> -		au_writel(pin_func, SYS_PINFUNC);
> -
> -		au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
> -		au_sync();
> -	}
> -#endif
> -
> -#if defined(CONFIG_I2C_AU1550)
> -	{
> -		u32 freq0, clksrc;
> -		u32 pin_func;
> -
> -		/* Select SMBus in CPLD */
> -		bcsr->resets &= ~BCSR_RESETS_PCS0MUX;
> -
> -		pin_func = au_readl(SYS_PINFUNC);
> -		au_sync();
> -		pin_func &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
> -		/* Set GPIOs correctly */
> -		pin_func |= 2 << 17;
> -		au_writel(pin_func, SYS_PINFUNC);
> -		au_sync();
> -
> -		/* The I2C driver depends on 50 MHz clock */
> -		freq0 = au_readl(SYS_FREQCTRL0);
> -		au_sync();
> -		freq0 &= ~(SYS_FC_FRDIV1_MASK | SYS_FC_FS1 | SYS_FC_FE1);
> -		freq0 |= 3 << SYS_FC_FRDIV1_BIT;
> -		/* 396 MHz / (3 + 1) * 2 == 49.5 MHz */
> -		au_writel(freq0, SYS_FREQCTRL0);
> -		au_sync();
> -		freq0 |= SYS_FC_FE1;
> -		au_writel(freq0, SYS_FREQCTRL0);
> -		au_sync();
> -
> -		clksrc = au_readl(SYS_CLKSRC);
> -		au_sync();
> -		clksrc &= ~(SYS_CS_CE0 | SYS_CS_DE0 | SYS_CS_ME0_MASK);
> -		/* Bit 22 is EXTCLK0 for PSC0 */
> -		clksrc |= SYS_CS_MUX_FQ1 << SYS_CS_ME0_BIT;
> -		au_writel(clksrc, SYS_CLKSRC);
> -		au_sync();
> -	}
> -#endif
> -
> -#ifdef CONFIG_FB_AU1200
> -	argptr = prom_getcmdline();
> -#ifdef CONFIG_MIPS_PB1200
> -	strcat(argptr, " video=au1200fb:panel:bs");
> -#endif
> -#ifdef CONFIG_MIPS_DB1200
> -	strcat(argptr, " video=au1200fb:panel:bs");
> -#endif
> -#endif
> -
> -	/*
> -	 * The Pb1200 development board uses external MUX for PSC0 to
> -	 * support SMB/SPI. bcsr->resets bit 12: 0=SMB 1=SPI
> -	 */
> -#ifdef CONFIG_I2C_AU1550
> -	bcsr->resets &= ~BCSR_RESETS_PCS0MUX;
> -#endif
> -	au_sync();
> -
> -#ifdef CONFIG_MIPS_PB1200
> -	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
> -#endif
> -#ifdef CONFIG_MIPS_DB1200
> -	printk(KERN_INFO "AMD Alchemy Db1200 Board\n");
> -#endif
> -
> -	/* Setup Pb1200 External Interrupt Controller */
> -	board_init_irq = pb1200_init_irq;
> -}
> -
> -int board_au1200fb_panel(void)
> -{
> -	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
> -	int p;
> -
> -	p = bcsr->switches;
> -	p >>= 8;
> -	p &= 0x0F;
> -	return p;
> -}
> -
> -int board_au1200fb_panel_init(void)
> -{
> -	/* Apply power */
> -	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
> -
> -	bcsr->board |= BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD | BCSR_BOARD_LCDBL;
> -	/* printk(KERN_DEBUG "board_au1200fb_panel_init()\n"); */
> -	return 0;
> -}
> -
> -int board_au1200fb_panel_shutdown(void)
> -{
> -	/* Remove power */
> -	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
> -
> -	bcsr->board &= ~(BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
> -			 BCSR_BOARD_LCDBL);
> -	/* printk(KERN_DEBUG "board_au1200fb_panel_shutdown()\n"); */
> -	return 0;
> -}
> diff --git a/arch/mips/alchemy/pb1200/platform.c b/arch/mips/alchemy/pb1200/platform.c
> deleted file mode 100644
> index 9530329..0000000
> --- a/arch/mips/alchemy/pb1200/platform.c
> +++ /dev/null
> @@ -1,166 +0,0 @@
> -/*
> - * Pb1200/DBAu1200 board platform device registration
> - *
> - * Copyright (C) 2008 MontaVista Software Inc. <source@mvista.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> - */
> -
> -#include <linux/dma-mapping.h>
> -#include <linux/init.h>
> -#include <linux/leds.h>
> -#include <linux/platform_device.h>
> -
> -#include <asm/mach-au1x00/au1xxx.h>
> -#include <asm/mach-au1x00/au1100_mmc.h>
> -
> -static int mmc_activity;
> -
> -static void pb1200mmc0_set_power(void *mmc_host, int state)
> -{
> -	if (state)
> -		bcsr->board |= BCSR_BOARD_SD0PWR;
> -	else
> -		bcsr->board &= ~BCSR_BOARD_SD0PWR;
> -
> -	au_sync_delay(1);
> -}
> -
> -static int pb1200mmc0_card_readonly(void *mmc_host)
> -{
> -	return (bcsr->status & BCSR_STATUS_SD0WP) ? 1 : 0;
> -}
> -
> -static int pb1200mmc0_card_inserted(void *mmc_host)
> -{
> -	return (bcsr->sig_status & BCSR_INT_SD0INSERT) ? 1 : 0;
> -}
> -
> -static void pb1200_mmcled_set(struct led_classdev *led,
> -			enum led_brightness brightness)
> -{
> -	if (brightness != LED_OFF) {
> -		if (++mmc_activity == 1)
> -			bcsr->disk_leds &= ~(1 << 8);
> -	} else {
> -		if (--mmc_activity == 0)
> -			bcsr->disk_leds |= (1 << 8);
> -	}
> -}
> -
> -static struct led_classdev pb1200mmc_led = {
> -	.brightness_set	= pb1200_mmcled_set,
> -};
> -
> -#ifndef CONFIG_MIPS_DB1200
> -static void pb1200mmc1_set_power(void *mmc_host, int state)
> -{
> -	if (state)
> -		bcsr->board |= BCSR_BOARD_SD1PWR;
> -	else
> -		bcsr->board &= ~BCSR_BOARD_SD1PWR;
> -
> -	au_sync_delay(1);
> -}
> -
> -static int pb1200mmc1_card_readonly(void *mmc_host)
> -{
> -	return (bcsr->status & BCSR_STATUS_SD1WP) ? 1 : 0;
> -}
> -
> -static int pb1200mmc1_card_inserted(void *mmc_host)
> -{
> -	return (bcsr->sig_status & BCSR_INT_SD1INSERT) ? 1 : 0;
> -}
> -#endif
> -
> -const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
> -	[0] = {
> -		.set_power	= pb1200mmc0_set_power,
> -		.card_inserted	= pb1200mmc0_card_inserted,
> -		.card_readonly	= pb1200mmc0_card_readonly,
> -		.cd_setup	= NULL,		/* use poll-timer in driver */
> -		.led		= &pb1200mmc_led,
> -	},
> -#ifndef CONFIG_MIPS_DB1200
> -	[1] = {
> -		.set_power	= pb1200mmc1_set_power,
> -		.card_inserted	= pb1200mmc1_card_inserted,
> -		.card_readonly	= pb1200mmc1_card_readonly,
> -		.cd_setup	= NULL,		/* use poll-timer in driver */
> -		.led		= &pb1200mmc_led,
> -	},
> -#endif
> -};
> -
> -static struct resource ide_resources[] = {
> -	[0] = {
> -		.start	= IDE_PHYS_ADDR,
> -		.end 	= IDE_PHYS_ADDR + IDE_PHYS_LEN - 1,
> -		.flags	= IORESOURCE_MEM
> -	},
> -	[1] = {
> -		.start	= IDE_INT,
> -		.end	= IDE_INT,
> -		.flags	= IORESOURCE_IRQ
> -	}
> -};
> -
> -static u64 ide_dmamask = DMA_32BIT_MASK;
> -
> -static struct platform_device ide_device = {
> -	.name		= "au1200-ide",
> -	.id		= 0,
> -	.dev = {
> -		.dma_mask 		= &ide_dmamask,
> -		.coherent_dma_mask	= DMA_32BIT_MASK,
> -	},
> -	.num_resources	= ARRAY_SIZE(ide_resources),
> -	.resource	= ide_resources
> -};
> -
> -static struct resource smc91c111_resources[] = {
> -	[0] = {
> -		.name	= "smc91x-regs",
> -		.start	= SMC91C111_PHYS_ADDR,
> -		.end	= SMC91C111_PHYS_ADDR + 0xf,
> -		.flags	= IORESOURCE_MEM
> -	},
> -	[1] = {
> -		.start	= SMC91C111_INT,
> -		.end	= SMC91C111_INT,
> -		.flags	= IORESOURCE_IRQ
> -	},
> -};
> -
> -static struct platform_device smc91c111_device = {
> -	.name		= "smc91x",
> -	.id		= -1,
> -	.num_resources	= ARRAY_SIZE(smc91c111_resources),
> -	.resource	= smc91c111_resources
> -};
> -
> -static struct platform_device *board_platform_devices[] __initdata = {
> -	&ide_device,
> -	&smc91c111_device
> -};
> -
> -static int __init board_register_devices(void)
> -{
> -	return platform_add_devices(board_platform_devices,
> -				    ARRAY_SIZE(board_platform_devices));
> -}
> -
> -arch_initcall(board_register_devices);
> diff --git a/arch/mips/alchemy/pb1500/Makefile b/arch/mips/alchemy/pb1500/Makefile
> deleted file mode 100644
> index 4664d61..0000000
> --- a/arch/mips/alchemy/pb1500/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#
> -#  Copyright 2000, 2001, 2008 MontaVista Software Inc.
> -#  Author: MontaVista Software, Inc. <source@mvista.com>
> -#
> -# Makefile for the Alchemy Semiconductor Pb1500 board.
> -#
> -
> -lib-y := board_setup.o
> diff --git a/arch/mips/alchemy/pb1500/board_setup.c b/arch/mips/alchemy/pb1500/board_setup.c
> deleted file mode 100644
> index 1be1afc..0000000
> --- a/arch/mips/alchemy/pb1500/board_setup.c
> +++ /dev/null
> @@ -1,161 +0,0 @@
> -/*
> - * Copyright 2000, 2008 MontaVista Software Inc.
> - * Author: MontaVista Software, Inc. <source@mvista.com>
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the  GNU General Public License along
> - *  with this program; if not, write  to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <asm/bootinfo.h>
> -#include <asm/mach-au1x00/au1000.h>
> -#include <asm/mach-pb1x00/pb1500.h>
> -#include <prom.h>
> -
> -char irq_tab_alchemy[][5] __initdata = {
> -	[12] = { -1, INTA, INTX, INTX, INTX },   /* IDSEL 12 - HPT370	*/
> -	[13] = { -1, INTA, INTB, INTC, INTD },   /* IDSEL 13 - PCI slot */
> -};
> -
> -struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> -	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
> -	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
> -	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
> -	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
> -	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
> -};
> -
> -int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> -
> -
> -const char *get_system_type(void)
> -{
> -	return "Alchemy Pb1500";
> -}
> -
> -void __init prom_init(void)
> -{
> -	unsigned char *memsize_str;
> -	unsigned long memsize;
> -
> -	prom_argc = (int)fw_arg0;
> -	prom_argv = (char **)fw_arg1;
> -	prom_envp = (char **)fw_arg2;
> -
> -	prom_init_cmdline();
> -	memsize_str = prom_getenv("memsize");
> -	if (!memsize_str)
> -		memsize = 0x04000000;
> -	else
> -		strict_strtol(memsize_str, 0, &memsize);
> -	add_memory_region(0, memsize, BOOT_MEM_RAM);
> -}
> -
> -void board_reset(void)
> -{
> -	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
> -	au_writel(0x00000000, PB1500_RST_VDDI);
> -}
> -
> -void __init board_setup(void)
> -{
> -	u32 pin_func;
> -	u32 sys_freqctrl, sys_clksrc;
> -
> -	sys_clksrc = sys_freqctrl = pin_func = 0;
> -	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
> -	au_writel(8, SYS_AUXPLL);
> -	au_writel(0, SYS_PINSTATERD);
> -	udelay(100);
> -
> -#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> -
> -	/* GPIO201 is input for PCMCIA card detect */
> -	/* GPIO203 is input for PCMCIA interrupt request */
> -	au_writel(au_readl(GPIO2_DIR) & ~((1 << 1) | (1 << 3)), GPIO2_DIR);
> -
> -	/* Zero and disable FREQ2 */
> -	sys_freqctrl = au_readl(SYS_FREQCTRL0);
> -	sys_freqctrl &= ~0xFFF00000;
> -	au_writel(sys_freqctrl, SYS_FREQCTRL0);
> -
> -	/* zero and disable USBH/USBD clocks */
> -	sys_clksrc = au_readl(SYS_CLKSRC);
> -	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
> -			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
> -	au_writel(sys_clksrc, SYS_CLKSRC);
> -
> -	sys_freqctrl = au_readl(SYS_FREQCTRL0);
> -	sys_freqctrl &= ~0xFFF00000;
> -
> -	sys_clksrc = au_readl(SYS_CLKSRC);
> -	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
> -			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
> -
> -	/* FREQ2 = aux/2 = 48 MHz */
> -	sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) | SYS_FC_FE2 | SYS_FC_FS2;
> -	au_writel(sys_freqctrl, SYS_FREQCTRL0);
> -
> -	/*
> -	 * Route 48MHz FREQ2 into USB Host and/or Device
> -	 */
> -	sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MUH_BIT;
> -	au_writel(sys_clksrc, SYS_CLKSRC);
> -
> -	pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
> -	/* 2nd USB port is USB host */
> -	pin_func |= SYS_PF_USB;
> -	au_writel(pin_func, SYS_PINFUNC);
> -#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
> -
> -#ifdef CONFIG_PCI
> -	/* Setup PCI bus controller */
> -	au_writel(0, Au1500_PCI_CMEM);
> -	au_writel(0x00003fff, Au1500_CFG_BASE);
> -#if defined(__MIPSEB__)
> -	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
> -#else
> -	au_writel(0xf, Au1500_PCI_CFG);
> -#endif
> -	au_writel(0xf0000000, Au1500_PCI_MWMASK_DEV);
> -	au_writel(0, Au1500_PCI_MWBASE_REV_CCL);
> -	au_writel(0x02a00356, Au1500_PCI_STATCMD);
> -	au_writel(0x00003c04, Au1500_PCI_HDRTYPE);
> -	au_writel(0x00000008, Au1500_PCI_MBAR);
> -	au_sync();
> -#endif
> -
> -	/* Enable sys bus clock divider when IDLE state or no bus activity. */
> -	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
> -
> -	/* Enable the RTC if not already enabled */
> -	if (!(au_readl(0xac000028) & 0x20)) {
> -		printk(KERN_INFO "enabling clock ...\n");
> -		au_writel((au_readl(0xac000028) | 0x20), 0xac000028);
> -	}
> -	/* Put the clock in BCD mode */
> -	if (au_readl(0xac00002c) & 0x4) { /* reg B */
> -		au_writel(au_readl(0xac00002c) & ~0x4, 0xac00002c);
> -		au_sync();
> -	}
> -}
> diff --git a/arch/mips/alchemy/pb1550/Makefile b/arch/mips/alchemy/pb1550/Makefile
> deleted file mode 100644
> index 7e6453d..0000000
> --- a/arch/mips/alchemy/pb1550/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#
> -#  Copyright 2000, 2008 MontaVista Software Inc.
> -#  Author: MontaVista Software, Inc. <source@mvista.com>
> -#
> -# Makefile for the Alchemy Semiconductor Pb1550 board.
> -#
> -
> -lib-y := board_setup.o
> diff --git a/arch/mips/alchemy/pb1550/board_setup.c b/arch/mips/alchemy/pb1550/board_setup.c
> deleted file mode 100644
> index e844484..0000000
> --- a/arch/mips/alchemy/pb1550/board_setup.c
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -/*
> - *
> - * BRIEF MODULE DESCRIPTION
> - *	Alchemy Pb1550 board setup.
> - *
> - * Copyright 2000, 2008 MontaVista Software Inc.
> - * Author: MontaVista Software, Inc. <source@mvista.com>
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the  GNU General Public License along
> - *  with this program; if not, write  to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <asm/bootinfo.h>
> -#include <asm/mach-au1x00/au1000.h>
> -#include <asm/mach-pb1x00/pb1550.h>
> -#include <prom.h>
> -
> -char irq_tab_alchemy[][5] __initdata = {
> -	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
> -	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
> -};
> -
> -struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
> -	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 },
> -	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 },
> -};
> -
> -int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
> -
> -
> -const char *get_system_type(void)
> -{
> -	return "Alchemy Pb1550";
> -}
> -
> -void __init prom_init(void)
> -{
> -	unsigned char *memsize_str;
> -	unsigned long memsize;
> -
> -	prom_argc = (int)fw_arg0;
> -	prom_argv = (char **)fw_arg1;
> -	prom_envp = (char **)fw_arg2;
> -
> -	prom_init_cmdline();
> -	memsize_str = prom_getenv("memsize");
> -	if (!memsize_str)
> -		memsize = 0x08000000;
> -	else
> -		strict_strtol(memsize_str, 0, &memsize);
> -	add_memory_region(0, memsize, BOOT_MEM_RAM);
> -}
> -
> -void board_reset(void)
> -{
> -	/* Hit BCSR.SYSTEM[RESET] */
> -	au_writew(au_readw(0xAF00001C) & ~BCSR_SYSTEM_RESET, 0xAF00001C);
> -}
> -
> -void __init board_setup(void)
> -{
> -	u32 pin_func;
> -
> -	/*
> -	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
> -	 * but it is board specific code, so put it here.
> -	 */
> -	pin_func = au_readl(SYS_PINFUNC);
> -	au_sync();
> -	pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
> -	au_writel(pin_func, SYS_PINFUNC);
> -
> -	au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
> -	au_sync();
> -
> -	printk(KERN_INFO "AMD Alchemy Pb1550 Board\n");
> -}
> diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
> index 813668f..1a83b2d 100644
> --- a/arch/mips/alchemy/xxs1500/board_setup.c
> +++ b/arch/mips/alchemy/xxs1500/board_setup.c
> @@ -84,6 +84,15 @@ void __init board_setup(void)
>  {
>  	u32 pin_func;
>  
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +	char *argptr = prom_getcmdline();
> +	argptr = strstr(argptr, "console=");
> +	if (argptr == NULL) {
> +		argptr = prom_getcmdline();
> +		strcat(argptr, " console=ttyS0,115200");
> +	}
> +#endif
> +
>  	/* Set multiple use pins (UART3/GPIO) to UART (it's used as UART too) */
>  	pin_func  = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
>  	pin_func |= SYS_PF_UR3;
-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P: 512.691.8044
