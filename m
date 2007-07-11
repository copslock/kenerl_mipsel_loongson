Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 19:43:05 +0100 (BST)
Received: from nic.NetDirect.CA ([216.16.235.2]:19586 "EHLO
	rubicon.netdirect.ca") by ftp.linux-mips.org with ESMTP
	id S20021714AbXGKSnD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 19:43:03 +0100
X-Originating-Ip: 72.143.66.27
Received: from [192.168.1.102] (CPE0018396a01fc-CM001225dbafb6.cpe.net.cable.rogers.com [72.143.66.27])
	(authenticated bits=0)
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id l6BIgT0j010818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mips@linux-mips.org>; Wed, 11 Jul 2007 14:42:43 -0400
Date:	Wed, 11 Jul 2007 14:40:45 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To:	linux-mips@linux-mips.org
Subject: latest list of apparently "dead" CONFIG variables under arch/mips
Message-ID: <Pine.LNX.4.64.0707111437480.12345@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck:	not spam, SpamAssassin (not cached,
	score=-36.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, INIT_RECVD_OUR_AUTH -20.00, UPPERCASE_25_50 0.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Return-Path: <rpjday@mindspring.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@mindspring.com
Precedence: bulk
X-list: linux-mips


  (i know i sent something like this recently, but it looks like this
list has changed so here it is again -- everywhere under arch/mips
that refers to a "CONFIG_" variable that is not defined in any Kconfig
file.)

  if you can flag which ones are just pure junk whose preprocessor
conditionals can be deleted, i can submit patches.  if it requires
anything beyond just a simple deletion, i'll leave it up to you.

  (for logical independence, i prefer to submit separate patches for
distinct variables, so they can be undone more easily if need be.)


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
arch/mips/kernel/Makefile:21:obj-$(CONFIG_CPU_R4000)		+= r4k_fpu.o r4k_switch.o
arch/mips/kernel/cpu-bugs64.c:159:#ifndef CONFIG_CPU_R4000
arch/mips/kernel/cpu-bugs64.c:237:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
arch/mips/kernel/cpu-bugs64.c:307:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
========== CPU_R4400 ==========
arch/mips/kernel/cpu-bugs64.c:237:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
arch/mips/kernel/cpu-bugs64.c:307:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
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
========== PMCTWILED ==========
arch/mips/configs/msp71xx_defconfig:941:CONFIG_PMCTWILED=y
arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:35:#ifdef CONFIG_PMCTWILED
arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:85:#ifdef CONFIG_PMCTWILED
arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:97:#ifdef CONFIG_PMCTWILED
arch/mips/pmc-sierra/msp71xx/msp_setup.c:249:#ifdef CONFIG_PMCTWILED
========== RM9K_GE ==========
arch/mips/basler/excite/excite_device.c:314:#if defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE)
arch/mips/basler/excite/excite_device.c:367:#endif /* defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE) */
arch/mips/basler/excite/excite_device.c:314:#if defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE)
arch/mips/basler/excite/excite_device.c:367:#endif /* defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE) */
========== SIBYTE_BCM1480_PROF ==========
arch/mips/sibyte/bcm1480/irq.c:460:#ifdef CONFIG_SIBYTE_BCM1480_PROF
arch/mips/sibyte/bcm1480/irq.c:467:#ifdef CONFIG_SIBYTE_BCM1480_PROF
========== SIBYTE_SB1250_DUART ==========
arch/mips/configs/sb1250-swarm_defconfig:661:CONFIG_SIBYTE_SB1250_DUART=y
arch/mips/configs/bigsur_defconfig:669:CONFIG_SIBYTE_SB1250_DUART=y
arch/mips/sibyte/bcm1480/irq.c:79:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/bcm1480/irq.c:407:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/sb1250/irq.c:64:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/sb1250/irq.c:362:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/cfe/console.c:49:#ifdef CONFIG_SIBYTE_SB1250_DUART
========== SOUND_AU1X00 ==========
arch/mips/au1000/common/setup.c:116:#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
========== SQUASHFS ==========
arch/mips/configs/msp71xx_defconfig:1307:CONFIG_SQUASHFS=y
arch/mips/pmc-sierra/msp71xx/msp_prom.c:46:#ifdef CONFIG_SQUASHFS
arch/mips/pmc-sierra/msp71xx/msp_prom.c:552:#ifdef CONFIG_SQUASHFS
arch/mips/pmc-sierra/msp71xx/msp_prom.c:554:		/* Get SQUASHFS size */
========== SYSCLK_75 ==========
arch/mips/gt64120/common/time.c:58:#ifdef CONFIG_SYSCLK_75
arch/mips/configs/ocelot_defconfig:79:# CONFIG_SYSCLK_75 is not set
========== SYSCLK_83 ==========
arch/mips/gt64120/common/time.c:55:#ifdef CONFIG_SYSCLK_83
arch/mips/configs/ocelot_defconfig:80:# CONFIG_SYSCLK_83 is not set
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
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
