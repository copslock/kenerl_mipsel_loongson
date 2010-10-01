Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 22:30:44 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8593 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492027Ab0JAU1y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 22:27:54 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca644670002>; Fri, 01 Oct 2010 13:28:23 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:52 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:52 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o91KRi8v028728;
        Fri, 1 Oct 2010 13:27:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o91KRiUf028727;
        Fri, 1 Oct 2010 13:27:44 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 7/8] MIPS: Add a platform hook for swiotlb setup.
Date:   Fri,  1 Oct 2010 13:27:33 -0700
Message-Id: <1285964854-28659-8-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 01 Oct 2010 20:27:52.0783 (UTC) FILETIME=[1F9A4DF0:01CB61A7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This allows platforms that are using the swiotlb to initialize it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/bootinfo.h |   12 ++++++++++++
 arch/mips/kernel/setup.c         |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 15a8ef0..35cd1ba 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -125,4 +125,16 @@ extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
  */
 extern void plat_mem_setup(void);
 
+#ifdef CONFIG_SWIOTLB
+/*
+ * Optional platform hook to call swiotlb_setup().
+ */
+extern void plat_swiotlb_setup(void);
+
+#else
+
+static inline void plat_swiotlb_setup(void) {}
+
+#endif /* CONFIG_SWIOTLB */
+
 #endif /* _ASM_BOOTINFO_H */
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 85aef3f..4e68a51 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -488,6 +488,7 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	bootmem_init();
 	sparse_init();
+	plat_swiotlb_setup();
 	paging_init();
 }
 
-- 
1.7.2.2
