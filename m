Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 05:04:25 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:16335 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133476AbWBNE6q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 04:58:46 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id D8EB331C32D; Tue, 14 Feb 2006 14:04:46 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Tue, 14 Feb 2006 05:04:46 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 324E3420239; Tue, 14 Feb 2006 14:04:44 +0900 (JST)
Message-Id: <20060214050444.051147000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date:	Tue, 14 Feb 2006 14:04:03 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	akpm@osdl.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Chris Zankel <chris@zankel.net>,
	Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 12/47] generic find_{next,first}{,_zero}_bit()
Content-Disposition: inline; filename=find-bitops.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

This patch introduces the C-language equivalents of the functions below:

unsigned logn find_next_bit(const unsigned long *addr, unsigned long size,
                            unsigned long offset);
unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
                                 unsigned long offset);
unsigned long find_first_zero_bit(const unsigned long *addr,
                                  unsigned long size);
unsigned long find_first_bit(const unsigned long *addr, unsigned long size);

In include/asm-generic/bitops/find.h

This code largely copied from:
arch/powerpc/lib/bitops.c

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/find.h |   13 ++++
 lib/find_next_bit.c               |  114 +++++++++++++++++++++++++++-----------
 2 files changed, 95 insertions(+), 32 deletions(-)

Index: 2.6-rc/include/asm-generic/bitops/find.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/find.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_GENERIC_BITOPS_FIND_H_
+#define _ASM_GENERIC_BITOPS_FIND_H_
+
+extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
+		size, unsigned long offset);
+
+extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
+		long size, unsigned long offset);
+
+#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
+#define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
+
+#endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
Index: 2.6-rc/lib/find_next_bit.c
===================================================================
--- 2.6-rc.orig/lib/find_next_bit.c
+++ 2.6-rc/lib/find_next_bit.c
@@ -11,48 +11,98 @@
 
 #include <linux/bitops.h>
 #include <linux/module.h>
+#include <asm/types.h>
 
-int find_next_bit(const unsigned long *addr, int size, int offset)
+#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
+
+/**
+ * find_next_bit - find the next set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+		unsigned long offset)
 {
-	const unsigned long *base;
-	const int NBITS = sizeof(*addr) * 8;
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG-1);
 	unsigned long tmp;
 
-	base = addr;
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset %= BITS_PER_LONG;
 	if (offset) {
-		int suboffset;
-
-		addr += offset / NBITS;
-
-		suboffset = offset % NBITS;
-		if (suboffset) {
-			tmp = *addr;
-			tmp >>= suboffset;
-			if (tmp)
-				goto finish;
-		}
-
-		addr++;
+		tmp = *(p++);
+		tmp &= (~0UL << offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
 	}
+	while (size & ~(BITS_PER_LONG-1)) {
+		if ((tmp = *(p++)))
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp &= (~0UL >> (BITS_PER_LONG - size));
+	if (tmp == 0UL)		/* Are any bits set? */
+		return result + size;	/* Nope. */
+found_middle:
+	return result + __ffs(tmp);
+}
 
-	while ((tmp = *addr) == 0)
-		addr++;
+EXPORT_SYMBOL(find_next_bit);
 
-	offset = (addr - base) * NBITS;
+/*
+ * This implementation of find_{first,next}_zero_bit was stolen from
+ * Linus' asm-alpha/bitops.h.
+ */
+unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
+		unsigned long offset)
+{
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG-1);
+	unsigned long tmp;
 
- finish:
-	/* count the remaining bits without using __ffs() since that takes a 32-bit arg */
-	while (!(tmp & 0xff)) {
-		offset += 8;
-		tmp >>= 8;
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset %= BITS_PER_LONG;
+	if (offset) {
+		tmp = *(p++);
+		tmp |= ~0UL >> (BITS_PER_LONG - offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (~tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
 	}
-
-	while (!(tmp & 1)) {
-		offset++;
-		tmp >>= 1;
+	while (size & ~(BITS_PER_LONG-1)) {
+		if (~(tmp = *(p++)))
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
 	}
-
-	return offset;
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp |= ~0UL << size;
+	if (tmp == ~0UL)	/* Are any bits zero? */
+		return result + size;	/* Nope. */
+found_middle:
+	return result + ffz(tmp);
 }
 
-EXPORT_SYMBOL(find_next_bit);
+EXPORT_SYMBOL(find_next_zero_bit);

--
