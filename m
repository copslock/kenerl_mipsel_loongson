Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:30:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1549 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993969AbdFJA327hPgt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:29:28 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2CB5B7EE94A09;
        Sat, 10 Jun 2017 01:29:21 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:29:22
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/11] MIPS: cmpxchg: Implement 1 byte & 2 byte cmpxchg()
Date:   Fri, 9 Jun 2017 17:26:40 -0700
Message-ID: <20170610002644.8434-9-paul.burton@imgtec.com>
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
X-archive-position: 58397
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

Implement support for 1 & 2 byte cmpxchg() using read-modify-write atop
a 4 byte cmpxchg(). This allows us to support these atomic operations
despite the MIPS ISA only providing 4 & 8 byte atomic operations.

This is required in order to support queued rwlocks (qrwlock) in a later
patch, since these make use of a 1 byte cmpxchg() in their slow path.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cmpxchg.h |  7 +++++
 arch/mips/kernel/cmpxchg.c      | 57 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index a633bf845689..a633f61c5545 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -142,10 +142,17 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 	__ret;								\
 })
 
+extern unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
+				     unsigned long new, unsigned int size);
+
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, unsigned int size)
 {
 	switch (size) {
+	case 1:
+	case 2:
+		return __cmpxchg_small(ptr, old, new, size);
+
 	case 4:
 		return __cmpxchg_asm("ll", "sc", (volatile u32 *)ptr, old, new);
 
diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
index 5acfbf9fb2c5..7730f1d3434f 100644
--- a/arch/mips/kernel/cmpxchg.c
+++ b/arch/mips/kernel/cmpxchg.c
@@ -50,3 +50,60 @@ unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int s
 
 	return (load32 & mask) >> shift;
 }
+
+unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
+			      unsigned long new, unsigned int size)
+{
+	u32 mask, old32, new32, load32;
+	volatile u32 *ptr32;
+	unsigned int shift;
+	u8 load;
+
+	/* Check that ptr is naturally aligned */
+	WARN_ON((unsigned long)ptr & (size - 1));
+
+	/* Mask inputs to the correct size. */
+	mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
+	old &= mask;
+	new &= mask;
+
+	/*
+	 * Calculate a shift & mask that correspond to the value we wish to
+	 * compare & exchange within the naturally aligned 4 byte integer
+	 * that includes it.
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
+	while (true) {
+		/*
+		 * Ensure the byte we want to exchange matches the expected
+		 * old value, and if not then bail.
+		 */
+		load = (load32 & mask) >> shift;
+		if (load != old)
+			return load;
+
+		/*
+		 * Calculate the old & new values of the naturally aligned
+		 * 4 byte integer that include the byte we want to exchange.
+		 * Attempt to exchange the old value for the new value, and
+		 * return if we succeed.
+		 */
+		old32 = (load32 & ~mask) | (old << shift);
+		new32 = (load32 & ~mask) | (new << shift);
+		load32 = cmpxchg(ptr32, old32, new32);
+		if (load32 == old32)
+			return old;
+	}
+}
-- 
2.13.1
