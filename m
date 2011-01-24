Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 23:53:07 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7313 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491112Ab1AXWvy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 23:51:54 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3e02b90001>; Mon, 24 Jan 2011 14:52:41 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0OMpm8o023363;
        Mon, 24 Jan 2011 14:51:48 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0OMplbj023362;
        Mon, 24 Jan 2011 14:51:47 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/4] MIPS: Remove unused code from arch/mips/kernel/syscall.c
Date:   Mon, 24 Jan 2011 14:51:35 -0800
Message-Id: <1295909497-23317-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295909497-23317-1-git-send-email-ddaney@caviumnetworks.com>
References: <1295909497-23317-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jan 2011 22:51:52.0175 (UTC) FILETIME=[4A9627F0:01CBBC19]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The variable arg3 in _sys_sysmips() is unused.  Remove it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/syscall.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 80d753d..0de1402 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -386,12 +386,11 @@ save_static_function(sys_sysmips);
 static int __used noinline
 _sys_sysmips(nabi_no_regargs struct pt_regs regs)
 {
-	long cmd, arg1, arg2, arg3;
+	long cmd, arg1, arg2;
 
 	cmd = regs.regs[4];
 	arg1 = regs.regs[5];
 	arg2 = regs.regs[6];
-	arg3 = regs.regs[7];
 
 	switch (cmd) {
 	case MIPS_ATOMIC_SET:
-- 
1.7.2.3
