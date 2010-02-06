Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2010 18:47:34 +0100 (CET)
Received: from cpsmtpm-eml101.kpnxchange.com ([195.121.3.5]:53183 "EHLO
        CPSMTPM-EML101.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492067Ab0BFRr3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Feb 2010 18:47:29 +0100
Received: from elrond.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML101.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
         Sat, 6 Feb 2010 18:47:25 +0100
Received: from aragorn.fjphome.nl ([10.19.66.13])
        by elrond.fjphome.nl with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <fjp@aragorn.fjphome.nl>)
        id 1Ndokf-0000X0-11; Sat, 06 Feb 2010 18:47:25 +0100
Received: from fjp by aragorn.fjphome.nl with local (Exim 4.69)
        (envelope-from <fjp@aragorn.fjphome.nl>)
        id 1Ndoke-00085x-AY; Sat, 06 Feb 2010 18:47:24 +0100
From:   Frans Pop <elendil@planet.nl>
To:     linux-kernel@vger.kernel.org
Cc:     Frans Pop <elendil@planet.nl>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 06/16] mips: remove trailing space in messages
Date:   Sat,  6 Feb 2010 18:47:13 +0100
Message-Id: <1265478443-31072-6-git-send-email-elendil@planet.nl>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <201002061844.45212.elendil@planet.nl>
References: <201002061844.45212.elendil@planet.nl>
X-OriginalArrivalTime: 06 Feb 2010 17:47:25.0573 (UTC) FILETIME=[716FE350:01CAA754]
Return-Path: <elendil@planet.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elendil@planet.nl
Precedence: bulk
X-list: linux-mips

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/alchemy/common/dbdma.c                  |    2 +-
 arch/mips/cavium-octeon/smp.c                     |    2 +-
 arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 5c68569..4050640 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -903,7 +903,7 @@ void au1xxx_dbdma_dump(u32 chanid)
 	dtp = ctp->chan_dest;
 	cp = ctp->chan_ptr;
 
-	printk(KERN_DEBUG "Chan %x, stp %x (dev %d)  dtp %x (dev %d) \n",
+	printk(KERN_DEBUG "Chan %x, stp %x (dev %d)  dtp %x (dev %d)\n",
 			  (u32)ctp, (u32)stp, stp - dbdev_tab, (u32)dtp,
 			  dtp - dbdev_tab);
 	printk(KERN_DEBUG "desc base %x, get %x, put %x, cur %x\n",
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index c198efd..51e9802 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -327,7 +327,7 @@ static void octeon_cpu_die(unsigned int cpu)
 				   avail_coremask);
 	}
 
-	pr_info("Reset core %d. Available Coremask = %x \n", coreid,
+	pr_info("Reset core %d. Available Coremask = %x\n", coreid,
 		avail_coremask);
 	cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
 	cvmx_write_csr(CVMX_CIU_PP_RST, 0);
diff --git a/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c b/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c
index fc990cb..d6f8bdf 100644
--- a/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c
+++ b/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c
@@ -127,7 +127,7 @@ static int recv_ack(void)
 
 	if (ack) {
 		do_idle();
-		printk(KERN_ERR "Error reading the Atmel 24C32/24C64 EEPROM \n");
+		printk(KERN_ERR "Error reading the Atmel 24C32/24C64 EEPROM\n");
 		return -1;
 	}
 
-- 
1.6.6.1
