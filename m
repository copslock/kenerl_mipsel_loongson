Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 16:54:48 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.207]:57172 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20044814AbWHKPwj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 16:52:39 +0100
Received: by nz-out-0102.google.com with SMTP id i1so238194nzh
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 08:52:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qHv3VkOqEyFS5HesuvPvzDDCf90AZC98SdaSP1ZP9ClYFNAz2vU6IgA8vpTgWz/i88STRDozPo09q4tg+BWZtwv2ITsNywu6KPIjV1UoowVosm87AVMcFoWXhz1ToQHDqH0ROF7oM9n3X3cSZK1p99c9bPlTxjGY5MqV2RUzGC8=
Received: by 10.65.119.14 with SMTP id w14mr4246857qbm;
        Fri, 11 Aug 2006 08:52:35 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id q15sm1010060qbq.2006.08.11.08.52.33;
        Fri, 11 Aug 2006 08:52:35 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id EB11823F773; Fri, 11 Aug 2006 17:51:53 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 5/6] setup.c: remove MAXMEM macro
Date:	Fri, 11 Aug 2006 17:51:52 +0200
Message-Id: <11553115132635-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc4
In-Reply-To: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
References: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

It doens't improve readability.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/setup.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 0c6c5a3..fad28a6 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -473,9 +473,6 @@ static void __init arch_mem_init(char **
 	paging_init();
 }
 
-#define MAXMEM		HIGHMEM_START
-#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
-
 static void __init resource_init(void)
 {
 	int i;
@@ -497,10 +494,10 @@ static void __init resource_init(void)
 
 		start = boot_mem_map.map[i].addr;
 		end = boot_mem_map.map[i].addr + boot_mem_map.map[i].size - 1;
-		if (start >= MAXMEM)
+		if (start >= HIGHMEM_START)
 			continue;
-		if (end >= MAXMEM)
-			end = MAXMEM - 1;
+		if (end >= HIGHMEM_START)
+			end = HIGHMEM_START - 1;
 
 		res = alloc_bootmem(sizeof(struct resource));
 		switch (boot_mem_map.map[i].type) {
@@ -529,9 +526,6 @@ static void __init resource_init(void)
 	}
 }
 
-#undef MAXMEM
-#undef MAXMEM_PFN
-
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
-- 
1.4.2.rc4
