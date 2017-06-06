Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 05:18:40 +0200 (CEST)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:58335 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992028AbdFFDScNJpHo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jun 2017 05:18:32 +0200
X-QQ-mid: bizesmtp16t1496719064tli5kh4k
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2017 11:16:23 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK92000A0000000
X-QQ-FEAT: QX/rXDl9P1vIMEOmXAMbWjPveriFNodhaXfKZE5MT9GikjKe6IzJhUMqpZxbJ
        fQrdL884tpkfALI7aJnL1eCv3NDfsoLqr3keCYtOo5WrodH4nzjHjTwJsLh96yfGKSAxS1M
        MVOIIQJ4FjCwSep021WLWsJe7vLLxMsnLBtgXBcTHm8HOreWv59Xwjk7pvQf+apWRprDpzj
        6oHz67DkYvmofHGNvxxMQEfKRx9gyqg6LqLEKIvZKBgYfn2yIJXN/BX/Z8l9ykvzcgDdL55
        hM/2SePkzBZZ+WPle+3W8RhSbRVutqwMAs9A==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4 3/9] MIPS: Loongson: Add NMI handler support
Date:   Tue,  6 Jun 2017 11:14:42 +0800
Message-Id: <1496718888-18324-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
References: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58245
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



Ù
