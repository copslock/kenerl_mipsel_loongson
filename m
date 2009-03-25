Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 17:04:29 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:35884 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20022077AbZCYREX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 17:04:23 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ca63980000>; Wed, 25 Mar 2009 13:02:21 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Mar 2009 10:01:49 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Mar 2009 10:01:49 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n2PH1jjJ026906;
	Wed, 25 Mar 2009 10:01:45 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n2PH1ibX026905;
	Wed, 25 Mar 2009 10:01:44 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Mask sys_llseek offsets in 32-bit syscalls.
Date:	Wed, 25 Mar 2009 10:01:44 -0700
Message-Id: <1238000504-26881-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 25 Mar 2009 17:01:49.0648 (UTC) FILETIME=[63565D00:01C9AD6B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The o32 user space ABI sign extends the offset values.  We need to
undo this by masking out the high bits.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/linux32.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 49aac6e..13fc173 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -137,7 +137,8 @@ SYSCALL_DEFINE5(32_llseek, unsigned long, fd, unsigned long, offset_high,
 	unsigned long, offset_low, loff_t __user *, result,
 	unsigned long, origin)
 {
-	return sys_llseek(fd, offset_high, offset_low, result, origin);
+	return sys_llseek(fd, offset_high & 0xffffffff,
+			  offset_low & 0xffffffff, result, origin);
 }
 
 /* From the Single Unix Spec: pread & pwrite act like lseek to pos + op +
-- 
1.6.0.6
