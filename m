Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 21:56:58 +0100 (CET)
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34778 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012410AbcBIU4K7H5Zb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 21:56:10 +0100
Received: by mail-pf0-f178.google.com with SMTP id x65so13823141pfb.1;
        Tue, 09 Feb 2016 12:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=geVG0zh7DL6asx5fKDlqVf3s5pSOS6Jg90MwGf9tVPA=;
        b=h9mPKwGg7uiOy28hiQB/W2EMwkG3s7emjPmlkmaCja9/n4xoLwb4DAX6CXKvAWhO7n
         KqP5BYMM3azB4UJTbWe32vVZShfUjQdm9kFBdxMxX4pH8cpdgebbqJOrvPkRNvFE1j2e
         WC5/2+DaZnfrd5mLN9KUD4JOZ1TTILU6bWsU8fooE9tk5UgSc/9SP3y1ZPqngP1AdP1q
         suvLAtrXvE0jBvMv1aNOLD9w62bHDLBG04CwEsw+Q7j2VpXPaVmWXtGT2n4u07dQvhbQ
         LrH0KL4ba0cPm1rCysqE/KLYVKKwJyjPbqbgKkDLbY/7Pr2sB2RP6rW+6ya8NxnBvFFP
         0Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=geVG0zh7DL6asx5fKDlqVf3s5pSOS6Jg90MwGf9tVPA=;
        b=M6r7PTZdvJsUFeSW6YtCMSvIFK7zBWbJt1YujGTMZ1ifjOUpkUOENryqc0ecf86Hew
         KyeUUgRQflsJZ4PEkagYeF2HZl+tpgSZt3fAeNtGqfLvcA9P0Rkene9tTL/l4HiUHjpg
         zhEtIoXDB9gFoNyWMam60/VBVXcFQHY8UeQtBuD4ShpiNfOVV3enc/wJoxXMB/WcY3mt
         Fgaz+cK8sTb3AWOAllqE0GuksQ71Gz3Hdo6MMAxcLXmFGVVW7V+kNYPs5MBcu8GVsOnU
         25+E6cnq8pL/8sOvWwZAQ3foVBDcC/eFWRaGBEkhaky94i0x+iONpHrtcHgFbnWGjQza
         qVlQ==
X-Gm-Message-State: AG10YOT/QoVGppxEEqhei+G3YlItFzKfzOeHb2LPvxUELTJ1gm+rbeBeHbSyWdZyMBjW9g==
X-Received: by 10.98.68.220 with SMTP id m89mr53022051pfi.65.1455051365293;
        Tue, 09 Feb 2016 12:56:05 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id n4sm52684059pfi.3.2016.02.09.12.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 12:56:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/6] MIPS: Allow RIXI to be used on non-R2 or R6 cores
Date:   Tue,  9 Feb 2016 12:55:51 -0800
Message-Id: <1455051354-6225-4-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Some processors, like Broadcom's BMIPS4380 and BMIPS5000 support RIXI and the
"rotr" instruction, which can be used to get a slightly more efficient page
table layout.

Introduce a CONFIG_CPU_HAS_RIXI such that those cores can benefit from this
feature. Perform the conditional check updates where relevant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Kconfig                    |  5 +++++
 arch/mips/include/asm/pgtable-bits.h | 11 ++++++-----
 arch/mips/mm/tlbex.c                 |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0f6b20a702fe..29f5b3138d6b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1963,11 +1963,13 @@ config CPU_MIPSR2
 	bool
 	default y if CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_CAVIUM_OCTEON
 	select MIPS_SPRAM
+	select CPU_HAS_RIXI
 
 config CPU_MIPSR6
 	bool
 	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
 	select MIPS_SPRAM
+	select CPU_HAS_RIXI
 
 config EVA
 	bool
@@ -2378,6 +2380,9 @@ config CPU_HAS_WB
 config XKS01
 	bool
 
+config CPU_HAS_RIXI
+	bool
+
 #
 # Vectored interrupt mode is an R2 feature
 #
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 97b313882678..0712b9b2e13d 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -112,8 +112,9 @@
  */
 #define _PAGE_PRESENT_SHIFT	0
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-/* R2 or later cores check for RI/XI support to determine _PAGE_READ */
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+/* R2, specific processors or later cores check for RI/XI support to determine
+ * _PAGE_READ */
+#ifdef CONFIG_CPU_HAS_RIXI
 #define _PAGE_WRITE_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
 #else
@@ -133,7 +134,7 @@
 #define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
 #endif	/* CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT */
 
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+#ifdef CONFIG_CPU_HAS_RIXI
 /* XI - page cannot be executed */
 #ifdef _PAGE_HUGE_SHIFT
 #define _PAGE_NO_EXEC_SHIFT	(_PAGE_HUGE_SHIFT + 1)
@@ -147,7 +148,7 @@
 #define _PAGE_READ		(cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
 #define _PAGE_NO_READ_SHIFT	_PAGE_READ_SHIFT
 #define _PAGE_NO_READ		(cpu_has_rixi ? (1 << _PAGE_READ_SHIFT) : 0)
-#endif	/* defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) */
+#endif	/* CONFIG_CPU_HAS_RIXI */
 
 #if defined(_PAGE_NO_READ_SHIFT)
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
@@ -198,7 +199,7 @@
  */
 static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 {
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+#ifdef CONFIG_CPU_HAS_RIXI
 	if (cpu_has_rixi) {
 		int sa;
 #ifdef CONFIG_32BIT
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 5a04b6f5c6fb..2efb85cdfa72 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -241,7 +241,7 @@ static void output_pgtable_bits_defines(void)
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	pr_define("_PAGE_HUGE_SHIFT %d\n", _PAGE_HUGE_SHIFT);
 #endif
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+#ifdef CONFIG_CPU_HAS_RIXI
 	if (cpu_has_rixi) {
 #ifdef _PAGE_NO_EXEC_SHIFT
 		pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
-- 
2.1.0
