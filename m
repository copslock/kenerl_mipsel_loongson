Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2012 23:53:46 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:3191 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903351Ab2ICVxY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Sep 2012 23:53:24 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 03 Sep 2012 14:51:20 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 3 Sep 2012 14:52:43 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id EC4E69F9F5; Mon, 3
 Sep 2012 14:52:42 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     ddaney.cavm@gmail.com, cernekee@gmail.com,
        "Jim Quinlan" <jim2101024@gmail.com>
Subject: [PATCH V3 1/2] MIPS: Remove irqflags.h dependency from bitops.h
Date:   Mon, 3 Sep 2012 17:52:16 -0400
Message-ID: <1346709137-3448-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
X-WSS-ID: 7C5BF9D23NK22813709-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

The "else clause" of most functions in bitops.h invoked
raw_local_irq_{save,restore}() and so had a dependency on irqflags.h.  This
fix moves said code to bitops.c, removing the dependency.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/include/asm/bitops.h |  114 +++++++------------------
 arch/mips/include/asm/io.h     |    1 +
 arch/mips/lib/Makefile         |    2 +-
 arch/mips/lib/bitops.c         |  180 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+), 83 deletions(-)
 create mode 100644 arch/mips/lib/bitops.c

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 82ad35c..9fd0b1d 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -14,7 +14,6 @@
 #endif
 
 #include <linux/compiler.h>
-#include <linux/irqflags.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <asm/byteorder.h>		/* sigh ... */
@@ -44,6 +43,24 @@
 #define smp_mb__before_clear_bit()	smp_mb__before_llsc()
 #define smp_mb__after_clear_bit()	smp_llsc_mb()
 
+
+/*
+ * These are the "slower" versions of the functions and are in bitops.c.
+ * These functions call raw_local_irq_{save,restore}().
+ */
+extern void atomic_set_bit(unsigned long nr, volatile unsigned long *addr);
+extern void atomic_clear_bit(unsigned long nr, volatile unsigned long *addr);
+extern void atomic_change_bit(unsigned long nr, volatile unsigned long *addr);
+extern int atomic_test_and_set_bit(unsigned long nr,
+				   volatile unsigned long *addr);
+extern int atomic_test_and_set_bit_lock(unsigned long nr,
+					volatile unsigned long *addr);
+extern int atomic_test_and_clear_bit(unsigned long nr,
+				     volatile unsigned long *addr);
+extern int atomic_test_and_change_bit(unsigned long nr,
+				      volatile unsigned long *addr);
+
+
 /*
  * set_bit - Atomically set a bit in memory
  * @nr: the bit to set
@@ -92,17 +109,8 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 			: "=&r" (temp), "+m" (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
-	} else {
-		volatile unsigned long *a = addr;
-		unsigned long mask;
-		unsigned long flags;
-
-		a += nr >> SZLONG_LOG;
-		mask = 1UL << bit;
-		raw_local_irq_save(flags);
-		*a |= mask;
-		raw_local_irq_restore(flags);
-	}
+	} else
+		atomic_set_bit(nr, addr);
 }
 
 /*
@@ -153,17 +161,8 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 			: "=&r" (temp), "+m" (*m)
 			: "ir" (~(1UL << bit)));
 		} while (unlikely(!temp));
-	} else {
-		volatile unsigned long *a = addr;
-		unsigned long mask;
-		unsigned long flags;
-
-		a += nr >> SZLONG_LOG;
-		mask = 1UL << bit;
-		raw_local_irq_save(flags);
-		*a &= ~mask;
-		raw_local_irq_restore(flags);
-	}
+	} else
+		atomic_clear_bit(nr, addr);
 }
 
 /*
@@ -220,17 +219,8 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 			: "=&r" (temp), "+m" (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
-	} else {
-		volatile unsigned long *a = addr;
-		unsigned long mask;
-		unsigned long flags;
-
-		a += nr >> SZLONG_LOG;
-		mask = 1UL << bit;
-		raw_local_irq_save(flags);
-		*a ^= mask;
-		raw_local_irq_restore(flags);
-	}
+	} else
+		atomic_change_bit(nr, addr);
 }
 
 /*
@@ -281,18 +271,8 @@ static inline int test_and_set_bit(unsigned long nr,
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
-	} else {
-		volatile unsigned long *a = addr;
-		unsigned long mask;
-		unsigned long flags;
-
-		a += nr >> SZLONG_LOG;
-		mask = 1UL << bit;
-		raw_local_irq_save(flags);
-		res = (mask & *a);
-		*a |= mask;
-		raw_local_irq_restore(flags);
-	}
+	} else
+		res = atomic_test_and_set_bit(nr, addr);
 
 	smp_llsc_mb();
 
@@ -345,18 +325,8 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
-	} else {
-		volatile unsigned long *a = addr;
-		unsigned long mask;
-		unsigned long flags;
-
-		a += nr >> SZLONG_LOG;
-		mask = 1UL << bit;
-		raw_local_irq_save(flags);
-		res = (mask & *a);
-		*a |= mask;
-		raw_local_irq_restore(flags);
-	}
+	} else
+		res = atomic_test_and_set_bit_lock(nr, addr);
 
 	smp_llsc_mb();
 
@@ -428,18 +398,8 @@ static inline int test_and_clear_bit(unsigned long nr,
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
-	} else {
-		volatile unsigned long *a = addr;
-		unsigned long mask;
-		unsigned long flags;
-
-		a += nr >> SZLONG_LOG;
-		mask = 1UL << bit;
-		raw_local_irq_save(flags);
-		res = (mask & *a);
-		*a &= ~mask;
-		raw_local_irq_restore(flags);
-	}
+	} else
+		res = atomic_test_and_clear_bit(nr, addr);
 
 	smp_llsc_mb();
 
@@ -494,18 +454,8 @@ static inline int test_and_change_bit(unsigned long nr,
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
-	} else {
-		volatile unsigned long *a = addr;
-		unsigned long mask;
-		unsigned long flags;
-
-		a += nr >> SZLONG_LOG;
-		mask = 1UL << bit;
-		raw_local_irq_save(flags);
-		res = (mask & *a);
-		*a ^= mask;
-		raw_local_irq_restore(flags);
-	}
+	} else
+		res = atomic_test_and_change_bit(nr, addr);
 
 	smp_llsc_mb();
 
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 29d9c23..ff2e034 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/irqflags.h>
 
 #include <asm/addrspace.h>
 #include <asm/bug.h>
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index c4a82e8..a7b8937 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -2,7 +2,7 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial.o delay.o memcpy.o memset.o \
+lib-y	+= bitops.o csum_partial.o delay.o memcpy.o memset.o \
 	   strlen_user.o strncpy_user.o strnlen_user.o uncached.o
 
 obj-y			+= iomap.o
diff --git a/arch/mips/lib/bitops.c b/arch/mips/lib/bitops.c
new file mode 100644
index 0000000..6562ab2
--- /dev/null
+++ b/arch/mips/lib/bitops.c
@@ -0,0 +1,180 @@
+
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 1994-1997, 99, 2000, 06, 07 Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (c) 1999, 2000  Silicon Graphics, Inc.
+ */
+
+#include <linux/irqflags.h>
+
+#if _MIPS_SZLONG == 32
+#define SZLONG_LOG 5
+#define SZLONG_MASK 31UL
+#elif _MIPS_SZLONG == 64
+#define SZLONG_MASK 63UL
+#define SZLONG_LOG 6
+#endif
+
+
+/*
+ * atomic_set_bit - Atomically set a bit in memory.  This is called by
+ * if set_bit() if it cannot find a faster solution.
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ */
+void atomic_set_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	volatile unsigned long *a = addr;
+	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long mask;
+	unsigned long flags;
+
+	a += nr >> SZLONG_LOG;
+	mask = 1UL << bit;
+	raw_local_irq_save(flags);
+	*a |= mask;
+	raw_local_irq_restore(flags);
+}
+
+
+/*
+ * atomic_clear_bit - Clears a bit in memory.  This is called by clear_bit() if
+ * it cannot find a faster solution.
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+void atomic_clear_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	volatile unsigned long *a = addr;
+	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long mask;
+	unsigned long flags;
+
+	a += nr >> SZLONG_LOG;
+	mask = 1UL << bit;
+	raw_local_irq_save(flags);
+	*a &= ~mask;
+	raw_local_irq_restore(flags);
+}
+
+
+/*
+ * atomic_change_bit - Toggle a bit in memory.  This is called by change_bit()
+ * if it cannot find a faster solution.
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ */
+void atomic_change_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	volatile unsigned long *a = addr;
+	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long mask;
+	unsigned long flags;
+
+	a += nr >> SZLONG_LOG;
+	mask = 1UL << bit;
+	raw_local_irq_save(flags);
+	*a ^= mask;
+	raw_local_irq_restore(flags);
+}
+
+
+/*
+ * atomic_test_and_set_bit - Set a bit and return its old value.  This is
+ * called by test_and_set_bit() if it cannot find a faster solution.
+ * @nr: Bit to set
+ * @addr: Address to count from
+ */
+int atomic_test_and_set_bit(unsigned long nr,
+			    volatile unsigned long *addr)
+{
+	volatile unsigned long *a = addr;
+	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long mask;
+	unsigned long flags;
+	unsigned long res;
+
+	a += nr >> SZLONG_LOG;
+	mask = 1UL << bit;
+	raw_local_irq_save(flags);
+	res = (mask & *a);
+	*a |= mask;
+	raw_local_irq_restore(flags);
+	return res;
+}
+
+
+/*
+ * atomic_test_and_set_bit_lock - Set a bit and return its old value.  This is
+ * called by test_and_set_bit_lock() if it cannot find a faster solution.
+ * @nr: Bit to set
+ * @addr: Address to count from
+ */
+int atomic_test_and_set_bit_lock(unsigned long nr,
+				 volatile unsigned long *addr)
+{
+	volatile unsigned long *a = addr;
+	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long mask;
+	unsigned long flags;
+	unsigned long res;
+
+	a += nr >> SZLONG_LOG;
+	mask = 1UL << bit;
+	raw_local_irq_save(flags);
+	res = (mask & *a);
+	*a |= mask;
+	raw_local_irq_restore(flags);
+	return res;
+}
+
+
+/*
+ * atomic_test_and_clear_bit - Clear a bit and return its old value.  This is
+ * called by test_and_clear_bit() if it cannot find a faster solution.
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ */
+int atomic_test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	volatile unsigned long *a = addr;
+	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long mask;
+	unsigned long flags;
+	unsigned long res;
+
+	a += nr >> SZLONG_LOG;
+	mask = 1UL << bit;
+	raw_local_irq_save(flags);
+	res = (mask & *a);
+	*a &= ~mask;
+	raw_local_irq_restore(flags);
+	return res;
+}
+
+
+/*
+ * atomic_test_and_change_bit - Change a bit and return its old value.  This is
+ * called by test_and_change_bit() if it cannot find a faster solution.
+ * @nr: Bit to change
+ * @addr: Address to count from
+ */
+int atomic_test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	volatile unsigned long *a = addr;
+	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long mask;
+	unsigned long flags;
+	unsigned long res;
+
+	a += nr >> SZLONG_LOG;
+	mask = 1UL << bit;
+	raw_local_irq_save(flags);
+	res = (mask & *a);
+	*a ^= mask;
+	raw_local_irq_restore(flags);
+	return res;
+}
-- 
1.7.6
