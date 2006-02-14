Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 05:08:33 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:63439 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S3458553AbWBNE6x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 04:58:53 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id B288F31C351; Tue, 14 Feb 2006 14:04:53 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Tue, 14 Feb 2006 05:04:51 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 5AF07420235; Tue, 14 Feb 2006 14:04:45 +0900 (JST)
Message-Id: <20060214050445.212426000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date:	Tue, 14 Feb 2006 14:04:09 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	akpm@osdl.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
	linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>,
	Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 18/47] generic minix_{test,set,test_and_clear,test,find_first_zero}_bit()
Content-Disposition: inline; filename=minix-bitops.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

This patch introduces the C-language equivalents of the functions below:

int minix_test_and_set_bit(int nr, volatile unsigned long *addr);
int minix_set_bit(int nr, volatile unsigned long *addr);
int minix_test_and_clear_bit(int nr, volatile unsigned long *addr);
int minix_test_bit(int nr, const volatile unsigned long *addr);
unsigned long minix_find_first_zero_bit(const unsigned long *addr,
                                        unsigned long size);

In include/asm-generic/bitops/minix.h
   and include/asm-generic/bitops/minix-le.h

This code largely copied from:
include/asm-sparc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/asm-generic/bitops/minix-le.h |   17 +++++++++++++++++
 include/asm-generic/bitops/minix.h    |   15 +++++++++++++++
 2 files changed, 32 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/minix.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/minix.h
@@ -0,0 +1,15 @@
+#ifndef _ASM_GENERIC_BITOPS_MINIX_H_
+#define _ASM_GENERIC_BITOPS_MINIX_H_
+
+#define minix_test_and_set_bit(nr,addr)	\
+	__test_and_set_bit((nr),(unsigned long *)(addr))
+#define minix_set_bit(nr,addr)		\
+	__set_bit((nr),(unsigned long *)(addr))
+#define minix_test_and_clear_bit(nr,addr) \
+	__test_and_clear_bit((nr),(unsigned long *)(addr))
+#define minix_test_bit(nr,addr)		\
+	test_bit((nr),(unsigned long *)(addr))
+#define minix_find_first_zero_bit(addr,size) \
+	find_first_zero_bit((unsigned long *)(addr),(size))
+
+#endif /* _ASM_GENERIC_BITOPS_MINIX_H_ */
Index: 2.6-rc/include/asm-generic/bitops/minix-le.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/minix-le.h
@@ -0,0 +1,17 @@
+#ifndef _ASM_GENERIC_BITOPS_MINIX_LE_H_
+#define _ASM_GENERIC_BITOPS_MINIX_LE_H_
+
+#include <asm-generic/bitops/le.h>
+
+#define minix_test_and_set_bit(nr,addr)	\
+	generic___test_and_set_le_bit((nr),(unsigned long *)(addr))
+#define minix_set_bit(nr,addr)		\
+	generic___set_le_bit((nr),(unsigned long *)(addr))
+#define minix_test_and_clear_bit(nr,addr) \
+	generic___test_and_clear_le_bit((nr),(unsigned long *)(addr))
+#define minix_test_bit(nr,addr)		\
+	generic_test_le_bit((nr),(unsigned long *)(addr))
+#define minix_find_first_zero_bit(addr,size) \
+	generic_find_first_zero_le_bit((unsigned long *)(addr),(size))
+
+#endif /* _ASM_GENERIC_BITOPS_MINIX_LE_H_ */

--
