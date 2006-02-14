Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 05:01:09 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:46542 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133438AbWBNE6g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 04:58:36 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id 7059D31C336; Tue, 14 Feb 2006 14:04:46 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Tue, 14 Feb 2006 05:04:46 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 8AC3D42023B; Tue, 14 Feb 2006 14:04:44 +0900 (JST)
Message-Id: <20060214050444.425684000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date:	Tue, 14 Feb 2006 14:04:05 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	akpm@osdl.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	ultralinux@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 14/47] generic ffs()
Content-Disposition: inline; filename=ffs-bitops.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

This patch introduces the C-language equivalent of the function:
int ffs(int x);

In include/asm-generic/bitops/ffs.h

This code largely copied from:
include/linux/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/ffs.h |   41 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/ffs.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/ffs.h
@@ -0,0 +1,41 @@
+#ifndef _ASM_GENERIC_BITOPS_FFS_H_
+#define _ASM_GENERIC_BITOPS_FFS_H_
+
+/**
+ * ffs - find first bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as
+ * the libc and compiler builtin ffs routines, therefore
+ * differs in spirit from the above ffz (man ffs).
+ */
+static inline int ffs(int x)
+{
+	int r = 1;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+
+#endif /* _ASM_GENERIC_BITOPS_FFS_H_ */

--
