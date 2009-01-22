Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2009 18:29:06 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:12676 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21103481AbZAVS3D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2009 18:29:03 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id 07E45400E106;
	Thu, 22 Jan 2009 19:28:57 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] rb532: update headers
Date:	Thu, 22 Jan 2009 19:28:50 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Message-Id: <20090122182858.07E45400E106@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Remove the {set,get}_434_reg() prototypes, as the functions have been
removed. Also move the prototypes for {get,set}_latch_u5() to the
correct place.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/include/asm/mach-rc32434/gpio.h |    4 ----
 arch/mips/include/asm/mach-rc32434/rb.h   |    3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-rc32434/gpio.h b/arch/mips/include/asm/mach-rc32434/gpio.h
index b5cf645..ca92c81 100644
--- a/arch/mips/include/asm/mach-rc32434/gpio.h
+++ b/arch/mips/include/asm/mach-rc32434/gpio.h
@@ -80,10 +80,6 @@ struct rb532_gpio_reg {
 /* Compact Flash GPIO pin */
 #define CF_GPIO_NUM		13
 
-extern void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned val);
-extern unsigned get_434_reg(unsigned reg_offs);
-extern void set_latch_u5(unsigned char or_mask, unsigned char nand_mask);
-extern unsigned char get_latch_u5(void);
 extern void rb532_gpio_set_ilevel(int bit, unsigned gpio);
 extern void rb532_gpio_set_istat(int bit, unsigned gpio);
 
diff --git a/arch/mips/include/asm/mach-rc32434/rb.h b/arch/mips/include/asm/mach-rc32434/rb.h
index f25a849..6dc5f8d 100644
--- a/arch/mips/include/asm/mach-rc32434/rb.h
+++ b/arch/mips/include/asm/mach-rc32434/rb.h
@@ -83,4 +83,7 @@ struct mpmc_device {
 	void __iomem 	*base;
 };
 
+extern void set_latch_u5(unsigned char or_mask, unsigned char nand_mask);
+extern unsigned char get_latch_u5(void);
+
 #endif  /* __ASM_RC32434_RB_H */
-- 
1.5.6.4
