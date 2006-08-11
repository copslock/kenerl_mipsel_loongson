Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 16:52:38 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.206]:18253 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20044810AbWHKPwg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 16:52:36 +0100
Received: by nz-out-0102.google.com with SMTP id i1so238193nzh
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 08:52:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JehtlBeJvTURT4scJpkoh1p1dfzL1CeYBWxKG/TgfyUmvYV7pMwleZsLCKdBZEHRdBqES8ugHIP2tFO+uP6/Q5ifIjK4IghdlHjioWxq7g9CgHRxYs+PJrn2+fIXj6YUBCmDLT8qL7o1DTLAzbOospuVteccqcfP84bHZlNLX5M=
Received: by 10.65.211.16 with SMTP id n16mr4225066qbq;
        Fri, 11 Aug 2006 08:52:31 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id a29sm1559076qbd.2006.08.11.08.52.29;
        Fri, 11 Aug 2006 08:52:31 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id C8EF823F770; Fri, 11 Aug 2006 17:51:53 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 4/6] setup.c: do not inline functions
Date:	Fri, 11 Aug 2006 17:51:51 +0200
Message-Id: <11553115132664-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc4
In-Reply-To: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
References: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12284
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
index 7339f54..0c6c5a3 100644
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
@@ -476,7 +476,7 @@ static void __init arch_mem_init(char **
 #define MAXMEM		HIGHMEM_START
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 
-static inline void resource_init(void)
+static void __init resource_init(void)
 {
 	int i;
 
-- 
1.4.2.rc4
