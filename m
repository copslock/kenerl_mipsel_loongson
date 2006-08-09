Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 15:55:14 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:61925 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20042393AbWHIOx1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 15:53:27 +0100
Received: by nf-out-0910.google.com with SMTP id o60so206823nfa
        for <linux-mips@linux-mips.org>; Wed, 09 Aug 2006 07:53:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TCIYrdIvh482O70F+vgnL7prr/ae83rk6a3xOipWwD2LwXvQ1uMpqpFKz8mAuV0xl3mGInUTV3asTJb9OH3qoM2qzq/xbb532DsOuNNx9u8m7R0Iqyb7MUQPB2++VYIdnXcUKiGmVPoujH0J3BeJwMfQoDpXsX9bmLk38v9IDDM=
Received: by 10.48.220.15 with SMTP id s15mr1619186nfg;
        Wed, 09 Aug 2006 07:53:24 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id k23sm2488822nfc.2006.08.09.07.53.23;
        Wed, 09 Aug 2006 07:53:24 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 09DA823F772; Wed,  9 Aug 2006 16:52:39 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 5/6] setup.c: remove MAXMEM macro
Date:	Wed,  9 Aug 2006 16:52:37 +0200
Message-Id: <11551351594099-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
References: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12253
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
index 019b564..895a357 100644
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
