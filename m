Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2011 22:24:02 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17656 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491151Ab1EKUWp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2011 22:22:45 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dcaf0510000>; Wed, 11 May 2011 13:23:45 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 May 2011 13:22:43 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 May 2011 13:22:43 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p4BKMcMY032654;
        Wed, 11 May 2011 13:22:38 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p4BKMcSM032653;
        Wed, 11 May 2011 13:22:38 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/3] MIPS: lantiq: Check return value from strict_strtoul().
Date:   Wed, 11 May 2011 13:22:27 -0700
Message-Id: <1305145347-32605-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com>
References: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 11 May 2011 20:22:43.0652 (UTC) FILETIME=[2F0D2840:01CC1019]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The build fails if we don't check the return value from
strict_strtoul(), so print a message if it fails.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lantiq/setup.c b/arch/mips/lantiq/setup.c
index 2f27f58..9b8af77 100644
--- a/arch/mips/lantiq/setup.c
+++ b/arch/mips/lantiq/setup.c
@@ -35,7 +35,8 @@ void __init plat_mem_setup(void)
 		char *e = (char *)KSEG1ADDR(*envp);
 		if (!strncmp(e, "memsize=", 8)) {
 			e += 8;
-			strict_strtoul(e, 0, &memsize);
+			if (strict_strtoul(e, 0, &memsize))
+				pr_warn("bad memsize specified\n");
 		}
 		envp++;
 	}
-- 
1.7.2.3
