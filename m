Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 14:35:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11295 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028035AbcEFMfa2bk2G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2016 14:35:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 545B12A971D57;
        Fri,  6 May 2016 13:35:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 13:35:24 +0100
Received: from localhost (10.100.200.129) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 6 May
 2016 13:35:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Implement __arch_bitrev* using bitswap for MIPSr6
Date:   Fri, 6 May 2016 13:35:03 +0100
Message-ID: <1462538103-6633-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.129]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Release 6 of the MIPS architecture introduced the bitswap instruction,
which reverses the bits within each byte of a word. Make use of this
instruction to implement the __arch_bitrev* functions, which should be
faster for most MIPSr6 CPUs, reduces code size slightly and allows us to
avoid the lookup table used by the generic implementation, saving 256
bytes in the kernel binary by dropping that.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig              |  1 +
 arch/mips/include/asm/bitrev.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 arch/mips/include/asm/bitrev.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dd2b372..5b8fd2e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2046,6 +2046,7 @@ config CPU_MIPSR2
 config CPU_MIPSR6
 	bool
 	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
+	select HAVE_ARCH_BITREVERSE
 	select MIPS_ASID_BITS_VARIABLE
 	select MIPS_SPRAM
 
diff --git a/arch/mips/include/asm/bitrev.h b/arch/mips/include/asm/bitrev.h
new file mode 100644
index 0000000..bc739a4
--- /dev/null
+++ b/arch/mips/include/asm/bitrev.h
@@ -0,0 +1,30 @@
+#ifndef __MIPS_ASM_BITREV_H__
+#define __MIPS_ASM_BITREV_H__
+
+#include <linux/swab.h>
+
+static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
+{
+	u32 ret;
+
+	asm("bitswap	%0, %1" : "=r"(ret) : "r"(__swab32(x)));
+	return ret;
+}
+
+static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
+{
+	u16 ret;
+
+	asm("bitswap	%0, %1" : "=r"(ret) : "r"(__swab16(x)));
+	return ret;
+}
+
+static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
+{
+	u8 ret;
+
+	asm("bitswap	%0, %1" : "=r"(ret) : "r"(x));
+	return ret;
+}
+
+#endif /* __MIPS_ASM_BITREV_H__ */
-- 
2.8.2
