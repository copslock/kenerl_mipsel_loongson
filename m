Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2011 00:25:01 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12489 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491071Ab1ASXY6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jan 2011 00:24:58 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3772f60000>; Wed, 19 Jan 2011 15:25:42 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 19 Jan 2011 15:24:53 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 19 Jan 2011 15:24:53 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0JNOltj028803;
        Wed, 19 Jan 2011 15:24:48 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0JNOivj028802;
        Wed, 19 Jan 2011 15:24:44 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Add an unreachable return statement to satisfy buggy GCCs.
Date:   Wed, 19 Jan 2011 15:24:42 -0800
Message-Id: <1295479482-28769-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 19 Jan 2011 23:24:53.0742 (UTC) FILETIME=[13A088E0:01CBB830]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

It was reported that GCC-4.3.3 (with CodeSourcery extensions) fails
without this.

Reported-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 083d341..04f9e17 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -109,6 +109,8 @@ static bool scratchpad_available(void)
 static int scratchpad_offset(int i)
 {
 	BUG();
+	/* Really unreachable, but evidently some GCC want this. */
+	return 0;
 }
 #endif
 /*
-- 
1.7.2.3
