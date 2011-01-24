Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 23:53:29 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7315 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491115Ab1AXWv5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 23:51:57 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3e02bd0000>; Mon, 24 Jan 2011 14:52:45 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:56 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:56 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0OMpkkQ023359;
        Mon, 24 Jan 2011 14:51:46 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0OMpjp7023357;
        Mon, 24 Jan 2011 14:51:45 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/4] MIPS: Fix GCC-4.6 'set but not used' warning in signal*.c
Date:   Mon, 24 Jan 2011 14:51:34 -0800
Message-Id: <1295909497-23317-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295909497-23317-1-git-send-email-ddaney@caviumnetworks.com>
References: <1295909497-23317-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jan 2011 22:51:56.0221 (UTC) FILETIME=[4CFF86D0:01CBBC19]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

GCC-4.6 can find more unused code than previous versions could.

In the case of protected_restore_fp_context{,32}, the variable tmp is
really used.  Its use is tricky in that we really care about the side
effects of the __put_user() calls.  So we must mark tmp with
__maybe_unused to quiet the warning.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/signal.c   |    2 +-
 arch/mips/kernel/signal32.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 5922342..dbbe0ce 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -84,7 +84,7 @@ static int protected_save_fp_context(struct sigcontext __user *sc)
 
 static int protected_restore_fp_context(struct sigcontext __user *sc)
 {
-	int err, tmp;
+	int err, tmp __maybe_unused;
 	while (1) {
 		lock_fpu_owner();
 		own_fpu_inatomic(0);
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index a0ed0e0..aae9866 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -115,7 +115,7 @@ static int protected_save_fp_context32(struct sigcontext32 __user *sc)
 
 static int protected_restore_fp_context32(struct sigcontext32 __user *sc)
 {
-	int err, tmp;
+	int err, tmp __maybe_unused;
 	while (1) {
 		lock_fpu_owner();
 		own_fpu_inatomic(0);
-- 
1.7.2.3
