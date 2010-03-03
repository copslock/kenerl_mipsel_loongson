Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 09:44:02 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:47810 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491179Ab0CCInh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 09:43:37 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o238hMYB014446;
        Wed, 3 Mar 2010 00:43:27 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ddaney@caviumnetworks.com, ralf@linux-mips.org,
        f.fainelli@gmail.com
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/3] MIPS: Octeon: Remove superfluous on_each_cpu parameter
Date:   Wed,  3 Mar 2010 16:43:19 +0800
Message-Id: <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1267605801-5305-1-git-send-email-yang.shi@windriver.com>
References: <1267605801-5305-1-git-send-email-yang.shi@windriver.com>
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Now, on_each_cpu just need three parameters, but the on_each_cpu
still uses four parameters in Octeon's setup.c. So, remove the
superfluous parameter.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/cavium-octeon/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index b321d3b..4eaa35f 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -230,7 +230,7 @@ static void octeon_hal_setup_per_cpu_reserved32(void *unused)
 void octeon_hal_setup_reserved32(void)
 {
 #ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
-	on_each_cpu(octeon_hal_setup_per_cpu_reserved32, NULL, 0, 1);
+	on_each_cpu(octeon_hal_setup_per_cpu_reserved32, NULL, 1);
 #endif
 }
 
-- 
1.6.3.3
