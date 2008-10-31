Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2008 00:26:16 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:59573 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S22776818AbYJaA0J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Oct 2008 00:26:09 +0000
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 6321D38C5FB6
	for <linux-mips@linux-mips.org>; Fri, 31 Oct 2008 01:26:00 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Subject: [PATCH] add prototypes for the exported symbols
Date:	Fri, 31 Oct 2008 01:25:57 +0100
Message-Id: <1225412757-17894-1-git-send-email-n0-1@freewrt.org>
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <1225398000-24020-1-git-send-email-n0-1@freewrt.org>
References: <1225398000-24020-1-git-send-email-n0-1@freewrt.org>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Forgot to include them in the original patch.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/include/asm/mach-rc32434/gpio.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-rc32434/gpio.h b/arch/mips/include/asm/mach-rc32434/gpio.h
index c8e554e..b5cf645 100644
--- a/arch/mips/include/asm/mach-rc32434/gpio.h
+++ b/arch/mips/include/asm/mach-rc32434/gpio.h
@@ -84,5 +84,7 @@ extern void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned
 extern unsigned get_434_reg(unsigned reg_offs);
 extern void set_latch_u5(unsigned char or_mask, unsigned char nand_mask);
 extern unsigned char get_latch_u5(void);
+extern void rb532_gpio_set_ilevel(int bit, unsigned gpio);
+extern void rb532_gpio_set_istat(int bit, unsigned gpio);
 
 #endif /* _RC32434_GPIO_H_ */
-- 
1.5.6.4
