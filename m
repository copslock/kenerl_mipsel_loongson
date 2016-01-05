Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 06:54:37 +0100 (CET)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:57634 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007189AbcAEFye6sHP- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jan 2016 06:54:34 +0100
X-QQ-mid: bizesmtp4t1451973254t244t260
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 05 Jan 2016 13:54:13 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: 6dXuswn9i1WC2RVMz1rE+DNwR+c9K5vXWsp1vaE2wcNES80G7GwPublUR+M5Z
        7fB+0KFr6fyDDTQWZ9xLzn/aGAUb201fmYQ++N/yDTWl2pDBW97jqTMqDRSj3sNEFuPaffh
        DgjYbt0+CB8sXZznpqb+Ek0Bz5Atz0AOXmlY3tpWk1wOdV2NninwN6lMsL4FStdb9qvJX0w
        +hDvif+is44PMoPDwv+oWOUxZmbgBV4kWi7SNmI+WxG26swHl1w/nMwm7gFRx9EyM+J+MAW
        3wT3yX7LVyteeP
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/6] MIPS: Loongson-3: Improve -march option and move it to Platform
Date:   Tue,  5 Jan 2016 13:59:05 +0800
Message-Id: <1451973549-16198-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
References: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50896
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
