Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 00:00:51 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17111 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492178Ab0FPWAr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 00:00:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c1949a20000>; Wed, 16 Jun 2010 15:01:06 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 16 Jun 2010 15:00:43 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 16 Jun 2010 15:00:43 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o5GM0fJf008614;
        Wed, 16 Jun 2010 15:00:41 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o5GM0esA008613;
        Wed, 16 Jun 2010 15:00:40 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Get rid of useless 'init_vdso successfully' message.
Date:   Wed, 16 Jun 2010 15:00:27 -0700
Message-Id: <1276725628-8572-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1276725628-8572-1-git-send-email-ddaney@caviumnetworks.com>
References: <1276725628-8572-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 16 Jun 2010 22:00:43.0704 (UTC) FILETIME=[5DEE2380:01CB0D9F]
X-archive-position: 27147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11587

In addition to being useless, it was mis-spelled.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/vdso.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 0847279..891c117 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -61,8 +61,6 @@ static int __init init_vdso(void)
 
 	vunmap(vdso);
 
-	pr_notice("init_vdso successfull\n");
-
 	return 0;
 }
 device_initcall(init_vdso);
-- 
1.6.6.1
