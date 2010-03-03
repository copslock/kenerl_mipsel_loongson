Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 09:44:25 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:47817 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491773Ab0CCIni (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 09:43:38 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o238hMYC014446;
        Wed, 3 Mar 2010 00:43:29 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ddaney@caviumnetworks.com, ralf@linux-mips.org,
        f.fainelli@gmail.com
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/3] MIPS: Octeon: Remove redundant declaration of octeon_reserve32_memory
Date:   Wed,  3 Mar 2010 16:43:20 +0800
Message-Id: <50e36e8549769a26986f99a23772d23fd039c230.1267604875.git.yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
References: <1267605801-5305-1-git-send-email-yang.shi@windriver.com>
 <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
In-Reply-To: <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
References: <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

In Octeon's setup.c, octeon_reserve32_memory is defined, so remove the
redundant extern declaration of this variable.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/cavium-octeon/setup.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 4eaa35f..8309d68 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -45,9 +45,6 @@ extern struct plat_smp_ops octeon_smp_ops;
 extern void pci_console_init(const char *arg);
 #endif
 
-#ifdef CONFIG_CAVIUM_RESERVE32
-extern uint64_t octeon_reserve32_memory;
-#endif
 static unsigned long long MAX_MEMORY = 512ull << 20;
 
 struct octeon_boot_descriptor *octeon_boot_desc_ptr;
-- 
1.6.3.3
