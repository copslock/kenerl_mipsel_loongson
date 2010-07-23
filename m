Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:58:27 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10113 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491913Ab0GWR56 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:57:58 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d8400000>; Fri, 23 Jul 2010 10:58:24 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:57:56 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:57:56 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHvrKc024464;
        Fri, 23 Jul 2010 10:57:53 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHvrSf024463;
        Fri, 23 Jul 2010 10:57:53 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/3] MIPS: Octeon: Simplify hotcpu_notifier registration.
Date:   Fri, 23 Jul 2010 10:57:50 -0700
Message-Id: <1279907871-24419-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279907871-24419-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279907871-24419-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Jul 2010 17:57:56.0774 (UTC) FILETIME=[94A5C460:01CB2A90]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/smp.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 8ff2c7b..ceb7649 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -428,17 +428,11 @@ static int __cpuinit octeon_cpu_callback(struct notifier_block *nfb,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __cpuinitdata octeon_cpu_notifier = {
-	.notifier_call = octeon_cpu_callback,
-};
-
 static int __cpuinit register_cavium_notifier(void)
 {
-	register_hotcpu_notifier(&octeon_cpu_notifier);
-
+	hotcpu_notifier(octeon_cpu_callback, 0);
 	return 0;
 }
-
 late_initcall(register_cavium_notifier);
 
 #endif  /* CONFIG_HOTPLUG_CPU */
-- 
1.7.1.1
