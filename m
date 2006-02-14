Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 05:03:32 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:24527 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133499AbWBNE6q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 04:58:46 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id D8E0131C33F; Tue, 14 Feb 2006 14:04:50 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Tue, 14 Feb 2006 05:04:47 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id B7D2042023C; Tue, 14 Feb 2006 14:04:44 +0900 (JST)
Message-Id: <20060214050444.599668000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date:	Tue, 14 Feb 2006 14:04:06 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	akpm@osdl.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>,
	Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 15/47] generic hweight{64,32,16,8}()
Content-Disposition: inline; filename=hweight-bitops.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips


This patch introduces the C-language equivalents of the functions below:

unsigned int hweight32(unsigned int w);
unsigned int hweight16(unsigned int w);
unsigned int hweight8(unsigned int w);
unsigned long hweight64(__u64 w);

In include/asm-generic/bitops/hweight.h

This code largely copied from:
include/linux/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/hweight.h |    9 +++++
 lib/Makefile                         |    1 
 lib/hweight.c                        |   54 +++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/hweight.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/hweight.h
@@ -0,0 +1,9 @@
+#ifndef _ASM_GENERIC_BITOPS_HWEIGHT_H_
+#define _ASM_GENERIC_BITOPS_HWEIGHT_H_
+
+extern unsigned int hweight32(unsigned int w);
+extern unsigned int hweight16(unsigned int w);
+extern unsigned int hweight8(unsigned int w);
+extern unsigned long hweight64(__u64 w);
+
+#endif /* _ASM_GENERIC_BITOPS_HWEIGHT_H_ */
Index: 2.6-rc/lib/Makefile
===================================================================
--- 2.6-rc.orig/lib/Makefile
+++ 2.6-rc/lib/Makefile
@@ -21,6 +21,7 @@ lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += 
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
+lib-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 
Index: 2.6-rc/lib/hweight.c
===================================================================
--- /dev/null
+++ 2.6-rc/lib/hweight.c
@@ -0,0 +1,54 @@
+#include <linux/module.h>
+#include <asm/types.h>
+
+/**
+ * hweightN - returns the hamming weight of a N-bit word
+ * @x: the word to weigh
+ *
+ * The Hamming Weight of a number is the total number of bits set in it.
+ */
+
+unsigned int hweight32(unsigned int w)
+{
+	unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
+	res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
+	res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
+	res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
+	return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
+}
+EXPORT_SYMBOL(hweight32);
+
+unsigned int hweight16(unsigned int w)
+{
+	unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
+	res = (res & 0x3333) + ((res >> 2) & 0x3333);
+	res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
+	return (res & 0x00FF) + ((res >> 8) & 0x00FF);
+}
+EXPORT_SYMBOL(hweight16);
+
+unsigned int hweight8(unsigned int w)
+{
+	unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
+	res = (res & 0x33) + ((res >> 2) & 0x33);
+	return (res & 0x0F) + ((res >> 4) & 0x0F);
+}
+EXPORT_SYMBOL(hweight8);
+
+unsigned long hweight64(__u64 w)
+{
+#if BITS_PER_LONG == 32
+	return hweight32((unsigned int)(w >> 32)) + hweight32((unsigned int)w);
+#elif BITS_PER_LONG == 64
+	u64 res;
+	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
+	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
+	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
+	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
+	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
+	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+EXPORT_SYMBOL(hweight64);

--
