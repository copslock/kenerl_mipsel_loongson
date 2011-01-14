Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2011 02:56:19 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13503 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492829Ab1ANBzy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jan 2011 02:55:54 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d2fad580000>; Thu, 13 Jan 2011 17:56:40 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 13 Jan 2011 17:55:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 13 Jan 2011 17:55:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0E1tkQt016164;
        Thu, 13 Jan 2011 17:55:46 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0E1tkJC016163;
        Thu, 13 Jan 2011 17:55:46 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Allow for initrd outside of the reserved memory range.
Date:   Thu, 13 Jan 2011 17:55:42 -0800
Message-Id: <1294970143-16124-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1294970143-16124-1-git-send-email-ddaney@caviumnetworks.com>
References: <1294970143-16124-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 14 Jan 2011 01:55:52.0589 (UTC) FILETIME=[2CA463D0:01CBB38E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Introduce a flag, initrd_not_reserved, that when set will disable the
logic of moving the reserved_end to the end of the initrd.

This allows the initrd to be placed anywhere in memory and have its
memory reclaimed if it is placed in a BOOT_MEM_INIT_RAM region.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/bootinfo.h |    1 +
 arch/mips/kernel/setup.c         |   12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 7a51d87..0a4fd82 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -102,6 +102,7 @@ struct boot_mem_map {
 };
 
 extern struct boot_mem_map boot_mem_map;
+extern int initrd_not_reserved;
 
 extern void add_memory_region(phys_t start, phys_t size, long type);
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2d4eb68..8e65480 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -59,6 +59,9 @@ EXPORT_SYMBOL(mips_machtype);
 
 struct boot_mem_map boot_mem_map;
 
+/* Set if the initrd memory is BOOT_MEM_INIT_RAM */
+int initrd_not_reserved;
+
 static char __initdata command_line[COMMAND_LINE_SIZE];
 char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
 
@@ -267,8 +270,13 @@ static void __init bootmem_init(void)
 	 * not selected. Once that done we can determine the low bound
 	 * of usable memory.
 	 */
-	reserved_end = max(init_initrd(),
-			   (unsigned long) PFN_UP(__pa_symbol(&_end)));
+	if (initrd_not_reserved) {
+		init_initrd();
+		reserved_end = PFN_UP(__pa_symbol(&_end));
+	} else {
+		reserved_end = max(init_initrd(),
+				   (unsigned long) PFN_UP(__pa_symbol(&_end)));
+	}
 
 	/*
 	 * max_low_pfn is not a number of pages. The number of pages
-- 
1.7.2.3
