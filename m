Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 15:27:28 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:47854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009973AbcAJOVBUkFs8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2016 15:21:01 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id B0EE37AE86;
        Sun, 10 Jan 2016 14:20:59 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0AEKoZH019373;
        Sun, 10 Jan 2016 09:20:51 -0500
Date:   Sun, 10 Jan 2016 16:20:50 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Rich Felker <dalias@libc.org>
Subject: [PATCH v3 31/41] sh: support 1 and 2 byte xchg
Message-ID: <1452426622-4471-32-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

This completes the xchg implementation for sh architecture.  Note: The
llsc variant is tricky since this only supports 4 byte atomics, the
existing implementation of 1 byte xchg is wrong: we need to do a 4 byte
cmpxchg and retry if any bytes changed meanwhile.

Write this in C for clarity.

Suggested-by: Rich Felker <dalias@libc.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sh/include/asm/cmpxchg-grb.h  | 22 +++++++++++++++
 arch/sh/include/asm/cmpxchg-irq.h  | 11 ++++++++
 arch/sh/include/asm/cmpxchg-llsc.h | 58 +++++++++++++++++++++++---------------
 arch/sh/include/asm/cmpxchg.h      |  3 ++
 4 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/arch/sh/include/asm/cmpxchg-grb.h b/arch/sh/include/asm/cmpxchg-grb.h
index f848dec..2ed557b 100644
--- a/arch/sh/include/asm/cmpxchg-grb.h
+++ b/arch/sh/include/asm/cmpxchg-grb.h
@@ -23,6 +23,28 @@ static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 	return retval;
 }
 
+static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
+{
+	unsigned long retval;
+
+	__asm__ __volatile__ (
+		"   .align  2             \n\t"
+		"   mova    1f,   r0      \n\t" /* r0 = end point */
+		"   mov    r15,   r1      \n\t" /* r1 = saved sp */
+		"   mov    #-6,   r15     \n\t" /* LOGIN */
+		"   mov.w  @%1,   %0      \n\t" /* load  old value */
+		"   extu.w  %0,   %0      \n\t" /* extend as unsigned */
+		"   mov.w   %2,   @%1     \n\t" /* store new value */
+		"1: mov     r1,   r15     \n\t" /* LOGOUT */
+		: "=&r" (retval),
+		  "+r"  (m),
+		  "+r"  (val)		/* inhibit r15 overloading */
+		:
+		: "memory" , "r0", "r1");
+
+	return retval;
+}
+
 static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
 {
 	unsigned long retval;
diff --git a/arch/sh/include/asm/cmpxchg-irq.h b/arch/sh/include/asm/cmpxchg-irq.h
index bd11f63..f888772 100644
--- a/arch/sh/include/asm/cmpxchg-irq.h
+++ b/arch/sh/include/asm/cmpxchg-irq.h
@@ -14,6 +14,17 @@ static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 	return retval;
 }
 
+static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
+{
+	unsigned long flags, retval;
+
+	local_irq_save(flags);
+	retval = *m;
+	*m = val;
+	local_irq_restore(flags);
+	return retval;
+}
+
 static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
 {
 	unsigned long flags, retval;
diff --git a/arch/sh/include/asm/cmpxchg-llsc.h b/arch/sh/include/asm/cmpxchg-llsc.h
index 4713666..e754794 100644
--- a/arch/sh/include/asm/cmpxchg-llsc.h
+++ b/arch/sh/include/asm/cmpxchg-llsc.h
@@ -1,6 +1,9 @@
 #ifndef __ASM_SH_CMPXCHG_LLSC_H
 #define __ASM_SH_CMPXCHG_LLSC_H
 
+#include <linux/bitops.h>
+#include <asm/byteorder.h>
+
 static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 {
 	unsigned long retval;
@@ -22,29 +25,8 @@ static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 	return retval;
 }
 
-static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
-{
-	unsigned long retval;
-	unsigned long tmp;
-
-	__asm__ __volatile__ (
-		"1:					\n\t"
-		"movli.l	@%2, %0	! xchg_u8	\n\t"
-		"mov		%0, %1			\n\t"
-		"mov		%3, %0			\n\t"
-		"movco.l	%0, @%2			\n\t"
-		"bf		1b			\n\t"
-		"synco					\n\t"
-		: "=&z"(tmp), "=&r" (retval)
-		: "r" (m), "r" (val & 0xff)
-		: "t", "memory"
-	);
-
-	return retval;
-}
-
 static inline unsigned long
-__cmpxchg_u32(volatile int *m, unsigned long old, unsigned long new)
+__cmpxchg_u32(volatile u32 *m, unsigned long old, unsigned long new)
 {
 	unsigned long retval;
 	unsigned long tmp;
@@ -68,4 +50,36 @@ __cmpxchg_u32(volatile int *m, unsigned long old, unsigned long new)
 	return retval;
 }
 
+static inline u32 __xchg_cmpxchg(volatile void *ptr, u32 x, int size)
+{
+	int off = (unsigned long)ptr % sizeof(u32);
+	volatile u32 *p = ptr - off;
+#ifdef __BIG_ENDIAN
+	int bitoff = (sizeof(u32) - 1 - off) * BITS_PER_BYTE;
+#else
+	int bitoff = off * BITS_PER_BYTE;
+#endif
+	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;
+	u32 oldv, newv;
+	u32 ret;
+
+	do {
+		oldv = READ_ONCE(*p);
+		ret = (oldv & bitmask) >> bitoff;
+		newv = (oldv & ~bitmask) | (x << bitoff);
+	} while (__cmpxchg_u32(p, oldv, newv) != oldv);
+
+	return ret;
+}
+
+static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
+{
+	return __xchg_cmpxchg(m, val, sizeof *m);
+}
+
+static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
+{
+	return __xchg_cmpxchg(m, val, sizeof *m);
+}
+
 #endif /* __ASM_SH_CMPXCHG_LLSC_H */
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 85c97b18..5225916 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -27,6 +27,9 @@ extern void __xchg_called_with_bad_pointer(void);
 	case 4:						\
 		__xchg__res = xchg_u32(__xchg_ptr, x);	\
 		break;					\
+	case 2:						\
+		__xchg__res = xchg_u16(__xchg_ptr, x);	\
+		break;					\
 	case 1:						\
 		__xchg__res = xchg_u8(__xchg_ptr, x);	\
 		break;					\
-- 
MST
