Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2010 20:24:19 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17290 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab0IWSYQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Sep 2010 20:24:16 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9b9b6f0000>; Thu, 23 Sep 2010 11:24:47 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 11:24:14 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 11:24:14 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o8NIOCwr012945;
        Thu, 23 Sep 2010 11:24:12 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o8NIOAQP012944;
        Thu, 23 Sep 2010 11:24:10 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Place cnmips_cu2_setup in __init memory.
Date:   Thu, 23 Sep 2010 11:24:09 -0700
Message-Id: <1285266249-12912-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
X-OriginalArrivalTime: 23 Sep 2010 18:24:14.0385 (UTC) FILETIME=[86969A10:01CB5B4C]
X-archive-position: 27804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18555

It is an early_initcall, so it should be in __init memory.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/cpu.c b/arch/mips/cavium-octeon/cpu.c
index c664c8c..a5b4279 100644
--- a/arch/mips/cavium-octeon/cpu.c
+++ b/arch/mips/cavium-octeon/cpu.c
@@ -41,7 +41,7 @@ static int cnmips_cu2_call(struct notifier_block *nfb, unsigned long action,
 	return NOTIFY_OK;		/* Let default notifier send signals */
 }
 
-static int cnmips_cu2_setup(void)
+static int __init cnmips_cu2_setup(void)
 {
 	return cu2_notifier(cnmips_cu2_call, 0);
 }
-- 
1.7.2.2
