Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 08:32:21 +0100 (CET)
Received: from www.wytron.com.tw ([211.75.82.101]:42230 "EHLO
        www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491046Ab0KXHcN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Nov 2010 08:32:13 +0100
Received: from [192.168.1.15] (helo=darkstar.wytron.com.tw)
        by www.wytron.com.tw with esmtp (Exim 4.69)
        (envelope-from <thomas@wytron.com.tw>)
        id 1PL9pg-0002dE-BD; Wed, 24 Nov 2010 15:32:00 +0800
From:   Thomas Chou <thomas@wytron.com.tw>
To:     devicetree-discuss@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, grant.likely@secretlab.ca,
        David Daney <ddaney@caviumnetworks.com>,
        Dezhong Diao <dediao@cisco.com>,
        Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH] of/mips: fix fdt size as be32
Date:   Wed, 24 Nov 2010 15:35:48 +0800
Message-Id: <1290584148-23111-1-git-send-email-thomas@wytron.com.tw>
X-Mailer: git-send-email 1.7.3.2
X-SA-Exim-Connect-IP: 192.168.1.15
X-SA-Exim-Mail-From: thomas@wytron.com.tw
X-SA-Exim-Scanned: No (on www.wytron.com.tw); SAEximRunCond expanded to false
Return-Path: <thomas@wytron.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@wytron.com.tw
Precedence: bulk
X-list: linux-mips

The totalsize field was be32. And the reserve bootmem would cause
failure.

Signed-off-by: Thomas Chou <thomas@wytron.com.tw>
---
 arch/mips/kernel/prom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index e000b27..9dbe583 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -100,7 +100,7 @@ void __init device_tree_init(void)
 		return;
 
 	base = virt_to_phys((void *)initial_boot_params);
-	size = initial_boot_params->totalsize;
+	size = be32_to_cpu(initial_boot_params->totalsize);
 
 	/* Before we do anything, lets reserve the dt blob */
 	reserve_mem_mach(base, size);
-- 
1.7.3.2
