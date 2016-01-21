Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 14:06:05 +0100 (CET)
Received: from smtpbg63.qq.com ([103.7.29.150]:54191 "EHLO smtpbg63.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010024AbcAUNFyBM4iu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 14:05:54 +0100
X-QQ-mid: bizesmtp15t1453381492t466t13
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 21 Jan 2016 21:04:47 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: 3jlOKZxptE6GHaJempPsTKuayociTY8EY++tKd4sq/ItVk4lxbyaB/8iCsmWr
        4wxTLwaX39gbOkZ21t3VRlVZIDeQMqO1IE9feVrLyd39a74zIJFRg2cM4kWVc6s/lqcMHxD
        hi7iAILqt4JvS9+txEaXNHeX7bSg0DBR+XggASfDWxEF4C+yUgt7s6XlQUKM3Ecd1HGIfwj
        FXd4vwnCOw430wWceFJFUqyIHWLhkxF6NMMf7PiBeWOMfCizUML9WKNzUeEFt0bohwO1w6t
        osFsM1VmQ4U87viVs4crly6E4=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 2/6] MIPS: Loongson-3: Improve -march option and move it to Platform
Date:   Thu, 21 Jan 2016 21:09:48 +0800
Message-Id: <1453381793-8357-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1453381793-8357-1-git-send-email-chenhc@lemote.com>
References: <1453381793-8357-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51278
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
