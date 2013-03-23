Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:28:23 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2371 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834953Ab3CWS0i2390a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:38 +0100
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:19:22 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:18 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:18 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id F09B239289; Sat, 23
 Mar 2013 11:26:16 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 5/9] MIPS: Netlogic: Add 32-bit support for XLP
Date:   Sat, 23 Mar 2013 23:57:57 +0530
Message-ID: <fe9f33bd8e6c2338d3774c0696714bb904448abe.1364062916.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1364062916.git.jchandra@broadcom.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D532DA03YC8064113-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Update asm/netlogic/haldefs.h to extend register access functions
nlm_{read,write}_reg64() for 32-bit compilation. When compiled for 32-bit
the functions will read 64 IO registers with interrupts disabled.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/haldefs.h |   56 ++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/haldefs.h b/arch/mips/include/asm/netlogic/haldefs.h
index 419d8ae..61fecb8 100644
--- a/arch/mips/include/asm/netlogic/haldefs.h
+++ b/arch/mips/include/asm/netlogic/haldefs.h
@@ -35,14 +35,13 @@
 #ifndef __NLM_HAL_HALDEFS_H__
 #define __NLM_HAL_HALDEFS_H__
 
+#include <linux/irqflags.h>	/* for local_irq_disable */
+
 /*
  * This file contains platform specific memory mapped IO implementation
  * and will provide a way to read 32/64 bit memory mapped registers in
  * all ABIs
  */
-#if !defined(CONFIG_64BIT) && defined(CONFIG_CPU_XLP)
-#error "o32 compile not supported on XLP yet"
-#endif
 /*
  * For o32 compilation, we have to disable interrupts and enable KX bit to
  * access 64 bit addresses or data.
@@ -87,13 +86,40 @@ nlm_write_reg(uint64_t base, uint32_t reg, uint32_t val)
 	*addr = val;
 }
 
+/*
+ * For o32 compilation, we have to disable interrupts to access 64 bit
+ * registers
+ *
+ * We need to disable interrupts because we save just the lower 32 bits of
+ * registers in  interrupt handling. So if we get hit by an interrupt while
+ * using the upper 32 bits of a register, we lose.
+ */
+
 static inline uint64_t
 nlm_read_reg64(uint64_t base, uint32_t reg)
 {
 	uint64_t addr = base + (reg >> 1) * sizeof(uint64_t);
 	volatile uint64_t *ptr = (volatile uint64_t *)(long)addr;
-
-	return *ptr;
+	uint64_t val;
+
+	if (sizeof(unsigned long) == 4) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		__asm__ __volatile__(
+			".set	push"			"\n\t"
+			".set	mips64"			"\n\t"
+			"ld	%L0, %1"		"\n\t"
+			"dsra32	%M0, %L0, 0"		"\n\t"
+			"sll	%L0, %L0, 0"		"\n\t"
+			".set	pop"			"\n"
+			: "=r" (val)
+			: "m" (*ptr));
+		local_irq_restore(flags);
+	} else
+		val = *ptr;
+
+	return val;
 }
 
 static inline void
@@ -102,7 +128,25 @@ nlm_write_reg64(uint64_t base, uint32_t reg, uint64_t val)
 	uint64_t addr = base + (reg >> 1) * sizeof(uint64_t);
 	volatile uint64_t *ptr = (volatile uint64_t *)(long)addr;
 
-	*ptr = val;
+	if (sizeof(unsigned long) == 4) {
+		unsigned long flags;
+		uint64_t tmp;
+
+		local_irq_save(flags);
+		__asm__ __volatile__(
+			".set	push"			"\n\t"
+			".set	mips64"			"\n\t"
+			"dsll32	%L0, %L0, 0"		"\n\t"
+			"dsrl32	%L0, %L0, 0"		"\n\t"
+			"dsll32	%M0, %M0, 0"		"\n\t"
+			"or	%L0, %L0, %M0"		"\n\t"
+			"sd	%L0, %2"		"\n\t"
+			".set	pop"			"\n"
+			: "=r" (tmp)
+			: "0" (val), "m" (*ptr));
+		local_irq_restore(flags);
+	} else
+		*ptr = val;
 }
 
 /*
-- 
1.7.9.5
