Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:30:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8874 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993959AbdFJA3LK0Hft (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:29:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 474BD4C25AB21;
        Sat, 10 Jun 2017 01:29:03 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:29:04
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 07/11] MIPS: cmpxchg: Implement 1 byte & 2 byte xchg()
Date:   Fri, 9 Jun 2017 17:26:39 -0700
Message-ID: <20170610002644.8434-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170610002644.8434-1-paul.burton@imgtec.com>
References: <20170610002644.8434-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Implement 1 & 2 byte xchg() using read-modify-write atop a 4 byte
cmpxchg(). This allows us to support these atomic operations despite the
MIPS ISA only providing for 4 & 8 byte atomic operations.

This is required in order to support queued spinlocks (qspinlock) in a
later patch, since these make use of a 2 byte xchg() in their slow path.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cmpxchg.h |  9 +++++--
 arch/mips/kernel/Makefile       |  2 +-
 arch/mips/kernel/cmpxchg.c      | 52 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/kernel/cmpxchg.c

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 516cb66f066b..a633bf845689 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -70,9 +70,16 @@ extern unsigned long __xchg_called_with_bad_pointer(void)
 	__ret;								\
 })
 
+extern unsigned long __xchg_small(volatile void *ptr, unsigned long val,
+				  unsigned int size);
+
 static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
 {
 	switch (size) {
+	case 1:
+	case 2:
+		return __xchg_small(ptr, x, size);
+
 	case 4:
 		return __xchg_asm("ll", "sc", (volatile u32 *)ptr, x);
 
@@ -91,8 +98,6 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 ({									\
 	__typeof__(*(ptr)) __res;					\
 									\
-	BUILD_BUG_ON(sizeof(*(ptr)) & ~0xc);				\
-									\
 	smp_mb__before_llsc();						\
 									\
 	__res = (__typeof__(*(ptr)))					\
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 9a0e37b92ce0..e06c6f7d774c 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -4,7 +4,7 @@
 
 extra-y		:= head.o vmlinux.lds
 
-obj-y		+= cpu-probe.o branch.o elf.o entry.o genex.o idle.o irq.o \
+obj-y		+= cmpxchg.o cpu-probe.o branch.o elf.o entry.o genex.o idle.o irq.o \
 		   process.o prom.o ptrace.o reset.o setup.o signal.o \
 		   syscall.o time.o topology.o traps.o unaligned.o watch.o \
 		   vdso.o cacheinfo.o
diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
new file mode 100644
index 000000000000..5acfbf9fb2c5
--- /dev/null
+++ b/arch/mips/kernel/cmpxchg.c
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/bitops.h>
+#include <asm/cmpxchg.h>
+
+unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
+{
+	u32 old32, new32, load32, mask;
+	volatile u32 *ptr32;
+	unsigned int shift;
+
+	/* Check that ptr is naturally aligned */
+	WARN_ON((unsigned long)ptr & (size - 1));
+
+	/* Mask value to the correct size. */
+	mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
+	val &= mask;
+
+	/*
+	 * Calculate a shift & mask that correspond to the value we wish to
+	 * exchange within the naturally aligned 4 byte integerthat includes
+	 * it.
+	 */
+	shift = (unsigned long)ptr & 0x3;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		shift ^= sizeof(u32) - size;
+	shift *= BITS_PER_BYTE;
+	mask <<= shift;
+
+	/*
+	 * Calculate a pointer to the naturally aligned 4 byte integer that
+	 * includes our byte of interest, and load its value.
+	 */
+	ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
+	load32 = *ptr32;
+
+	do {
+		old32 = load32;
+		new32 = (load32 & ~mask) | (val << shift);
+		load32 = cmpxchg(ptr32, old32, new32);
+	} while (load32 != old32);
+
+	return (load32 & mask) >> shift;
+}
-- 
2.13.1
