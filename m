Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 09:07:25 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:61002 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133658AbWBAI60 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 08:58:26 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id F2FBD31C20F; Wed,  1 Feb 2006 18:03:26 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Wed, 01 Feb 2006 09:03:26 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 6E7884201E2; Wed,  1 Feb 2006 18:03:26 +0900 (JST)
Message-Id: <20060201090326.300490000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date:	Wed, 01 Feb 2006 18:02:40 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-mips@linux-mips.org, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 16/44] generic ext2_{set,clear}_bit_atomic()
Content-Disposition: inline; filename=ext2-atomic-bitops.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

This patch introduces the C-language equivalents of the functions below:

int ext2_set_bit_atomic(int nr, volatile unsigned long *addr);
int ext2_clear_bit_atomic(int nr, volatile unsigned long *addr);

In include/asm-generic/bitops/ext2-atomic.h

This code largely copied from:
include/asm-sparc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/ext2-atomic.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/ext2-atomic.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/ext2-atomic.h
@@ -0,0 +1,22 @@
+#ifndef _ASM_GENERIC_BITOPS_EXT2_ATOMIC_H_
+#define _ASM_GENERIC_BITOPS_EXT2_ATOMIC_H_
+
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (unsigned long *)(addr)); \
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (unsigned long *)(addr)); \
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#endif /* _ASM_GENERIC_BITOPS_EXT2_ATOMIC_H_ */

--
