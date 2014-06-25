Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 09:49:49 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:56766 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843037AbaFYHtmjO3jo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 09:49:42 +0200
Received: by mail-wi0-f181.google.com with SMTP id n3so1950303wiv.14
        for <multiple recipients>; Wed, 25 Jun 2014 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=x/tdWvLTIzaerkMyF036ZiXvO2uz1R8HSm+pDKgCLM0=;
        b=ERy97OfAjG+GuS7wI1bJb4A7DUSfKJbJiUtYQ/fOiR9xJPLfKDGvZ9Tk0IP1Fn2/+x
         LaAabcN2xsQJ09LC1tM8po7vYI48l9mJTdKEq/GTD3ZiBgilf0IApT571HCTsaCeYS6F
         jJTxtSpI049pKNoX3TmtaREFtJSADB06ASA9PHMo5O7UhKKJ2nkN8WzVkNptzbpImHNs
         +KDwPCxx8nGza+85PFxGZN1k417VoMRw429ad8q2GDI0ZyBOeRHMvN+pHNLwDMjb2i87
         tOMTWzUoiVaj1GL36qCNUFYBQGsqSMNl+ARhwjAk8R9ixna/tzTLtrTR8IlMFBXtURkW
         Qb1w==
X-Received: by 10.180.108.68 with SMTP id hi4mr3488285wib.80.1403682573241;
        Wed, 25 Jun 2014 00:49:33 -0700 (PDT)
Received: from linux-tdhb.lan (static-91-227-21-4.devs.futuro.pl. [91.227.21.4])
        by mx.google.com with ESMTPSA id ey16sm50851338wid.14.2014.06.25.00.49.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jun 2014 00:49:32 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [RFC][PATCH 1/2] Revert "MIPS: Delete unused function add_temporary_entry."
Date:   Wed, 25 Jun 2014 09:47:00 +0200
Message-Id: <1403682421-13297-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40788
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
