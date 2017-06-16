Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 11:32:34 +0200 (CEST)
Received: from smtpproxy19.qq.com ([184.105.206.84]:42417 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993910AbdFPJcZ0aEhh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 11:32:25 +0200
X-QQ-mid: bizesmtp9t1497605510t5sfirg8d
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 16 Jun 2017 17:30:37 +0800 (CST)
X-QQ-SSF: 01100000002000F0FL92B00A0000000
X-QQ-FEAT: 3GtnPQ8BMmZ04GCOXXlZObL4m5ac+2peaWmdh9WQwGsFlGnvAWQmeB4dbRQyu
        K8UCKPc4m9U/1x0d64HkSlYf/S61zSF0B6zGbhsxZi8SWEIIZug3yxsRpIoRFcTzEbSEaWz
        geStobWwXoXZMgMtQROjlZarcGsmfNCqtWiryJmU/ZNPq1w7F5Po7GZf0/XNwMDIPjHGsQN
        N/jBzV8fKWF2U8PrJ4ZzI2LfSSYCitN+lGVD5jJej2nDWoyZ/3wXyxIbUxFriqzQMvqgKlv
        4NpSb1++0z6U1WeEYDL3RWN+LSXqJHyZLcRAov/+1KQ+Pv
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V6 3/9] MIPS: Loongson: Add NMI handler support
Date:   Fri, 16 Jun 2017 17:28:56 +0800
Message-Id: <1497605342-5030-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1497605342-5030-1-git-send-email-chenhc@lemote.com>
References: <1497605342-5030-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58516
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/common/init.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/loongson64/common/init.c b/arch/mips/loongson64/common/init.c
index 9b987fe..6ef1712 100644
--- a/arch/mips/loongson64/common/init.c
+++ b/arch/mips/loongson64/common/init.c
@@ -10,13 +10,25 @@
 
 #include <linux/bootmem.h>
 #include <asm/bootinfo.h>
+#include <asm/traps.h>
 #include <asm/smp-ops.h>
+#include <asm/cacheflush.h>
 
 #include <loongson.h>
 
 /* Loongson CPU address windows config space base address */
 unsigned long __maybe_unused _loongson_addrwincfg_base;
 
+static void __init mips_nmi_setup(void)
+{
+	void *base;
+	extern char except_vec_nmi;
+
+	base = (void *)(CAC_BASE + 0x380);
+	memcpy(base, &except_vec_nmi, 0x80);
+	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
+}
+
 void __init prom_init(void)
 {
 #ifdef CONFIG_CPU_SUPPORTS_ADDRWINCFG
@@ -40,6 +52,7 @@ void __init prom_init(void)
 	/*init the uart base address */
 	prom_init_uart_base();
 	register_smp_ops(&loongson3_smp_ops);
+	board_nmi_handler_setup = mips_nmi_setup;
 }
 
 void __init prom_free_prom_memory(void)
-- 
2.7.0


rt
