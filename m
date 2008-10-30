Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 11:15:34 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:17150 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S22721846AbYJ3LO5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 11:14:57 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m9UBEmet002655;
	Thu, 30 Oct 2008 04:14:48 -0700 (PDT)
Received: from localhost.localdomain ([128.224.162.71]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 30 Oct 2008 04:14:47 -0700
From:	Tiejun Chen <tiejun.chen@windriver.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Tiejun Chen <tiejun.chen@windriver.com>
Subject: [PATCH] Reserve stack/heap area for RP program
Date:	Thu, 30 Oct 2008 19:15:45 +0800
Message-Id: <1225365345-15635-2-git-send-email-tiejun.chen@windriver.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1225365345-15635-1-git-send-email-tiejun.chen@windriver.com>
References: <1225365345-15635-1-git-send-email-tiejun.chen@windriver.com>
X-OriginalArrivalTime: 30 Oct 2008 11:14:48.0029 (UTC) FILETIME=[B85FF0D0:01C93A80]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

When you want to run a program on RP it's necessary to reserve corresponding stack/heap
area of that program.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/mips/mti-malta/malta-memory.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 61888ff..d8c0834 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -87,6 +87,19 @@ static struct prom_pmemblock * __init prom_getmdesc(void)
 	else
 		memsize = physical_memsize;
 
+#ifdef CONFIG_MIPS_VPE_LOADER
+	/*
+         * The default DFLT_STACK_SIZE and DFLT_HEAP_SIZE will be known 
+         * from sde-kit. Actually it should define according to the different RP
+         * application. In the future we might want to improve it.
+         */
+#define DFLT_STACK_SIZE (65536)
+#define DFLT_HEAP_SIZE  (1048576) 
+        /* Reserve area used by building stack and heap for running RP. 
+         */
+        memsize -= (DFLT_HEAP_SIZE + DFLT_STACK_SIZE + PAGE_SIZE);
+#endif
+
 	memset(mdesc, 0, sizeof(mdesc));
 
 	mdesc[0].type = yamon_dontuse;
-- 
1.5.5.1
