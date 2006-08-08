Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 13:49:24 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:54711 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041137AbWHHMtS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Aug 2006 13:49:18 +0100
Received: by nf-out-0910.google.com with SMTP id o60so240934nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Aug 2006 05:49:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aUv/m5p+4wNnS9C2jjEbKxlr0rh9ZBSmGzM8GoSjIx7C3tzhJ4Murej14sIDeTiK3StC5id1JnK1nAfAeSyZ9RrX/zS8sbf6lxcUEE8k6ie+uiZADpdpv7esKTJq2iYbjXLEdsvn6hb89/xAHpZkhS3y/QMBxcAYKylcKqrMUIc=
Received: by 10.48.48.15 with SMTP id v15mr400699nfv;
        Tue, 08 Aug 2006 05:49:15 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id k24sm761650nfc.2006.08.08.05.49.13;
        Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 5D18B23F770; Tue,  8 Aug 2006 14:48:33 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 4/6] setup.c: do not inline functions
Date:	Tue,  8 Aug 2006 14:48:30 +0200
Message-Id: <11550413133668-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

There's no point to inline any functions in setup.c. Let's GCC
doing its job, it's good enough for that now.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 49a466c..47395dd 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -135,7 +135,7 @@ static void __init print_memory_map(void
 	}
 }
 
-static inline void parse_cmdline_early(void)
+static void __init parse_cmdline_early(void)
 {
 	char c = ' ', *to = command_line, *from = saved_command_line;
 	unsigned long start_at, mem_size;
@@ -477,7 +477,7 @@ static void __init arch_mem_init(char **
 #define MAXMEM		HIGHMEM_START
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 
-static inline void resource_init(void)
+static void __init resource_init(void)
 {
 	int i;
 
-- 
1.4.2.rc2
