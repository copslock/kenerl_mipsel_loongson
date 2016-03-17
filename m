Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:42:33 +0100 (CET)
Received: from smtpbg202.qq.com ([184.105.206.29]:54969 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014102AbcCQMmaX7NxI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Mar 2016 13:42:30 +0100
X-QQ-mid: bizesmtp7t1458218487t738t241
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 17 Mar 2016 20:40:16 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK60
X-QQ-FEAT: zvFLlFX1T3djtsKEsP+MX0Jdo7OopxXLZetQxCtpWKJuC3vg+CW7stVhj9BAH
        FgZQf6dHcDykpSRHoVGRmbcZkAMYWxdSbhzb16Vv3voZ8LWil0maCj0LIkiPqsHpiLBII6i
        cxTuBYmoHzKENTgAy6dcosM0B5lxBG5yL4uYMTiy+y17eKIUUiZNZyLcTK9VWpM0mIXEpWr
        9pdJKfbfiai5j9XQtbzdDYOeHSfnqtjskhfNq17bTtxxfRF/OxE2H6YSe+TbEdZ35YmIqoy
        6pXbXc+ZkI0fGKZtd5e+f4FXY=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V3 3/4] MIPS: Loongson-3: Fix build error after ld-version.sh modification
Date:   Thu, 17 Mar 2016 20:41:06 +0800
Message-Id: <1458218467-12210-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458218467-12210-1-git-send-email-chenhc@lemote.com>
References: <1458218467-12210-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52643
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

Commit d5ece1cb074b2c ("Fix ld-version.sh to handle large 3rd version
part") modifies the ld version description. This causes a build error
on Loongson-3, so fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/Platform | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 85d8089..0fce460 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -31,7 +31,7 @@ cflags-$(CONFIG_CPU_LOONGSON3)	+= -Wa,--trap
 # can't easily be used safely within the kbuild framework.
 #
 ifeq ($(call cc-ifversion, -ge, 0409, y), y)
-  ifeq ($(call ld-ifversion, -ge, 22500000, y), y)
+  ifeq ($(call ld-ifversion, -ge, 225000000, y), y)
     cflags-$(CONFIG_CPU_LOONGSON3)  += \
       $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
   else
-- 
2.7.0
