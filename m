Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 20:38:20 +0100 (BST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:13778 "EHLO
	astoria.ccjclearline.com") by ftp.linux-mips.org with ESMTP
	id S28580670AbYGYTiS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Jul 2008 20:38:18 +0100
Received: from [205.233.55.237] (helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1KMT7G-0003Md-LD
	for linux-mips@linux-mips.org; Fri, 25 Jul 2008 15:38:14 -0400
Date:	Fri, 25 Jul 2008 15:36:53 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:	linux-mips@linux-mips.org
Subject: MIPS-related unreferenced config variables
Message-ID: <alpine.LFD.1.10.0807251534310.4204@localhost.localdomain>
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
X-archive-position: 19972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


  just FYI (chances are some false positives):

===== ACER_PICA_61
arch/mips/jazz/Kconfig:1:config ACER_PICA_61
===== ARCH_SUPPORTS_OPROFILE
arch/mips/Kconfig:636:config ARCH_SUPPORTS_OPROFILE
===== CPU_SB1_PASS_2_112x
arch/mips/sibyte/Kconfig:109:config CPU_SB1_PASS_2_112x
===== CPU_SB1_PASS_2_1250
arch/mips/sibyte/Kconfig:88:config CPU_SB1_PASS_2_1250
===== CPU_SB1_PASS_3
arch/mips/sibyte/Kconfig:114:config CPU_SB1_PASS_3
===== CPU_SB1_PASS_4
arch/mips/sibyte/Kconfig:102:config CPU_SB1_PASS_4
===== MIPS_BOARDS_GEN
arch/mips/Kconfig:198:	select MIPS_BOARDS_GEN
arch/mips/Kconfig:846:config MIPS_BOARDS_GEN
include/asm-mips/mips-boards/generic.h:20:#ifndef __ASM_MIPS_BOARDS_GENERIC_H
include/asm-mips/mips-boards/generic.h:21:#define __ASM_MIPS_BOARDS_GENERIC_H
include/asm-mips/mips-boards/generic.h:104:#endif  /* __ASM_MIPS_BOARDS_GENERIC_H */
===== MIPS_DISABLE_OBSOLETE_IDE
arch/mips/au1000/Kconfig:36:	select MIPS_DISABLE_OBSOLETE_IDE
arch/mips/au1000/Kconfig:44:	select MIPS_DISABLE_OBSOLETE_IDE
arch/mips/au1000/Kconfig:53:	select MIPS_DISABLE_OBSOLETE_IDE
arch/mips/au1000/Kconfig:82:	select MIPS_DISABLE_OBSOLETE_IDE
arch/mips/au1000/Kconfig:97:	select MIPS_DISABLE_OBSOLETE_IDE
arch/mips/Kconfig:768:config MIPS_DISABLE_OBSOLETE_IDE
===== MIPS_INSANE_LARGE
arch/mips/Kconfig:1834:config MIPS_INSANE_LARGE
===== MIPS_MT_DISABLED
arch/mips/Kconfig:1383:config MIPS_MT_DISABLED
===== MIPS_RM9122
arch/mips/Kconfig:33:	select MIPS_RM9122
arch/mips/Kconfig:855:config MIPS_RM9122
===== SIBYTE_BCM1120
arch/mips/Kconfig:428:	select SIBYTE_BCM1120
arch/mips/Kconfig:439:	select SIBYTE_BCM1120
arch/mips/sibyte/Kconfig:12:config SIBYTE_BCM1120
===== SIBYTE_BCM1125
arch/mips/Kconfig:450:	select SIBYTE_BCM1125
arch/mips/Kconfig:462:	select SIBYTE_BCM1125H
arch/mips/sibyte/Kconfig:21:config SIBYTE_BCM1125
arch/mips/sibyte/Kconfig:31:config SIBYTE_BCM1125H
===== SIBYTE_BCM1125H
arch/mips/Kconfig:462:	select SIBYTE_BCM1125H
arch/mips/sibyte/Kconfig:31:config SIBYTE_BCM1125H
===== SIBYTE_ENABLE_LDT_IF_PCI
arch/mips/sibyte/Kconfig:7:	select SIBYTE_ENABLE_LDT_IF_PCI
arch/mips/sibyte/Kconfig:38:	select SIBYTE_ENABLE_LDT_IF_PCI
arch/mips/sibyte/Kconfig:127:config SIBYTE_ENABLE_LDT_IF_PCI

rday
--

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
