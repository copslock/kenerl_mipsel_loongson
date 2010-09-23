Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2010 20:23:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17273 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab0IWSXj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Sep 2010 20:23:39 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9b9b480000>; Thu, 23 Sep 2010 11:24:08 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 11:23:35 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 11:23:35 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o8NINXah012866;
        Thu, 23 Sep 2010 11:23:33 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o8NINV3g012865;
        Thu, 23 Sep 2010 11:23:32 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Don't place cu2 notifiers in __cpuinitdata
Date:   Thu, 23 Sep 2010 11:23:29 -0700
Message-Id: <1285266209-12822-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
X-OriginalArrivalTime: 23 Sep 2010 18:23:35.0651 (UTC) FILETIME=[6F804330:01CB5B4C]
X-archive-position: 27803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18554

The notifiers may be called at any time, so the notifier_block cannot
be in init memory.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cop2.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/cop2.h b/arch/mips/include/asm/cop2.h
index 2cb2f0c..3532e2c 100644
--- a/arch/mips/include/asm/cop2.h
+++ b/arch/mips/include/asm/cop2.h
@@ -24,7 +24,7 @@ extern int cu2_notifier_call_chain(unsigned long val, void *v);
 
 #define cu2_notifier(fn, pri)						\
 ({									\
-	static struct notifier_block fn##_nb __cpuinitdata = {		\
+	static struct notifier_block fn##_nb = {			\
 		.notifier_call = fn,					\
 		.priority = pri						\
 	};								\
-- 
1.7.2.2
