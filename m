Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 17:50:28 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:5610 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023138AbXGXQu0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2007 17:50:26 +0100
Received: from localhost (p1202-ipad203funabasi.chiba.ocn.ne.jp [222.146.80.202])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3B275B48D; Wed, 25 Jul 2007 01:49:06 +0900 (JST)
Date:	Wed, 25 Jul 2007 01:50:08 +0900 (JST)
Message-Id: <20070725.015008.78730579.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] tx49xx: add some mach specific headers
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 .../asm-mips/mach-tx49xx/cpu-feature-overrides.h   |   23 ++++++++++++++++++++
 include/asm-mips/mach-tx49xx/kmalloc.h             |    8 +++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/mach-tx49xx/cpu-feature-overrides.h b/include/asm-mips/mach-tx49xx/cpu-feature-overrides.h
new file mode 100644
index 0000000..275eaf9
--- /dev/null
+++ b/include/asm-mips/mach-tx49xx/cpu-feature-overrides.h
@@ -0,0 +1,23 @@
+#ifndef __ASM_MACH_TX49XX_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_TX49XX_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_llsc	1
+#define cpu_has_64bits	1
+#define cpu_has_inclusive_pcaches	0
+
+#define cpu_has_mips16		0
+#define cpu_has_mdmx		0
+#define cpu_has_mips3d		0
+#define cpu_has_smartmips	0
+#define cpu_has_vtag_icache	0
+#define cpu_has_ic_fills_f_dc	0
+#define cpu_has_dsp	0
+#define cpu_has_mipsmt	0
+#define cpu_has_userlocal	0
+
+#define cpu_has_mips32r1	0
+#define cpu_has_mips32r2	0
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
+#endif /* __ASM_MACH_TX49XX_CPU_FEATURE_OVERRIDES_H */
diff --git a/include/asm-mips/mach-tx49xx/kmalloc.h b/include/asm-mips/mach-tx49xx/kmalloc.h
new file mode 100644
index 0000000..913ff19
--- /dev/null
+++ b/include/asm-mips/mach-tx49xx/kmalloc.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_MACH_TX49XX_KMALLOC_H
+#define __ASM_MACH_TX49XX_KMALLOC_H
+
+/*
+ * All happy, no need to define ARCH_KMALLOC_MINALIGN
+ */
+
+#endif /* __ASM_MACH_TX49XX_KMALLOC_H */
