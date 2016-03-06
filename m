Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 04:51:10 +0100 (CET)
Received: from smtpbgau1.qq.com ([54.206.16.166]:52109 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27005160AbcCFDvGxOt90 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Mar 2016 04:51:06 +0100
X-QQ-mid: bizesmtp10t1457236229t635t05
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 06 Mar 2016 11:49:38 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70B00A0000000
X-QQ-FEAT: 0ESs8nxzjD+qWbCwpk/JP5zX1c5A+CzCy3HGHWfRsTooGnrmM91VkDHx3gG6H
        EYZiWM8SxoN3f0JG+4hUlWpLx5LsEjYQlDh3N0bqUU+73JIe/uon2eltgF+Ogud5OstZd5/
        cf0FyNqusRVwXyXG5WnoCM8u69SQBW55/IX9Aj6QTicvd/bWEooD2FdhMXInK/sVsb2zSAh
        XT5j3fcTVrfrgPaHs5bXlnalquRjR3obyqtoc+5vVUNzwlm38l6VTc6N5uIo7YGJaFzNKuj
        q40gZErzi3gcdNGojpMQkNpJY=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/3] MIPS: Loongson-3: Fix build error after ld-version.sh modification
Date:   Sun,  6 Mar 2016 11:50:01 +0800
Message-Id: <1457236202-16321-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457236202-16321-1-git-send-email-chenhc@lemote.com>
References: <1457236202-16321-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52471
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

Commit d5ece1cb074b2c708 (Fix ld-version.sh to handle large 3rd version
part) modifies the ld version description. This causes a build error on
Loongson-3, so fix it.

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
