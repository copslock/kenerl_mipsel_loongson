Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 08:59:42 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:9290 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133644AbWBAI6X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 08:58:23 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id 6E41131C209; Wed,  1 Feb 2006 18:03:24 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Wed, 01 Feb 2006 09:03:24 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 354824201E3; Wed,  1 Feb 2006 18:03:23 +0900 (JST)
Message-Id: <20060201090323.100733000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date:	Wed, 01 Feb 2006 18:02:33 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
	linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 09/44] generic fls()
Content-Disposition: inline; filename=fls-bitops.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

This patch introduces the C-language equivalent of the function:
int fls(int x);

In include/asm-generic/bitops/fls.h

This code largely copied from:
include/linux/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/fls.h |   41 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/fls.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/fls.h
@@ -0,0 +1,41 @@
+#ifndef _ASM_GENERIC_BITOPS_FLS_H_
+#define _ASM_GENERIC_BITOPS_FLS_H_
+
+/**
+ * fls - find last (most-significant) bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as ffs.
+ * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
+ */
+
+static __inline__ int fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+#endif /* _ASM_GENERIC_BITOPS_FLS_H_ */

--
