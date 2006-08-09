Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 15:53:28 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:35814 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20042385AbWHIOxZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 15:53:25 +0100
Received: by nf-out-0910.google.com with SMTP id o60so206822nfa
        for <linux-mips@linux-mips.org>; Wed, 09 Aug 2006 07:53:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=roasQ7PdJoYCQ10nu6oEN2LWDE0WaGcHznwrzWpdshmT29OfA9rRCB+Wv98YodAjLY4qEuJkMQNVezAkWfl9Qe7a6tczSb5ExDFDw5mWUU+IhuvXbocEA9OU5jsFPHwqGfIEoiOrkJRB+jyf8RiH0g+LiESv03wXJoYQB1xL4eg=
Received: by 10.49.8.15 with SMTP id l15mr1380018nfi;
        Wed, 09 Aug 2006 07:53:21 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id a23sm544013nfc.2006.08.09.07.53.19;
        Wed, 09 Aug 2006 07:53:20 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id F135C23F770; Wed,  9 Aug 2006 16:52:39 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 4/6] setup.c: do not inline functions
Date:	Wed,  9 Aug 2006 16:52:36 +0200
Message-Id: <11551351592540-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
References: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12249
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
index c73bd80..019b564 100644
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
