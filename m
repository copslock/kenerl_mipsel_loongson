Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 13:59:31 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.157]:15299 "EHLO
	yw-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023083AbZD0M7Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 13:59:25 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1399702ywk.24
        for <multiple recipients>; Mon, 27 Apr 2009 05:59:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject:cc
         :message-id:from:date;
        bh=1x30Ff+2tTp/y4B+2Q4Qfv23GyK5fnvMoimGQl83JUg=;
        b=e+/GeY7606K7LzWh6y0kDo96JwxO59NRkYy00FGt2iMfqpcTeLZdsG4o+CAMrpxCqt
         cvJXx7Rv+nRUYVHrnnWaVIg++O54ofVlMLGJGXeLbqlz/X24q5lr2WP8hT4ZT7k9za1H
         8EWn52ftlxKWnNpRwsryNkDSwsrTVMp6Vp3wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:cc:message-id:from:date;
        b=VClJZ7w4rANpvPQysDHPnvHScGfRujYQbP137V0N/fgzahkZbgEaaFEIXd55QFNFS2
         X4ZqFK56DtgB1nCR3kg6GDmJvv1BZPBcqwVHTOiTJrofdLN7AfI+Q1T/ueWHG9hXjfY+
         ArXj9MxFGuEk9Nowr/epEDDx49NbSieL3egqQ=
Received: by 10.100.105.15 with SMTP id d15mr8322624anc.154.1240837163652;
        Mon, 27 Apr 2009 05:59:23 -0700 (PDT)
Received: from localhost (207-47-250-185.sktn.hsdb.sasknet.sk.ca [207.47.250.185])
        by mx.google.com with ESMTPS id d22sm10110046and.25.2009.04.27.05.59.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 05:59:19 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1LyQQX-00047N-6E; Mon, 27 Apr 2009 06:59:17 -0600
To:	linux-mips@linux-mips.org
Subject: [MIPS] Resolve compile issues with msp71xx configuration
Cc:	ralf@linux-mips.org
Message-Id: <E1LyQQX-00047N-6E@localhost>
From:	Shane McDonald <mcdonald.shane@gmail.com>
Date:	Mon, 27 Apr 2009 06:59:17 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

There have been a number of compile problems with the msp71xx
configuration ever since it was included in the linux-mips.org
repository.  This patch resolves these problems:
 - proper files are included when using a squashfs rootfs
 - resetting the board no longer uses non-existent GPIO routines
 - create the required plat_timer_setup function

This patch has been compile-tested against the current HEAD.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_prom.c  |    3 ++-
 arch/mips/pmc-sierra/msp71xx/msp_setup.c |    8 ++------
 arch/mips/pmc-sierra/msp71xx/msp_time.c  |    7 ++-----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
index e5bd548..1e2d984 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
@@ -44,7 +44,8 @@
 #include <linux/cramfs_fs.h>
 #endif
 #ifdef CONFIG_SQUASHFS
-#include <linux/squashfs_fs.h>
+#include <linux/magic.h>
+#include "../../../../fs/squashfs/squashfs_fs.h"
 #endif
 
 #include <asm/addrspace.h>
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
index c936756..a54e85b 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
@@ -21,7 +21,6 @@
 
 #if defined(CONFIG_PMC_MSP7120_GW)
 #include <msp_regops.h>
-#include <msp_gpio.h>
 #define MSP_BOARD_RESET_GPIO	9
 #endif
 
@@ -88,11 +87,8 @@ void msp7120_reset(void)
 	 * as GPIO char driver may not be enabled and it would look up
 	 * data inRAM!
 	 */
-	set_value_reg32(GPIO_CFG3_REG,
-			basic_mode_mask(MSP_BOARD_RESET_GPIO),
-			basic_mode(MSP_GPIO_OUTPUT, MSP_BOARD_RESET_GPIO));
-	set_reg32(GPIO_DATA3_REG,
-			basic_data_mask(MSP_BOARD_RESET_GPIO));
+	set_value_reg32(GPIO_CFG3_REG, 0xf000, 0x8000);
+	set_reg32(GPIO_DATA3_REG, 8);
 
 	/*
 	 * In case GPIO9 doesn't reset the board (jumper configurable!)
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index 7cfeda5..cca64e1 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -81,10 +81,7 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = cpu_rate/2;
 }
 
-void __init plat_timer_setup(struct irqaction *irq)
+unsigned int __init get_c0_compare_int(void)
 {
-#ifdef CONFIG_IRQ_MSP_CIC
-	/* we are using the vpe0 counter for timer interrupts */
-	setup_irq(MSP_INT_VPE0_TIMER, irq);
-#endif
+	return MSP_INT_VPE0_TIMER;
 }
-- 
1.5.6.5
