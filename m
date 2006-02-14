Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 05:09:25 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:55247 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S3458571AbWBNE6y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 04:58:54 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id BF78F31C328; Tue, 14 Feb 2006 14:04:50 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Tue, 14 Feb 2006 05:04:47 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 02042420233; Tue, 14 Feb 2006 14:04:43 +0900 (JST)
Message-Id: <20060214050443.852246000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date:	Tue, 14 Feb 2006 14:04:02 +0900
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
Subject: [patch 11/47] generic fls64()
Content-Disposition: inline; filename=fls64.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

This patch introduces the C-language equivalent of the function:
int fls64(__u64 x);

In include/asm-generic/bitops/fls64.h

This code largely copied from:
include/linux/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/fls64.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/fls64.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/fls64.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_GENERIC_BITOPS_FLS64_H_
+#define _ASM_GENERIC_BITOPS_FLS64_H_
+
+static inline int fls64(__u64 x)
+{
+	__u32 h = x >> 32;
+	if (h)
+		return fls(h) + 32;
+	return fls(x);
+}
+
+#endif /* _ASM_GENERIC_BITOPS_FLS64_H_ */

--
