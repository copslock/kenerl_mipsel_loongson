Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 08:58:42 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:2634 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133645AbWBAI6X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 08:58:23 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id 8B29F31C205; Wed,  1 Feb 2006 18:03:23 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Wed, 01 Feb 2006 09:03:23 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 011884201E0; Wed,  1 Feb 2006 18:03:22 +0900 (JST)
Message-Id: <20060201090322.900876000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date:	Wed, 01 Feb 2006 18:02:32 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
	David Howells <dhowells@redhat.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, sparclinux@vger.kernel.org,
	ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 08/44] generic ffz()
Content-Disposition: inline; filename=ffz-bitops.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10264
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

Index: 2.6-git/include/asm-generic/bitops/ffz.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/ffz.h
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
