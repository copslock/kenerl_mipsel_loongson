Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2010 02:12:28 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10095 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492534Ab0EKAMY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 May 2010 02:12:24 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4be8a0f50000>; Mon, 10 May 2010 17:12:37 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 10 May 2010 17:12:16 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 10 May 2010 17:12:16 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o4B0CCIg027581;
        Mon, 10 May 2010 17:12:12 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o4B0CAaN027580;
        Mon, 10 May 2010 17:12:10 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Use compat version for n32 sys_ppoll.
Date:   Mon, 10 May 2010 17:11:54 -0700
Message-Id: <1273536714-27535-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 11 May 2010 00:12:16.0838 (UTC) FILETIME=[9D520E60:01CAF09E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: Chandrakala Chavva <cchavva@caviumnetworks.com>

The sys_ppoll() takes struct 'struct timespec'. This is different
for n32 and n64 abi. Use the compat version to do the proper conversions.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/scall64-n32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 6ebc079..10f3343 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -385,7 +385,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_fchmodat
 	PTR	sys_faccessat
 	PTR	compat_sys_pselect6
-	PTR	sys_ppoll			/* 6265 */
+	PTR	compat_sys_ppoll		/* 6265 */
 	PTR	sys_unshare
 	PTR	sys_splice
 	PTR	sys_sync_file_range
-- 
1.6.6.1
