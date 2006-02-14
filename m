Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 05:02:02 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:39374 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133459AbWBNE6h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 04:58:37 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id EEBCE31C332; Tue, 14 Feb 2006 14:04:45 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Tue, 14 Feb 2006 05:04:45 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 967CA420238; Tue, 14 Feb 2006 14:04:43 +0900 (JST)
Message-Id: <20060214050443.468528000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date:	Tue, 14 Feb 2006 14:04:00 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	akpm@osdl.org, Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>,
	David Howells <dhowells@redhat.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, sparclinux@vger.kernel.org,
	ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 09/47] generic ffz()
Content-Disposition: inline; filename=ffz-bitops.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

This patch introduces the C-language equivalent of the function:
unsigned long ffz(unsigned long word);

In include/asm-generic/bitops/ffz.h

This code largely copied from:
include/asm-parisc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/ffz.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/ffz.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/ffz.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_GENERIC_BITOPS_FFZ_H_
+#define _ASM_GENERIC_BITOPS_FFZ_H_
+
+/*
+ * ffz - find first zero in word.
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
+ */
+#define ffz(x)  __ffs(~(x))
+
+#endif /* _ASM_GENERIC_BITOPS_FFZ_H_ */

--
