Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 09:06:20 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:59466 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133653AbWBAI60 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 08:58:26 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id 71C6B31C20A; Wed,  1 Feb 2006 18:03:26 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Wed, 01 Feb 2006 09:03:26 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id A01254201E1; Wed,  1 Feb 2006 18:03:25 +0900 (JST)
Message-Id: <20060201090325.497639000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date:	Wed, 01 Feb 2006 18:02:36 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
	dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
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
Subject: [patch 12/44] generic sched_find_first_bit()
Content-Disposition: inline; filename=sched-bitops.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

This patch introduces the C-language equivalent of the function:
int sched_find_first_bit(const unsigned long *b);

In include/asm-generic/bitops/sched.h

This code largely copied from:
include/asm-powerpc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/sched.h |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/sched.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/sched.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_GENERIC_BITOPS_SCHED_H_
+#define _ASM_GENERIC_BITOPS_SCHED_H_
+
+#include <linux/compiler.h>	/* unlikely() */
+#include <asm/types.h>
+
+/*
+ * Every architecture must define this function. It's the fastest
+ * way of searching a 140-bit bitmap where the first 100 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 140
+ * bits is cleared.
+ */
+static inline int sched_find_first_bit(const unsigned long *b)
+{
+#if BITS_PER_LONG == 64
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 64;
+	return __ffs(b[2]) + 128;
+#elif BITS_PER_LONG == 32
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 32;
+	if (unlikely(b[2]))
+		return __ffs(b[2]) + 64;
+	if (b[3])
+		return __ffs(b[3]) + 96;
+	return __ffs(b[4]) + 128;
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+#endif /* _ASM_GENERIC_BITOPS_SCHED_H_ */

--
