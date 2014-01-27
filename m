Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:36:26 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44796 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827435AbaA0U0JpRT0s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:26:09 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 48/58] MIPS: mm: c-r4k: Build EVA {d,i}cache flushing functions
Date:   Mon, 27 Jan 2014 20:19:35 +0000
Message-ID: <1390853985-14246-49-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_26_04
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Build EVA specific cache flushing functions (ie cachee).
They will be used by a subsequent patch.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mm/c-r4k.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 13b549a..0c9c693 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -123,6 +123,28 @@ static void r4k_blast_dcache_page_setup(void)
 		r4k_blast_dcache_page = r4k_blast_dcache_page_dc64;
 }
 
+#ifndef CONFIG_EVA
+#define r4k_blast_dcache_user_page  r4k_blast_dcache_page
+#else
+
+static void (*r4k_blast_dcache_user_page)(unsigned long addr);
+
+static void r4k_blast_dcache_user_page_setup(void)
+{
+	unsigned long  dc_lsize = cpu_dcache_line_size();
+
+	if (dc_lsize == 0)
+		r4k_blast_dcache_user_page = (void *)cache_noop;
+	else if (dc_lsize == 16)
+		r4k_blast_dcache_user_page = blast_dcache16_user_page;
+	else if (dc_lsize == 32)
+		r4k_blast_dcache_user_page = blast_dcache32_user_page;
+	else if (dc_lsize == 64)
+		r4k_blast_dcache_user_page = blast_dcache64_user_page;
+}
+
+#endif
+
 static void (* r4k_blast_dcache_page_indexed)(unsigned long addr);
 
 static void r4k_blast_dcache_page_indexed_setup(void)
@@ -243,6 +265,27 @@ static void r4k_blast_icache_page_setup(void)
 		r4k_blast_icache_page = blast_icache64_page;
 }
 
+#ifndef CONFIG_EVA
+#define r4k_blast_icache_user_page  r4k_blast_icache_page
+#else
+
+static void (*r4k_blast_icache_user_page)(unsigned long addr);
+
+static void __cpuinit r4k_blast_icache_user_page_setup(void)
+{
+	unsigned long ic_lsize = cpu_icache_line_size();
+
+	if (ic_lsize == 0)
+		r4k_blast_icache_user_page = (void *)cache_noop;
+	else if (ic_lsize == 16)
+		r4k_blast_icache_user_page = blast_icache16_user_page;
+	else if (ic_lsize == 32)
+		r4k_blast_icache_user_page = blast_icache32_user_page;
+	else if (ic_lsize == 64)
+		r4k_blast_icache_user_page = blast_icache64_user_page;
+}
+
+#endif
 
 static void (* r4k_blast_icache_page_indexed)(unsigned long addr);
 
@@ -1454,6 +1497,10 @@ void r4k_cache_init(void)
 	r4k_blast_scache_page_setup();
 	r4k_blast_scache_page_indexed_setup();
 	r4k_blast_scache_setup();
+#ifdef CONFIG_EVA
+	r4k_blast_dcache_user_page_setup();
+	r4k_blast_icache_user_page_setup();
+#endif
 
 	/*
 	 * Some MIPS32 and MIPS64 processors have physically indexed caches.
-- 
1.8.5.3
