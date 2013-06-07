Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:08:37 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:46658 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835164Ab3FGXD4fnGWl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:56 +0200
Received: by mail-ie0-f182.google.com with SMTP id 9so12101300iec.13
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9BGjGlE0G40sz4Enz1491hzF/nrHQVjaRxXokg9VD6M=;
        b=YCIb6+Y970chIJgQZx7xrEuAkmGzwCscdntteD0T6nephZVyCmiqUrbCYOilWJMq1h
         cD7x26beAKrLA9JmQJwZf/pxBQqQwr6LqUfURIaeHHP8xfPC0Q7n1ErYvliCV6zY3DPL
         S9MQf/hqWnXBo5KTL9DTT5x7bErRDX3OTbhanU+4bTr1wnOYYhVtyMF/L+tsF4CjcpXv
         156/lr1+OROPFKrf3R4i/6ALuWD+DNctLbkeOGF1SVt5T8ImirAJgmMy2eNiOhkiZFQ0
         Ny0c+4uASctOXeuE+OtYbcNzO2DVISddImE5YthkdmziutIJlXWtyK+MN+qLthI6g6Us
         LtOw==
X-Received: by 10.50.16.102 with SMTP id f6mr1851311igd.41.1370646230485;
        Fri, 07 Jun 2013 16:03:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nt6sm135547igb.10.2013.06.07.16.03.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3lg7006662;
        Fri, 7 Jun 2013 16:03:47 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3l8l006661;
        Fri, 7 Jun 2013 16:03:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 13/31] mips/kvm: Add accessors for MIPS VZ registers.
Date:   Fri,  7 Jun 2013 16:03:17 -0700
Message-Id: <1370646215-6543-14-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

There are accessors for both the guest control registers as well as
guest CP0 context.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mipsregs.h | 260 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 260 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 6f03c72..0addfec 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -50,10 +50,13 @@
 #define CP0_WIRED $6
 #define CP0_INFO $7
 #define CP0_BADVADDR $8
+#define CP0_BADINSTR $8, 1
+#define CP0_BADINSTRP $8, 2
 #define CP0_COUNT $9
 #define CP0_ENTRYHI $10
 #define CP0_COMPARE $11
 #define CP0_STATUS $12
+#define CP0_GUESTCTL0 $12, 6
 #define CP0_CAUSE $13
 #define CP0_EPC $14
 #define CP0_PRID $15
@@ -623,6 +626,10 @@
 #define MIPS_FPIR_L		(_ULCAST_(1) << 21)
 #define MIPS_FPIR_F64		(_ULCAST_(1) << 22)
 
+/* Bits in the MIPS VZ GuestCtl0 Register */
+#define MIPS_GUESTCTL0B_GM	31
+#define MIPS_GUESTCTL0F_GM	(_ULCAST_(1) << MIPS_GUESTCTL0B_GM)
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -851,6 +858,144 @@ do {									\
 	local_irq_restore(__flags);					\
 } while (0)
 
+/*
+ * Macros to access the VZ Guest system control coprocessor
+ */
+
+#define __read_32bit_gc0_register(source, sel)				\
+	({ int __res;							\
+		__asm__ __volatile__(					\
+		".set mips64r2\n\t"					\
+		".set\tvirt\n\t"					\
+		".ifeq 0-" #sel "\n\t"					\
+		"mfgc0\t%0, " #source ", 0\n\t"				\
+		".endif\n\t"						\
+		".ifeq 1-" #sel "\n\t"					\
+		"mfgc0\t%0, " #source ", 1\n\t"				\
+		".endif\n\t"						\
+		".ifeq 2-" #sel "\n\t"					\
+		"mfgc0\t%0, " #source ", 2\n\t"				\
+		".endif\n\t"						\
+		".ifeq 3-" #sel "\n\t"					\
+		"mfgc0\t%0, " #source ", 3\n\t"				\
+		".endif\n\t"						\
+		".ifeq 4-" #sel "\n\t"					\
+		"mfgc0\t%0, " #source ", 4\n\t"				\
+		".endif\n\t"						\
+		".ifeq 5-" #sel "\n\t"					\
+		"mfgc0\t%0, " #source ", 5\n\t"				\
+		".endif\n\t"						\
+		".ifeq 6-" #sel "\n\t"					\
+		"mfgc0\t%0, " #source ", 6\n\t"				\
+		".endif\n\t"						\
+		".ifeq 7-" #sel "\n\t"					\
+		"mfgc0\t%0, " #source ", 7\n\t"				\
+		".endif\n\t"						\
+		".set\tmips0"						\
+		: "=r" (__res));					\
+	__res;								\
+})
+
+#define __read_64bit_gc0_register(source, sel)				\
+	({ unsigned long long __res;					\
+		__asm__ __volatile__(					\
+		".set mips64r2\n\t"					\
+		".set\tvirt\n\t"					\
+		".ifeq 0-" #sel "\n\t"					\
+		"dmfgc0\t%0, " #source ", 0\n\t"			\
+		".endif\n\t"						\
+		".ifeq 1-" #sel "\n\t"					\
+		"dmfgc0\t%0, " #source ", 1\n\t"			\
+		".endif\n\t"						\
+		".ifeq 2-" #sel "\n\t"					\
+		"dmfgc0\t%0, " #source ", 2\n\t"			\
+		".endif\n\t"						\
+		".ifeq 3-" #sel "\n\t"					\
+		"dmfgc0\t%0, " #source ", 3\n\t"			\
+		".endif\n\t"						\
+		".ifeq 4-" #sel "\n\t"					\
+		"dmfgc0\t%0, " #source ", 4\n\t"			\
+		".endif\n\t"						\
+		".ifeq 5-" #sel "\n\t"					\
+		"dmfgc0\t%0, " #source ", 5\n\t"			\
+		".endif\n\t"						\
+		".ifeq 6-" #sel "\n\t"					\
+		"dmfgc0\t%0, " #source ", 6\n\t"			\
+		".endif\n\t"						\
+		".ifeq 7-" #sel "\n\t"					\
+		"dmfgc0\t%0, " #source ", 7\n\t"			\
+		".endif\n\t"						\
+		".set\tmips0"						\
+		: "=r" (__res));					\
+	__res;								\
+})
+
+#define __write_32bit_gc0_register(source, sel, value)			\
+do {									\
+	__asm__ __volatile__(						\
+		".set mips64r2\n\t"					\
+		".set\tvirt\n\t"					\
+		".ifeq 0-" #sel "\n\t"					\
+		"mtgc0\t%z0, " #source ", 0\n\t"			\
+		".endif\n\t"						\
+		".ifeq 1-" #sel "\n\t"					\
+		"mtgc0\t%z0, " #source ", 1\n\t"			\
+		".endif\n\t"						\
+		".ifeq 2-" #sel "\n\t"					\
+		"mtgc0\t%z0, " #source ", 2\n\t"			\
+		".endif\n\t"						\
+		".ifeq 3-" #sel "\n\t"					\
+		"mtgc0\t%z0, " #source ", 3\n\t"			\
+		".endif\n\t"						\
+		".ifeq 4-" #sel "\n\t"					\
+		"mtgc0\t%z0, " #source ", 4\n\t"			\
+		".endif\n\t"						\
+		".ifeq 5-" #sel "\n\t"					\
+		"mtgc0\t%z0, " #source ", 5\n\t"			\
+		".endif\n\t"						\
+		".ifeq 6-" #sel "\n\t"					\
+		"mtgc0\t%z0, " #source ", 6\n\t"			\
+		".endif\n\t"						\
+		".ifeq 7-" #sel "\n\t"					\
+		"mtgc0\t%z0, " #source ", 7\n\t"			\
+		".endif\n\t"						\
+		".set\tmips0"						\
+		: : "Jr" ((unsigned int)(value)));			\
+} while (0)
+
+#define __write_64bit_gc0_register(source, sel, value)			\
+do {									\
+	__asm__ __volatile__(						\
+		".set mips64r2\n\t"					\
+		".set\tvirt\n\t"					\
+		".ifeq 0-" #sel "\n\t"					\
+		"dmtgc0\t%z0, " #source ", 0\n\t"			\
+		".endif\n\t"						\
+		".ifeq 1-" #sel "\n\t"					\
+		"dmtgc0\t%z0, " #source ", 1\n\t"			\
+		".endif\n\t"						\
+		".ifeq 2-" #sel "\n\t"					\
+		"dmtgc0\t%z0, " #source ", 2\n\t"			\
+		".endif\n\t"						\
+		".ifeq 3-" #sel "\n\t"					\
+		"dmtgc0\t%z0, " #source ", 3\n\t"			\
+		".endif\n\t"						\
+		".ifeq 4-" #sel "\n\t"					\
+		"dmtgc0\t%z0, " #source ", 4\n\t"			\
+		".endif\n\t"						\
+		".ifeq 5-" #sel "\n\t"					\
+		"dmtgc0\t%z0, " #source ", 5\n\t"			\
+		".endif\n\t"						\
+		".ifeq 6-" #sel "\n\t"					\
+		"dmtgc0\t%z0, " #source ", 6\n\t"			\
+		".endif\n\t"						\
+		".ifeq 7-" #sel "\n\t"					\
+		"dmtgc0\t%z0, " #source ", 7\n\t"			\
+		".endif\n\t"						\
+		".set\tmips0"						\
+		: : "Jr" (value));					\
+} while (0)
+
 #define read_c0_index()		__read_32bit_c0_register($0, 0)
 #define write_c0_index(val)	__write_32bit_c0_register($0, 0, val)
 
@@ -889,6 +1034,12 @@ do {									\
 #define read_c0_badvaddr()	__read_ulong_c0_register($8, 0)
 #define write_c0_badvaddr(val)	__write_ulong_c0_register($8, 0, val)
 
+#define read_c0_badinstr()	__read_32bit_c0_register($8, 1)
+#define write_c0_badinstr(val)	__write_32bit_c0_register($8, 1, val)
+
+#define read_c0_badinstrp()	__read_32bit_c0_register($8, 2)
+#define write_c0_badinstrp(val)	__write_32bit_c0_register($8, 2, val)
+
 #define read_c0_count()		__read_32bit_c0_register($9, 0)
 #define write_c0_count(val)	__write_32bit_c0_register($9, 0, val)
 
@@ -1162,6 +1313,93 @@ do {									\
 #define read_c0_brcm_sleepcount()	__read_32bit_c0_register($22, 7)
 #define write_c0_brcm_sleepcount(val)	__write_32bit_c0_register($22, 7, val)
 
+/* MIPS VZ */
+#define read_c0_guestctl0()		__read_32bit_c0_register($12, 6)
+#define write_c0_guestctl0(val)		__write_32bit_c0_register($12, 6, val)
+
+#define read_c0_guestctl1()		__read_32bit_c0_register($10, 4)
+#define write_c0_guestctl1(val)		__write_32bit_c0_register($10, 4, val)
+
+#define read_c0_guestctl2()		__read_32bit_c0_register($10, 5)
+#define write_c0_guestctl2(val)		__write_32bit_c0_register($10, 5, val)
+
+#define read_c0_guestctl3()		__read_32bit_c0_register($10, 6)
+#define write_c0_guestctl3(val)		__write_32bit_c0_register($10, 6, val)
+
+#define read_c0_gtoffset()		__read_32bit_c0_register($12, 7)
+#define write_c0_gtoffset(val)		__write_32bit_c0_register($12, 7, val)
+
+#define read_gc0_index()		__read_32bit_gc0_register($0, 0)
+#define write_gc0_index(val)		__write_32bit_gc0_register($0, 0, val)
+
+#define read_gc0_entrylo0()		__read_64bit_gc0_register($2, 0)
+#define write_gc0_entrylo0(val)		__write_64bit_gc0_register($2, 0, val)
+
+#define read_gc0_entrylo1()		__read_64bit_gc0_register($3, 0)
+#define write_gc0_entrylo1(val)		__write_64bit_gc0_register($3, 0, val)
+
+#define read_gc0_context()		__read_64bit_gc0_register($4, 0)
+#define write_gc0_context(val)		__write_64bit_gc0_register($4, 0, val)
+
+#define read_gc0_userlocal()		__read_64bit_gc0_register($4, 2)
+#define write_gc0_userlocal(val)	__write_64bit_gc0_register($4, 2, val)
+
+#define read_gc0_pagemask()		__read_32bit_gc0_register($5, 0)
+#define write_gc0_pagemask(val)		__write_32bit_gc0_register($5, 0, val)
+
+#define read_gc0_pagegrain()		__read_32bit_gc0_register($5, 1)
+#define write_gc0_pagegrain(val)	__write_32bit_gc0_register($5, 1, val)
+
+#define read_gc0_wired()		__read_32bit_gc0_register($6, 0)
+#define write_gc0_wired(val)		__write_32bit_gc0_register($6, 0, val)
+
+#define read_gc0_hwrena()		__read_32bit_gc0_register($7, 0)
+#define write_gc0_hwrena(val)		__write_32bit_gc0_register($7, 0, val)
+
+#define read_gc0_badvaddr()		__read_64bit_gc0_register($8, 0)
+#define write_gc0_badvaddr(val)		__write_64bit_gc0_register($8, 0, val)
+
+#define read_gc0_count()		__read_32bit_gc0_register($9, 0)
+/* Not possible to write gc0_count. */
+
+#define read_gc0_entryhi()		__read_64bit_gc0_register($10, 0)
+#define write_gc0_entryhi(val)		__write_64bit_gc0_register($10, 0, val)
+
+#define read_gc0_compare()		__read_32bit_gc0_register($11, 0)
+#define write_gc0_compare(val)		__write_32bit_gc0_register($11, 0, val)
+
+#define read_gc0_status()		__read_32bit_gc0_register($12, 0)
+#define write_gc0_status(val)		__write_32bit_gc0_register($12, 0, val)
+
+#define read_gc0_cause()		__read_32bit_gc0_register($13, 0)
+#define write_gc0_cause(val)		__write_32bit_gc0_register($13, 0, val)
+
+#define read_gc0_ebase()		__read_64bit_gc0_register($15, 1)
+#define write_gc0_ebase(val)		__write_64bit_gc0_register($15, 1, val)
+
+#define read_gc0_config()		__read_32bit_gc0_register($16, 0)
+#define read_gc0_config1()		__read_32bit_gc0_register($16, 1)
+#define read_gc0_config2()		__read_32bit_gc0_register($16, 2)
+#define read_gc0_config3()		__read_32bit_gc0_register($16, 3)
+#define read_gc0_config4()		__read_32bit_gc0_register($16, 4)
+#define read_gc0_config5()		__read_32bit_gc0_register($16, 5)
+#define read_gc0_config6()		__read_32bit_gc0_register($16, 6)
+#define read_gc0_config7()		__read_32bit_gc0_register($16, 7)
+#define write_gc0_config(val)		__write_32bit_gc0_register($16, 0, val)
+#define write_gc0_config1(val)		__write_32bit_gc0_register($16, 1, val)
+#define write_gc0_config2(val)		__write_32bit_gc0_register($16, 2, val)
+#define write_gc0_config3(val)		__write_32bit_gc0_register($16, 3, val)
+#define write_gc0_config4(val)		__write_32bit_gc0_register($16, 4, val)
+#define write_gc0_config5(val)		__write_32bit_gc0_register($16, 5, val)
+#define write_gc0_config6(val)		__write_32bit_gc0_register($16, 6, val)
+#define write_gc0_config7(val)		__write_32bit_gc0_register($16, 7, val)
+
+#define read_gc0_xcontext()		__read_64bit_gc0_register($20, 0)
+#define write_gc0_xcontext(val)		__write_64bit_gc0_register($20, 0, val)
+
+#define read_gc0_kscratch(idx)		__read_64bit_gc0_register($31, (idx))
+#define write_gc0_kscratch(idx, val)	__write_64bit_gc0_register($31, (idx), val)
+
 /*
  * Macros to access the floating point coprocessor control registers
  */
@@ -1633,6 +1871,28 @@ static inline void tlb_write_random(void)
 		".set reorder");
 }
 
+static inline void guest_tlb_write_indexed(void)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set mips64r2\n\t"
+		".set virt\n\t"
+		".set noreorder\n\t"
+		"tlbgwi\n\t"
+		".set pop");
+}
+
+static inline void guest_tlb_read(void)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set mips64r2\n\t"
+		".set virt\n\t"
+		".set noreorder\n\t"
+		"tlbgr\n\t"
+		".set pop");
+}
+
 /*
  * Manipulate bits in a c0 register.
  */
-- 
1.7.11.7
