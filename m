Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2017 20:54:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11788 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991601AbdFLSysbYnon (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jun 2017 20:54:48 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D6030B7BD7D6;
        Mon, 12 Jun 2017 19:54:37 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 12 Jun 2017 19:54:41
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH v2 1/2] MIPS: Provide asm/isarev.h to define __mips_isa_rev
Date:   Mon, 12 Jun 2017 11:54:22 -0700
Message-ID: <20170612185423.18972-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <1645206.SpfHWSWaJU@np-p-burton>
References: <1645206.SpfHWSWaJU@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58412
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

__mips_isa_rev is a predefined macro provided by gcc to indicate the
revision of the MIPS ISA being targeted by the compiler. That is, for a
MIPS32r1 or MIPS64r1 build __mips_isa_rev will expand to 1, etc.

Unfortunately __mips_isa_rev isn't universally provided by gcc. In
particular it appears that gcc doesn't define __mips_isa_rev for
pre-MIPS32r1 builds, which leads to uses of it causing builds to fail
with errors such as:

  In file included from ./arch/mips/include/asm/bitops.h:21:0,
                   from ./include/linux/bitops.h:36,
                   from ./include/linux/kernel.h:10,
                   from arch/mips/kernel/cpu-probe.c:15:
  arch/mips/kernel/cpu-probe.c: In function 'cpu_set_nan_2008':
  ./arch/mips/include/asm/cpu-features.h:52:38: error: '__mips_isa_rev'
  undeclared (first use in this function); did you mean '__mips_set_bit'?
   #define __isa_lt_and_opt(isa, opt) ((__mips_isa_rev < (isa)) && __opt(opt))
                                        ^

In order to avoid this & allow use of __mips_isa_rev without having to
check whether it's defined at every use, this patch introduces a new
asm/isarev.h header which simply ensures that __mips_isa_rev is
provided. If the compiler predefines it then it is left alone, otherwise
it is set based upon CONFIG_CPU_MIPSR*. If we are targeting a pre-MIPSr1
ISA then __mips_isa_rev is defined as 0 which allows it to be used
logically in comparisons.

The 2 current non-UAPI uses of __mips_isa_rev are adjusted to include
asm/isarev.h & drop checks of defined(__mips_isa_rev).

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Joshua Kinard <kumba@gentoo.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

Changes in v2:
- New patch.

 arch/mips/include/asm/isarev.h | 26 ++++++++++++++++++++++++++
 arch/mips/net/bpf_jit_asm.S    |  9 +++++----
 arch/mips/vdso/elf.S           |  7 ++-----
 3 files changed, 33 insertions(+), 9 deletions(-)
 create mode 100644 arch/mips/include/asm/isarev.h

diff --git a/arch/mips/include/asm/isarev.h b/arch/mips/include/asm/isarev.h
new file mode 100644
index 000000000000..dc0aa95edfe9
--- /dev/null
+++ b/arch/mips/include/asm/isarev.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ */
+
+#if defined(__mips_isa_rev)
+# /* Yay, the compiler predefined __mips_isa_rev */
+#elif defined(CONFIG_CPU_MIPSR6)
+# define __mips_isa_rev 6
+#elif defined(CONFIG_CPU_MIPSR2)
+# define __mips_isa_rev 2
+#elif defined(CONFIG_CPU_MIPSR1)
+# define __mips_isa_rev 1
+#else
+# define __mips_isa_rev 0
+#endif
diff --git a/arch/mips/net/bpf_jit_asm.S b/arch/mips/net/bpf_jit_asm.S
index 88a2075305d1..5c1fca296c8d 100644
--- a/arch/mips/net/bpf_jit_asm.S
+++ b/arch/mips/net/bpf_jit_asm.S
@@ -11,6 +11,7 @@
  */
 
 #include <asm/asm.h>
+#include <asm/isarev.h>
 #include <asm/regdef.h>
 #include "bpf_jit.h"
 
@@ -65,7 +66,7 @@ FEXPORT(sk_load_word_positive)
 	lw	$r_A, 0(t1)
 	.set	noreorder
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-# if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
+# if __mips_isa_rev >= 2
 	wsbh	t0, $r_A
 	rotr	$r_A, t0, 16
 # else
@@ -92,7 +93,7 @@ FEXPORT(sk_load_half_positive)
 	PTR_ADDU t1, $r_skb_data, offset
 	lhu	$r_A, 0(t1)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-# if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
+# if __mips_isa_rev >= 2
 	wsbh	$r_A, $r_A
 # else
 	sll	t0, $r_A, 8
@@ -170,7 +171,7 @@ FEXPORT(sk_load_byte_positive)
 NESTED(bpf_slow_path_word, (6 * SZREG), $r_sp)
 	bpf_slow_path_common(4)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-# if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
+# if __mips_isa_rev >= 2
 	wsbh	t0, $r_s0
 	jr	$r_ra
 	 rotr	$r_A, t0, 16
@@ -196,7 +197,7 @@ NESTED(bpf_slow_path_word, (6 * SZREG), $r_sp)
 NESTED(bpf_slow_path_half, (6 * SZREG), $r_sp)
 	bpf_slow_path_common(2)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-# if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
+# if __mips_isa_rev >= 2
 	jr	$r_ra
 	 wsbh	$r_A, $r_s0
 # else
diff --git a/arch/mips/vdso/elf.S b/arch/mips/vdso/elf.S
index be37bbb1f061..15d8b1afee56 100644
--- a/arch/mips/vdso/elf.S
+++ b/arch/mips/vdso/elf.S
@@ -12,6 +12,7 @@
 
 #include <linux/elfnote.h>
 #include <linux/version.h>
+#include <asm/isarev.h>
 
 ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
@@ -40,11 +41,7 @@ __mips_abiflags:
 	.byte	__mips		/* isa_level */
 
 	/* isa_rev */
-#ifdef __mips_isa_rev
 	.byte	__mips_isa_rev
-#else
-	.byte	0
-#endif
 
 	/* gpr_size */
 #ifdef __mips64
@@ -54,7 +51,7 @@ __mips_abiflags:
 #endif
 
 	/* cpr1_size */
-#if (defined(__mips_isa_rev) && __mips_isa_rev >= 6) || defined(__mips64)
+#if (__mips_isa_rev >= 6) || defined(__mips64)
 	.byte	2		/* AFL_REG_64 */
 #else
 	.byte	1		/* AFL_REG_32 */
-- 
2.13.1
