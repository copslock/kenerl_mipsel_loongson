Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 00:40:59 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5482 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491084Ab0IWWih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Sep 2010 00:38:37 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9bd70c0000>; Thu, 23 Sep 2010 15:39:08 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 15:38:36 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 15:38:35 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o8NMcVOA024772;
        Thu, 23 Sep 2010 15:38:31 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o8NMcVb4024771;
        Thu, 23 Sep 2010 15:38:31 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 8/9] MIPS: Add a platform hook for swiotlb setup.
Date:   Thu, 23 Sep 2010 15:38:15 -0700
Message-Id: <1285281496-24696-9-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Sep 2010 22:38:35.0956 (UTC) FILETIME=[0F318740:01CB5B70]
X-archive-position: 27811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18822

This allows platforms that are using the swiotlb to initialize it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/bootinfo.h |    5 +++++
 arch/mips/kernel/setup.c         |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 15a8ef0..b3cf989 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -125,4 +125,9 @@ extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
  */
 extern void plat_mem_setup(void);
 
+/*
+ * Optional platform hook to call swiotlb_setup().
+ */
+extern void plat_swiotlb_setup(void);
+
 #endif /* _ASM_BOOTINFO_H */
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 85aef3f..8b650da 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -488,6 +488,11 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	bootmem_init();
 	sparse_init();
+
+#ifdef CONFIG_SWIOTLB
+	plat_swiotlb_setup();
+#endif
+
 	paging_init();
 }
 
-- 
1.7.2.2
