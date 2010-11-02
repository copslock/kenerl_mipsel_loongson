Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2010 01:43:53 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14688 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491758Ab0KBAnZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Nov 2010 01:43:25 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ccf5ed00000>; Mon, 01 Nov 2010 17:44:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 1 Nov 2010 17:43:55 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 1 Nov 2010 17:43:55 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oA20hJQq026849;
        Mon, 1 Nov 2010 17:43:19 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oA20hIPD026848;
        Mon, 1 Nov 2010 17:43:18 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Camm Maguire <camm@maguirefamily.org>
Subject: [PATCH 2/2] MIPS: Don't clobber personality bits in 32-bit sys_personality().
Date:   Mon,  1 Nov 2010 17:43:08 -0700
Message-Id: <1288658588-26801-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288658588-26801-1-git-send-email-ddaney@caviumnetworks.com>
References: <1288658588-26801-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 02 Nov 2010 00:43:55.0917 (UTC) FILETIME=[078CC3D0:01CB7A27]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

If PER_LINUX32 has been set on a 32-bit kernel, only twiddle with the
low-order personality bits, let the upper bits pass through.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Camm Maguire <camm@maguirefamily.org>
---
 arch/mips/kernel/linux32.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 6343b4a..a63f4e2 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -252,13 +252,13 @@ SYSCALL_DEFINE5(n32_msgrcv, int, msqid, u32, msgp, size_t, msgsz,
 SYSCALL_DEFINE1(32_personality, unsigned long, personality)
 {
 	int ret;
-	personality &= 0xffffffff;
+	unsigned int p = personality & 0xffffffff;
 	if (personality(current->personality) == PER_LINUX32 &&
-	    personality == PER_LINUX)
-		personality = PER_LINUX32;
-	ret = sys_personality(personality);
-	if (ret == PER_LINUX32)
-		ret = PER_LINUX;
+	    personality(p) == PER_LINUX)
+		p = (p & ~PER_MASK) | PER_LINUX32;
+	ret = sys_personality(p);
+	if (ret != -1 && personality(ret) == PER_LINUX32)
+		ret = (ret & ~PER_MASK) | PER_LINUX;
 	return ret;
 }
 
-- 
1.7.2.3
