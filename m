Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 13:49:49 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:54711 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041138AbWHHMtT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Aug 2006 13:49:19 +0100
Received: by nf-out-0910.google.com with SMTP id o60so240934nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Aug 2006 05:49:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G4ui0g16ez+nSy7jYNaA/f2hqzA4nJZI91R4oczn7aALJQRq6qON7zKZXiHaagcKh3zkjmNxrXMO4/O7FigUKMLppfPj06PGKF6nrqAVzQouCXJA/3i9ljQ8dL13a+Av8EaOmuZOsuWFQSiBw2gnP7vZ9M94Vn6aeQL/BfS0jo4=
Received: by 10.49.75.2 with SMTP id c2mr559674nfl;
        Tue, 08 Aug 2006 05:49:16 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id c28sm769589nfb.2006.08.08.05.49.15;
        Tue, 08 Aug 2006 05:49:16 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id A5C4223F773; Tue,  8 Aug 2006 14:48:33 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 5/6] setup.c: remove MAXMEM macro
Date:	Tue,  8 Aug 2006 14:48:31 +0200
Message-Id: <1155041313268-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12233
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
index 47395dd..e835737 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -474,9 +474,6 @@ static void __init arch_mem_init(char **
 	paging_init();
 }
 
-#define MAXMEM		HIGHMEM_START
-#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
-
 static void __init resource_init(void)
 {
 	int i;
@@ -498,10 +495,10 @@ static void __init resource_init(void)
 
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
@@ -530,9 +527,6 @@ static void __init resource_init(void)
 	}
 }
 
-#undef MAXMEM
-#undef MAXMEM_PFN
-
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
-- 
1.4.2.rc2
