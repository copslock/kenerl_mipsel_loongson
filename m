Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 02:33:32 +0100 (CET)
Received: from smtpbg65.qq.com ([103.7.28.233]:18638 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012109AbcCGBdMLVE04 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Mar 2016 02:33:12 +0100
X-QQ-mid: bizesmtp11t1457314346t959t22
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 07 Mar 2016 09:31:30 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70B00A0000000
X-QQ-FEAT: p/Y2uUKTrswE7QbExOp8mY4Au0wbEb6cPzmvR+n+FRXNtWR8aw5o4c2WzqZM8
        e2YSgskCIlfGrpzPoELhm4m+UJozRVqcxbS5zXn1MVT3YfQwHNGOFJBxByHkEAbI7cgAkfS
        IzJZgwdwVmWz12JvvOhS6jMoylcx6BpczDQf7ogjGuSpll7/4GxoyfwUO8sIjwkdLvgS8Av
        AfuI1ERiAgKnNwl3Sv+FIa6fbLghme7XyePYdRYPovherVwN8Wiv76ggUQY93Xl0Y1Bp6CG
        qL/sjrLYNwTbn7Ij8H4iJk9BM=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2 2/3] MIPS: Loongson-3: Fix build error after ld-version.sh modification
Date:   Mon,  7 Mar 2016 09:31:46 +0800
Message-Id: <1457314307-8510-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457314307-8510-1-git-send-email-chenhc@lemote.com>
References: <1457314307-8510-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52484
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
