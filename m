Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:28:47 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:36274 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993124AbeAESZaDN1ms (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 19:25:30 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v6 08/15] MIPS: ingenic: Use common cmdline handling code
Date:   Fri,  5 Jan 2018 19:25:06 +0100
Message-Id: <20180105182513.16248-9-paul@crapouillou.net>
In-Reply-To: <20180105182513.16248-1-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1515176729; bh=5GxbwsavkX0KvzVpO97lxpoJvB1PkkwbSpv1HsKUF8A=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r2O0IV39SKdp7jUEQVHMTcY23X+JeFutp49BcvW+oswBSVOud91l0SIkbljpmnq+xr8hFfs0nG9IggPTAN4eB6QPsSjSExqAq55ITpZoo2ww5+JA1RNiefWMsYbuthEOXnQbcq19KBpckZxRARqte0Z48h5eQm1iQjkWxTgkDXk=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Paul Burton <paul.burton@mips.com>

jz4740_init_cmdline appends all arguments from argv (in fw_arg1) to
arcs_cmdline, up to argc (in fw_arg0). The common code in
fw_init_cmdline will do the exact same thing when run on a system where
fw_arg0 isn't a pointer to kseg0 (it'll also set _fw_envp but we don't
use it). Remove the custom implementation & use the generic code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/jz4740/prom.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

 v2: No change
 v3: No change
 v4: No change
 v5: No change
 v6: Update Paul Burton's email address

diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index 47e857194ce6..a62dd8e6ecf9 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -20,33 +20,13 @@
 #include <linux/serial_reg.h>
 
 #include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-jz4740/base.h>
 
-static __init void jz4740_init_cmdline(int argc, char *argv[])
-{
-	unsigned int count = COMMAND_LINE_SIZE - 1;
-	int i;
-	char *dst = &(arcs_cmdline[0]);
-	char *src;
-
-	for (i = 1; i < argc && count; ++i) {
-		src = argv[i];
-		while (*src && count) {
-			*dst++ = *src++;
-			--count;
-		}
-		*dst++ = ' ';
-	}
-	if (i > 1)
-		--dst;
-
-	*dst = 0;
-}
-
 void __init prom_init(void)
 {
-	jz4740_init_cmdline((int)fw_arg0, (char **)fw_arg1);
 	mips_machtype = MACH_INGENIC_JZ4740;
+	fw_init_cmdline();
 }
 
 void __init prom_free_prom_memory(void)
-- 
2.11.0
