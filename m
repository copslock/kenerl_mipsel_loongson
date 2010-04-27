Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2010 07:46:14 +0200 (CEST)
Received: from mail-gx0-f228.google.com ([209.85.217.228]:52371 "EHLO
        mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491176Ab0D0FqL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Apr 2010 07:46:11 +0200
Received: by gxk28 with SMTP id 28so7819954gxk.7
        for <multiple recipients>; Mon, 26 Apr 2010 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KpdDFgJZHuT+9XPcFIof5moO7LpcWYDsXXLWVVxTetM=;
        b=V3BF/G2t7tzVhlFHY9LYd3PqU/yeZkixvQswdldyspzpDIM8pZbfmxhACv7EUcP/4Z
         VX0umvpZrTjHWavBsRSzq2c4tyFm4THBSx+OCZP7zUDGptXPGMUg/RdeDP/NMNx7LCQT
         QPH/xSLmZJ7jwOpC3z6GZXAoQH67YR0nfnD3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nR4CL8PkcALC+399ap9rrYE0Brm3AlHvW11s1lpZX7d2w/YzMLGSOL7qpdAnvVC0im
         BvsVuQHIb52vOTlid0OLgjzS2dCjAovLvo9irNq+i7E/psQ3VLhuXU0D2gcHF42++Qxb
         Q8BcwP6/K8Nv8Ax0R3l5Qsd/hDVfV6bO87fQ8=
Received: by 10.150.120.9 with SMTP id s9mr5111522ybc.299.1272347164743;
        Mon, 26 Apr 2010 22:46:04 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 16sm1784921gxk.9.2010.04.26.22.46.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 22:46:04 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, post@pfrst.de,
        linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/2] MIPS: Fixup and cleanup of TO_PHYS(), TO_CAC(), TO_UNCAC()
Date:   Tue, 27 Apr 2010 13:45:46 +0800
Message-Id: <1272347147-15071-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch fixes the TO_UNCAC() interface of 64bit kernel, the
TO_UNCAC(0xffffffff80000000) should yield 0x9000000000000000, but the
old TO_UNCAC() yield 0x97ffffff80000100 and make the kernel stop booting
with a bad address exception.

BTW, to share the same interface and remove the awful #ifdef, this patch
also provide the TO_PHYS(), TO_CAC(), TO_UNCAC() interfaces for the
32bit kernel, then we can substitue TO_UNCAC() for lots of old
KSEG1ADDR().

Thanks very much to Ralf, David, Thomas Bogendoerfer and post@pfrst.de for
their feedbacks of the following bug report:
http://www.linux-mips.org/archives/linux-mips/2010-04/msg00055.html

This patch is almost based on their feedbacks.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/addrspace.h           |   13 +++++++++++++
 arch/mips/include/asm/mach-generic/spaces.h |    8 ++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
index 569f80a..58c3fe7 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -136,6 +136,19 @@
  */
 #define TO_PHYS_MASK	_CONST64_(0x07ffffffffffffff)	/* 2^^59 - 1 */
 
+#ifdef CONFIG_64BIT
+#define kernel_physaddr(x) ({ \
+	u64 a = (u64)(x); \
+	if ((a & CKSEG0) == CKSEG0) \
+		a = CPHYSADDR(a); \
+	else \
+		a &= TO_PHYS_MASK; \
+	a; \
+})
+#else
+#define kernel_physaddr	CPHYSADDR
+#endif
+
 #ifndef CONFIG_CPU_R8000
 
 /*
diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index c9fa4b1..710f160 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -69,12 +69,12 @@
 #define HIGHMEM_START		(_AC(1, UL) << _AC(59, UL))
 #endif
 
-#define TO_PHYS(x)		(             ((x) & TO_PHYS_MASK))
-#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
-#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
-
 #endif /* CONFIG_64BIT */
 
+#define TO_PHYS(x)		kernel_physaddr(x)
+#define TO_CAC(x)		(CAC_BASE   | kernel_physaddr(x))
+#define TO_UNCAC(x)		(UNCAC_BASE | kernel_physaddr(x))
+
 /*
  * This handles the memory map.
  */
-- 
1.7.0
