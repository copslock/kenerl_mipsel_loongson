Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 23:26:55 +0200 (CEST)
Received: from mail-we0-f169.google.com ([74.125.82.169]:33124 "EHLO
        mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860088AbaGQV0xXqTqf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 23:26:53 +0200
Received: by mail-we0-f169.google.com with SMTP id u56so3735438wes.28
        for <multiple recipients>; Thu, 17 Jul 2014 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=x/tdWvLTIzaerkMyF036ZiXvO2uz1R8HSm+pDKgCLM0=;
        b=gX9c+UYbG7DK0ygNFDPfjA37d74wsze3mxfJwXAek0OTzWhSJIUeFlinnw33LkOCY2
         iQuFINhJiXyOU8PYtcfZWwNsWZEadMbvA5dlMHM9YkLQcSN+O7zG6iSS4Y1e4zDm/gFJ
         V5/ddMivFJH1X4ROcBpByQxNN9kiZfeOmeXHM4hSY0pd+xLPIvBVIgxMyYaNlqLcUji/
         W+bmPug92zLX4Bn2xRR5MDC4ETBx+qkK7L7R5UXt0c/uBxh3OoxgPPZ3LUhOJUs55rdA
         juwJhFZjR2Rnu57JicNVmgrt/hD0JDoDVQ8OHK2ph670KHaS8FylgYtEuOUUMC0LaEP3
         tTPA==
X-Received: by 10.180.21.235 with SMTP id y11mr1126145wie.75.1405632408145;
        Thu, 17 Jul 2014 14:26:48 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id fu7sm25223443wib.2.2014.07.17.14.26.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 14:26:47 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/2] Revert "MIPS: Delete unused function add_temporary_entry."
Date:   Thu, 17 Jul 2014 23:26:32 +0200
Message-Id: <1405632393-17960-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

This reverts commit d7a887a73dec6c387b02a966a71aac767bbd9ce6.

Function add_temporary_entry is needed by bcm47xx to support highmem. We
need to add a temporary entry to check for amount of RAM.
The only change made in this revert was replacing (ENTER|EXIT)_CRITICAL.

Conflicts:
	arch/mips/include/asm/pgtable-32.h
	arch/mips/mm/tlb-r4k.c

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/include/asm/pgtable-32.h | 10 ++++++++
 arch/mips/mm/tlb-r4k.c             | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index b4204c1..2b11332 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -19,6 +19,16 @@
 #include <asm-generic/pgtable-nopmd.h>
 
 /*
+ * - add_temporary_entry() add a temporary TLB entry. We use TLB entries
+ *	starting at the top and working down. This is for populating the
+ *	TLB before trap_init() puts the TLB miss handler in place. It
+ *	should be used only for entries matching the actual page tables,
+ *	to prevent inconsistencies.
+ */
+extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
+			       unsigned long entryhi, unsigned long pagemask);
+
+/*
  * Basically we have the same two-level (which is the logical three level
  * Linux page table layout folded) page tables as the i386.  Some day
  * when we have proper page coloring support we can have a 1% quicker
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 3914e27..04feeb5 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -391,6 +391,51 @@ int __init has_transparent_hugepage(void)
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
 
+/*
+ * Used for loading TLB entries before trap_init() has started, when we
+ * don't actually want to add a wired entry which remains throughout the
+ * lifetime of the system
+ */
+
+static int temp_tlb_entry __cpuinitdata;
+
+__init int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
+			       unsigned long entryhi, unsigned long pagemask)
+{
+	int ret = 0;
+	unsigned long flags;
+	unsigned long wired;
+	unsigned long old_pagemask;
+	unsigned long old_ctx;
+
+	local_irq_save(flags);
+	/* Save old context and create impossible VPN2 value */
+	old_ctx = read_c0_entryhi();
+	old_pagemask = read_c0_pagemask();
+	wired = read_c0_wired();
+	if (--temp_tlb_entry < wired) {
+		printk(KERN_WARNING
+		       "No TLB space left for add_temporary_entry\n");
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	write_c0_index(temp_tlb_entry);
+	write_c0_pagemask(pagemask);
+	write_c0_entryhi(entryhi);
+	write_c0_entrylo0(entrylo0);
+	write_c0_entrylo1(entrylo1);
+	mtc0_tlbw_hazard();
+	tlb_write_indexed();
+	tlbw_use_hazard();
+
+	write_c0_entryhi(old_ctx);
+	write_c0_pagemask(old_pagemask);
+out:
+	local_irq_restore(flags);
+	return ret;
+}
+
 static int ntlb;
 static int __init set_ntlb(char *str)
 {
@@ -431,6 +476,8 @@ static void r4k_tlb_configure(void)
 		write_c0_pagegrain(pg);
 	}
 
+	temp_tlb_entry = current_cpu_data.tlbsize - 1;
+
 	/* From this point on the ARC firmware is dead.	 */
 	local_flush_tlb_all();
 
-- 
1.8.4.5
