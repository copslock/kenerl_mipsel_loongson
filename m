Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 03:29:23 +0100 (CET)
Received: from SMTPBG11.QQ.COM ([183.60.61.232]:60772 "EHLO smtpbg11.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008776AbbLMC3TkiM86 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 03:29:19 +0100
X-QQ-mid: bizesmtp5t1449973726t665t224
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 13 Dec 2015 10:28:39 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK62B00A0000000
X-QQ-FEAT: 9NFkmNiL4hcYDzQ8AULxA5aZzZr30h5KoK3s9Cu8vyD5x5qqp1ek1a9IVeT7F
        xhkxVLxhM/scNxtYKs5vtf77YaS4oMBvvKYpefM8h4gco/ev2vuPbVPdF42Sp1NEBpfaWHc
        hRZKEavhKWOe/b/kf0Diz7/ROQCmt3EQ5i+78j/m4mRfvdrzNEeGc799n+RDAoWP/NiGk4K
        WaKLGqP2T6d3y+15LHIHZqxSWCqqWkjgKbR59jBHjOVZtyL0sA6HGj4uzPMmrJbr3gflr3N
        3wKw==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/2] MIPS: Loongson-3: Improve -march option and move it to Platform
Date:   Sun, 13 Dec 2015 10:32:41 +0800
Message-Id: <1449973962-16405-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

If GCC >= 4.9 and Binutils >=2.25, we use -march=loongson3a, otherwise
we use -march=mips64r2, this can slightly improve performance. Besides,
arch/mips/loongson64/Platform is a better location rather than arch/
mips/Makefile.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Makefile            | 10 ----------
 arch/mips/loongson64/Platform | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 3f70ba5..e78d60d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -166,16 +166,6 @@ cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
 endif
 cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
 cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
-#
-# binutils from v2.25 on and gcc starting from v4.9.0 treat -march=loongson3a
-# as MIPS64 R1; older versions as just R1.  This leaves the possibility open
-# that GCC might generate R2 code for -march=loongson3a which then is rejected
-# by GAS.  The cc-option can't probe for this behaviour so -march=loongson3a
-# can't easily be used safely within the kbuild framework.
-#
-cflags-$(CONFIG_CPU_LOONGSON3)  +=					\
-	$(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
-	-Wa,-mips64r2 -Wa,--trap
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
 cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 2e48e83..85d8089 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -22,6 +22,27 @@ ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
   endif
 endif
 
+cflags-$(CONFIG_CPU_LOONGSON3)	+= -Wa,--trap
+#
+# binutils from v2.25 on and gcc starting from v4.9.0 treat -march=loongson3a
+# as MIPS64 R2; older versions as just R1.  This leaves the possibility open
+# that GCC might generate R2 code for -march=loongson3a which then is rejected
+# by GAS.  The cc-option can't probe for this behaviour so -march=loongson3a
+# can't easily be used safely within the kbuild framework.
+#
+ifeq ($(call cc-ifversion, -ge, 0409, y), y)
+  ifeq ($(call ld-ifversion, -ge, 22500000, y), y)
+    cflags-$(CONFIG_CPU_LOONGSON3)  += \
+      $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
+  else
+    cflags-$(CONFIG_CPU_LOONGSON3)  += \
+      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
+  endif
+else
+    cflags-$(CONFIG_CPU_LOONGSON3)  += \
+      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
+endif
+
 #
 # Loongson Machines' Support
 #
-- 
2.4.6
