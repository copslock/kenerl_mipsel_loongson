Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 15:46:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63699 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021864AbXGEOqm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jul 2007 15:46:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l65EkfJJ020457;
	Thu, 5 Jul 2007 15:46:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l65EkfTL020456;
	Thu, 5 Jul 2007 15:46:41 +0100
Date:	Thu, 5 Jul 2007 15:46:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org,
	"Robert P. J. Day" <rpjday@mindspring.com>
Subject: dead(?) MIPS config stuff
Message-ID: <20070705144641.GA20210@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

----- Forwarded message from "Robert P. J. Day" <rpjday@mindspring.com> -----

From: "Robert P. J. Day" <rpjday@mindspring.com>
Date: Thu, 5 Jul 2007 06:38:14 -0400 (EDT)
To: Ralf Baechle <ralf@linux-mips.org>
Subject: dead(?) MIPS config stuff
Content-Type: TEXT/PLAIN; charset=US-ASCII


  a brute force run of my latest dead CONFIG variable script, you can
decide if any of it is of interest.

========== AU1000_SRC_CLK ==========
arch/mips/au1000/common/time.c:206:#ifdef CONFIG_AU1000_SRC_CLK
arch/mips/au1000/common/time.c:207:#define AU1000_SRC_CLK	CONFIG_AU1000_SRC_CLK
arch/mips/au1000/common/time.c:207:#define AU1000_SRC_CLK	CONFIG_AU1000_SRC_CLK
arch/mips/au1000/common/time.c:209:#define AU1000_SRC_CLK	12000000
arch/mips/au1000/common/time.c:275:			AU1000_SRC_CLK;
arch/mips/au1000/common/time.c:283:		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
========== AU1000_USE32K ==========
arch/mips/au1000/common/time.c:250:#if defined(CONFIG_AU1000_USE32K)
========== AU1XXX_PSC_SPI ==========
arch/mips/au1000/pb1200/board_setup.c:134:#if defined(CONFIG_AU1XXX_PSC_SPI) && defined(CONFIG_I2C_AU1550)
arch/mips/au1000/pb1200/board_setup.c:137:#elif defined( CONFIG_AU1XXX_PSC_SPI )
========== CPU_R4000 ==========
arch/mips/kernel/Makefile:20:obj-$(CONFIG_CPU_R4000)		+= r4k_fpu.o r4k_switch.o
arch/mips/kernel/cpu-bugs64.c:159:#ifndef CONFIG_CPU_R4000
arch/mips/kernel/cpu-bugs64.c:237:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
arch/mips/kernel/cpu-bugs64.c:307:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
========== CPU_R4400 ==========
arch/mips/kernel/cpu-bugs64.c:237:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
arch/mips/kernel/cpu-bugs64.c:307:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
========== CPU_SR71000 ==========
arch/mips/momentum/ocelot_c/prom.c:36:#ifdef CONFIG_CPU_SR71000
arch/mips/momentum/ocelot_c/setup.c:215:#ifdef CONFIG_CPU_SR71000
arch/mips/momentum/ocelot_c/setup.c:271:#ifdef CONFIG_CPU_SR71000
arch/mips/kernel/cpu-probe.c:702:		c->cputype = CPU_SR71000;
arch/mips/kernel/proc.c:85:	[CPU_SR71000]	= "Sandcraft SR71000",
include/asm-mips/cpu.h:191:#define CPU_SR71000		53
========== EXCITE_FCAP_GPI ==========
arch/mips/basler/excite/excite_device.c:164:#if defined(CONFIG_EXCITE_FCAP_GPI) || defined(CONFIG_EXCITE_FCAP_GPI_MODULE)
arch/mips/basler/excite/excite_device.c:227:#endif /* defined(CONFIG_EXCITE_FCAP_GPI) || defined(CONFIG_EXCITE_FCAP_GPI_MODULE) */
arch/mips/basler/excite/excite_device.c:164:#if defined(CONFIG_EXCITE_FCAP_GPI) || defined(CONFIG_EXCITE_FCAP_GPI_MODULE)
arch/mips/basler/excite/excite_device.c:227:#endif /* defined(CONFIG_EXCITE_FCAP_GPI) || defined(CONFIG_EXCITE_FCAP_GPI_MODULE) */
========== FB_XPERT98 ==========
arch/mips/au1000/common/setup.c:109:#ifdef CONFIG_FB_XPERT98
========== HT_LEVEL_TRIGGER ==========
arch/mips/pmc-sierra/yosemite/irq.c:77:#ifdef CONFIG_HT_LEVEL_TRIGGER
arch/mips/pmc-sierra/yosemite/irq.c:106:#endif /* CONFIG_HT_LEVEL_TRIGGER */
========== MIPS_HYDROGEN3 ==========
arch/mips/au1000/common/setup.c:103:#ifdef CONFIG_MIPS_HYDROGEN3
========== PCMCIA_XXS1500 ==========
arch/mips/au1000/xxs1500/board_setup.c:66:#ifdef CONFIG_PCMCIA_XXS1500
========== RM9K_GE ==========
arch/mips/basler/excite/excite_device.c:314:#if defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE)
arch/mips/basler/excite/excite_device.c:367:#endif /* defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE) */
arch/mips/basler/excite/excite_device.c:314:#if defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE)
arch/mips/basler/excite/excite_device.c:367:#endif /* defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE) */
========== SIBYTE_BCM1480_PROF ==========
arch/mips/sibyte/bcm1480/irq.c:460:#ifdef CONFIG_SIBYTE_BCM1480_PROF
arch/mips/sibyte/bcm1480/irq.c:467:#ifdef CONFIG_SIBYTE_BCM1480_PROF
========== SIBYTE_SB1250_DUART ==========
arch/mips/configs/sb1250-swarm_defconfig:665:CONFIG_SIBYTE_SB1250_DUART=y
arch/mips/configs/bigsur_defconfig:673:CONFIG_SIBYTE_SB1250_DUART=y
arch/mips/sibyte/bcm1480/irq.c:79:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/bcm1480/irq.c:407:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/sb1250/irq.c:64:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/sb1250/irq.c:362:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/cfe/console.c:49:#ifdef CONFIG_SIBYTE_SB1250_DUART
========== SMTC_IDLE_HOOK_DEBUG ==========
arch/mips/kernel/smtc.c:146:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
arch/mips/kernel/smtc.c:181:#endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
arch/mips/kernel/smtc.c:399:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
arch/mips/kernel/smtc.c:402:#endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
arch/mips/kernel/smtc.c:614:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
arch/mips/kernel/smtc.c:828:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
arch/mips/kernel/smtc.c:830:#endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
arch/mips/kernel/smtc.c:1055:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
arch/mips/kernel/smtc.c:1148:#endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
arch/mips/kernel/process.c:54:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
arch/mips/Kconfig.debug:40:config CONFIG_SMTC_IDLE_HOOK_DEBUG
========== SOUND_AU1X00 ==========
arch/mips/au1000/common/setup.c:116:#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
========== TX4927BUG_WORKAROUND ==========
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:141:#define CONFIG_TX4927BUG_WORKAROUND
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:672:#ifdef CONFIG_TX4927BUG_WORKAROUND
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:914:#ifdef CONFIG_TX4927BUG_WORKAROUND
========== USB_OHCI ==========
arch/mips/au1000/pb1000/board_setup.c:57:#ifdef CONFIG_USB_OHCI
arch/mips/au1000/pb1000/board_setup.c:105:#ifdef CONFIG_USB_OHCI
arch/mips/au1000/pb1000/board_setup.c:119:#endif // defined (CONFIG_USB_OHCI)
arch/mips/au1000/pb1500/board_setup.c:59:#ifdef CONFIG_USB_OHCI
arch/mips/au1000/pb1500/board_setup.c:88:#ifdef CONFIG_USB_OHCI
arch/mips/au1000/pb1500/board_setup.c:98:#endif // defined (CONFIG_USB_OHCI)
arch/mips/au1000/pb1100/board_setup.c:57:#ifdef CONFIG_USB_OHCI
arch/mips/au1000/pb1100/board_setup.c:101:#endif // defined (CONFIG_USB_OHCI)
arch/mips/au1000/mtx-1/board_setup.c:57:#ifdef CONFIG_USB_OHCI
arch/mips/au1000/mtx-1/board_setup.c:61:#endif // defined (CONFIG_USB_OHCI)


-- 

Some of the stuff does exist intentionally such as the R4000 bits.  Much
of the remainder however seems to be waiting to be chainsawed.

  Ralf
