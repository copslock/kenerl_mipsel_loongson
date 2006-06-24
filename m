Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2006 02:29:38 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:63152 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133800AbWFXB3Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jun 2006 02:29:24 +0100
Received: (qmail 1233 invoked by uid 101); 24 Jun 2006 01:29:12 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 24 Jun 2006 01:29:12 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5O1TB5w028455;
	Fri, 23 Jun 2006 18:29:12 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7KJAJ>; Fri, 23 Jun 2006 18:29:11 -0700
Message-ID: <C28979E4F697C249ABDA83AC0C33CDF8143EF3@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0/6] Sequoia Patches
Date:	Fri, 23 Jun 2006 18:29:03 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


Hi Ralf and list,
 Please merge the following patches for PMC-Sierra Sequoia platform for linux-2.6.12.
http://www.linux-mips.org/pub/linux/mips/kernel/v2.6/linux-2.6.12.tar.gz


Patch [1/6] - Sequoia Configs
Patch [2/6] - Sequoia PCI
Patch [3/6] - Sequoia Platform
Patch [4/6] - Sequoia Serial
Patch [5/6] - RM9000 arch
Patch [6/6] - MSP85x0 gige Driver (also submitting to netdev mailing list)


And the diffstat is -

 arch/mips/Kconfig                                     |   22 
 arch/mips/Makefile                                    |    4 
 arch/mips/configs/sequoia_defconfig                   |  701 +++++
 arch/mips/mm/c-r4k.c                                  |   11 
 arch/mips/mm/sc-rm7k.c                                |    9 
 arch/mips/mm/tlbex.c                                  |   50 
 arch/mips/pci/Makefile                                |    2 
 arch/mips/pci/fixup-sequoia.c                         |   43 
 arch/mips/pci/ops-sequoia.c                           |  187 +
 arch/mips/pci/pci-sequoia.c                           |   78 
 arch/mips/pmc-sierra/sequoia/Makefile                 |    7 
 arch/mips/pmc-sierra/sequoia/irq-handler.S            |   99 
 arch/mips/pmc-sierra/sequoia/irq.c                    |  224 +
 arch/mips/pmc-sierra/sequoia/prom.c                   |  140 +
 arch/mips/pmc-sierra/sequoia/py-console.c             |  123 +
 arch/mips/pmc-sierra/sequoia/setup.c                  |  258 ++
 arch/mips/pmc-sierra/sequoia/setup.h                  |   17 
 drivers/net/Kconfig                                   |    2 
 drivers/net/Makefile                                  |    3 
 drivers/net/msp85x0_ge.c                              | 2142 ++++++++++++++++++
 drivers/net/msp85x0_ge.h                              |  452 +++
 drivers/net/titan_mdio.c                              |   21 
 drivers/net/titan_mdio.h                              |    5 
 drivers/serial/8250.c                                 |   18 
 include/asm-mips/bootinfo.h                           |    2 
 include/asm-mips/mach-sequoia/cpu-feature-overrides.h |   45 
 include/asm-mips/pmc_sequoia.h                        |  296 ++
 include/asm-mips/serial.h                             |    5 
 include/asm-mips/war.h                                |   11 
 include/linux/serial_reg.h                            |   63 
 30 files changed, 5036 insertions(+), 4 deletions(-)


Comments?

Kiran
