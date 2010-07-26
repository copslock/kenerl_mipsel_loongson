Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2010 23:07:44 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9698 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492313Ab0GZVHk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jul 2010 23:07:40 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4df9360000>; Mon, 26 Jul 2010 14:08:06 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 14:07:38 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 14:07:37 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6QL7US8008603;
        Mon, 26 Jul 2010 14:07:30 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6QL7SHx008602;
        Mon, 26 Jul 2010 14:07:28 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Fix build error in cavium-octeon/cpu.c
Date:   Mon, 26 Jul 2010 14:07:27 -0700
Message-Id: <1280178447-8570-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 26 Jul 2010 21:07:37.0947 (UTC) FILETIME=[939832B0:01CB2D06]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This file was not building.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

Building against linux-queue I was getting errors due to changes in
cu2_notifier.

 arch/mips/cavium-octeon/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/cpu.c b/arch/mips/cavium-octeon/cpu.c
index 0ad070c..c664c8c 100644
--- a/arch/mips/cavium-octeon/cpu.c
+++ b/arch/mips/cavium-octeon/cpu.c
@@ -43,6 +43,6 @@ static int cnmips_cu2_call(struct notifier_block *nfb, unsigned long action,
 
 static int cnmips_cu2_setup(void)
 {
-	return cu2_notifier(cnmips_cu2_call);
+	return cu2_notifier(cnmips_cu2_call, 0);
 }
 early_initcall(cnmips_cu2_setup);
-- 
1.7.1.1
