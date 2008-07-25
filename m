Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 23:03:29 +0100 (BST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:51859 "EHLO
	astoria.ccjclearline.com") by ftp.linux-mips.org with ESMTP
	id S28580997AbYGYWD1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Jul 2008 23:03:27 +0100
Received: from [205.233.55.237] (helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1KMVNk-0005Hx-Ur
	for linux-mips@linux-mips.org; Fri, 25 Jul 2008 18:03:25 -0400
Date:	Fri, 25 Jul 2008 18:01:35 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:	linux-mips@linux-mips.org
Subject: more MIPS-related config variable issues, just FYI
Message-ID: <alpine.LFD.1.10.0807251758560.4566@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


  first, what i call "badref" config variables -- tests on what should
be config variables that are, in fact, not defined in any Kconfig
file:

>>>>> EXCITE_FCAP_GPI
arch/mips/basler/excite/excite_device.c:164:#if defined(CONFIG_EXCITE_FCAP_GPI) || defined(CONFIG_EXCITE_FCAP_GPI_MODULE)
arch/mips/basler/excite/excite_device.c:227:#endif /* defined(CONFIG_EXCITE_FCAP_GPI) || defined(CONFIG_EXCITE_FCAP_GPI_MODULE) */
>>>>> HT_LEVEL_TRIGGER
arch/mips/pmc-sierra/yosemite/irq.c:80:#ifdef CONFIG_HT_LEVEL_TRIGGER
arch/mips/pmc-sierra/yosemite/irq.c:109:#endif /* CONFIG_HT_LEVEL_TRIGGER */
>>>>> PCMCIA_XXS1500
arch/mips/au1000/xxs1500/board_setup.c:55:#ifdef CONFIG_PCMCIA_XXS1500
>>>>> PMCTWILED
arch/mips/pmc-sierra/msp71xx/msp_setup.c:233:#ifdef CONFIG_PMCTWILED
arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:35:#ifdef CONFIG_PMCTWILED
arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:85:#ifdef CONFIG_PMCTWILED
arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:97:#ifdef CONFIG_PMCTWILED
arch/mips/configs/msp71xx_defconfig:934:CONFIG_PMCTWILED=y
>>>>> RM9K_GE
arch/mips/basler/excite/excite_device.c:314:#if defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE)
arch/mips/basler/excite/excite_device.c:367:#endif /* defined(CONFIG_RM9K_GE) || defined(CONFIG_RM9K_GE_MODULE) */
>>>>> SIBYTE_BCM1480_PROF
arch/mips/sibyte/bcm1480/irq.c:445:#ifdef CONFIG_SIBYTE_BCM1480_PROF
arch/mips/sibyte/bcm1480/irq.c:452:#ifdef CONFIG_SIBYTE_BCM1480_PROF
>>>>> SOC_AU1000_FREQUENCY
arch/mips/au1000/common/time.c:202:#ifdef CONFIG_SOC_AU1000_FREQUENCY
arch/mips/au1000/common/time.c:203:		cpu_speed = CONFIG_SOC_AU1000_FREQUENCY;
arch/mips/au1000/common/setup.c:59:#ifdef CONFIG_SOC_AU1000_FREQUENCY
arch/mips/au1000/common/setup.c:60:		cpufreq = CONFIG_SOC_AU1000_FREQUENCY / 1000000;
>>>>> SOUND_AU1X00
arch/mips/au1000/common/setup.c:101:#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
>>>>> SQUASHFS
arch/powerpc/configs/ppc6xx_defconfig:2962:CONFIG_SQUASHFS=m
arch/mips/pmc-sierra/msp71xx/msp_prom.c:46:#ifdef CONFIG_SQUASHFS
arch/mips/pmc-sierra/msp71xx/msp_prom.c:552:#ifdef CONFIG_SQUASHFS
arch/mips/configs/msp71xx_defconfig:1300:CONFIG_SQUASHFS=y
arch/mips/pmc-sierra/msp71xx/msp_prom.c:554:		/* Get SQUASHFS size */

  and, additionally, "badref" config variables that occur solely in
Makefiles:

===== MSPETH =====
./arch/mips/pmc-sierra/msp71xx/Makefile:obj-$(CONFIG_MSPETH) += msp_eth.o
===== USB_MSP71XX =====
./arch/mips/pmc-sierra/msp71xx/Makefile:obj-$(CONFIG_USB_MSP71XX) += msp_usb.o

  whether any of the above is an issue is entirely up to you.

rday
--

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
