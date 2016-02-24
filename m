Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 15:37:57 +0100 (CET)
Received: from SMTPBG352.QQ.COM ([183.57.50.167]:60703 "EHLO smtpbg352.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013917AbcBXOhtvjre6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2016 15:37:49 +0100
X-QQ-mid: bizesmtp8t1456324638t591t061
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 24 Feb 2016 22:36:51 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: 6dXuswn9i1UiQHObnD2OpDjX+IiQzkCmCw/j3/gdeuoZk0wBXAAvbvPY77nmR
        7y0pLAkRfpuXHUcJtccYxtk2F7sFyqHDvgy3cpG/LXvSgHT1QntePGeyht5kmAkiZh3ioCl
        lWXBTSVyhCeuBqEWUh0t0frxta3DSdYXra5Fy0hQ6izERQmy2UM8YhM2gPEUuaSQbMrhuTy
        NrQzEylWhkdkhOlnxm7jPZn/haj7++Zp32nW43nwdA+js9WKp4Nh/ua+T8Ji8NLqfLqA52O
        SKh4t/npzbXYt2PwEEzdSH5bA=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 4/5] MIPS: Loongson-3: Use cpu_has_coherent_cache feature
Date:   Wed, 24 Feb 2016 22:33:03 +0800
Message-Id: <1456324384-18118-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52198
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

Loongson-3 maintains cache coherency by hardware, this means:
 1) Loongson-3's icache is coherent with dcache.
 2) Loongson-3's dcaches don't alias (if PAGE_SIZE>=16K).
 3) Loongson-3 maintains cache coherency across cores (and for DMA).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index c3406db..647d952 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -46,6 +46,7 @@
 #define cpu_has_local_ebase	0
 
 #define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
+#define cpu_has_coherent_cache	IS_ENABLED(CONFIG_CPU_LOONGSON3)
 #define cpu_hwrena_impl_bits	0xc0000000
 
 #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
-- 
2.7.0


3h™
