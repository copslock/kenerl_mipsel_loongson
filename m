Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 00:09:36 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:61890 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904243Ab1KJXJa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 00:09:30 +0100
Received: by iapp10 with SMTP id p10so4406155iap.36
        for <multiple recipients>; Thu, 10 Nov 2011 15:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yyEoXXxKt011ZaIxsCU9nV2aFC2ATjrNR7uzjhIkZu8=;
        b=T/d+RXTFXHl6mNAWBqmKUBFw9gEze+mQDm87Z5Gbn/AC+34dJfvDOi1x0VvdlnbAZJ
         lzXU+gVGPjFS6eFpP1E45DKnPHw71LNtDgwZkWKFIIDk8VW73tN+YoISM7N9jYv+hi71
         psz785pV62iC42svulH+zShuN1sMnptocdH2Q=
Received: by 10.43.53.1 with SMTP id vo1mr10142277icb.2.1320966563553;
        Thu, 10 Nov 2011 15:09:23 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id z10sm13291923ibv.9.2011.11.10.15.09.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 15:09:23 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAAN9Lvr001907;
        Thu, 10 Nov 2011 15:09:21 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAAN9KYx001906;
        Thu, 10 Nov 2011 15:09:20 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: Octeon: Update struct cvmx_bootinfo to v3.
Date:   Thu, 10 Nov 2011 15:09:10 -0800
Message-Id: <1320966550-1858-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9827

From: David Daney <david.daney@cavium.com>

Bootloaders can pass version 3 of this structure.  Add the new fields
so we can support the Device Tree.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-bootinfo.h |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index 4e4c3a8..d9d1668 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -39,7 +39,7 @@
  * versions.
  */
 #define CVMX_BOOTINFO_MAJ_VER 1
-#define CVMX_BOOTINFO_MIN_VER 2
+#define CVMX_BOOTINFO_MIN_VER 3
 
 #if (CVMX_BOOTINFO_MAJ_VER == 1)
 #define CVMX_BOOTINFO_OCTEON_SERIAL_LEN 20
@@ -116,7 +116,13 @@ struct cvmx_bootinfo {
 	 */
 	uint32_t config_flags;
 #endif
-
+#if (CVMX_BOOTINFO_MIN_VER >= 3)
+	/*
+	 * Address of the OF Flattened Device Tree structure
+	 * describing the board.
+	 */
+	uint64_t fdt_addr;
+#endif
 };
 
 #define CVMX_BOOTINFO_CFG_FLAG_PCI_HOST			(1ull << 0)
-- 
1.7.2.3
