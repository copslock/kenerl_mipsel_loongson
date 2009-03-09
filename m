Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 01:42:03 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:39113 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20808720AbZCIBmA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2009 01:42:00 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n291fqBR003540;
	Sun, 8 Mar 2009 18:41:52 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 8 Mar 2009 18:41:52 -0700
Received: from localhost.localdomain ([128.224.158.187]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 8 Mar 2009 18:41:51 -0700
From:	Xiaotian Feng <Xiaotian.Feng@windriver.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [PATCH V1] mips: fix mips syscall wrapper sys_32_ipc bug
Date:	Mon,  9 Mar 2009 09:45:12 +0800
Message-Id: <1236563112-24287-1-git-send-email-Xiaotian.Feng@windriver.com>
X-Mailer: git-send-email 1.5.5.1
X-OriginalArrivalTime: 09 Mar 2009 01:41:51.0997 (UTC) FILETIME=[385D3AD0:01C9A058]
Return-Path: <Xiaotian.Feng@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Xiaotian.Feng@windriver.com
Precedence: bulk
X-list: linux-mips

There's a typo in mips syscall wrapper sys_32_ipc. If CONFIG_SYSVIPC
is not set, it will cause mips linux compile error.

Signed-off-by: Xiaotian Feng <xiaotian.feng@windriver.com>
---
 arch/mips/kernel/linux32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 2f8452b..1a86f84 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -235,7 +235,7 @@ SYSCALL_DEFINE6(32_ipc, u32, call, long, first, long, second, long, third,
 #else
 
 SYSCALL_DEFINE6(32_ipc, u32, call, int, first, int, second, int, third,
-	u32, ptr, u32 fifth)
+	u32, ptr, u32, fifth)
 {
 	return -ENOSYS;
 }
-- 
1.5.5.1
