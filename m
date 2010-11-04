Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 23:27:03 +0100 (CET)
Received: from smtp-out-083.synserver.de ([212.40.180.83]:1062 "HELO
        smtp-out-081.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491884Ab0KDW0j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Nov 2010 23:26:39 +0100
Received: (qmail 11349 invoked by uid 0); 4 Nov 2010 22:26:28 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 10773
Received: from c128026.adsl.hansenet.de (HELO localhost.localdomain) [213.39.128.26]
  by 217.119.54.81 with SMTP; 4 Nov 2010 22:26:27 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MIPS: JZ4740: prom: Fix section mismatch
Date:   Thu,  4 Nov 2010 23:25:57 +0100
Message-Id: <1288909557-20088-2-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1288909557-20088-1-git-send-email-lars@metafoo.de>
References: <1288909557-20088-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

This patch fixes the following section mismatch:

	WARNING: arch/mips/built-in.o(.text+0xc): Section mismatch in reference from the
	function jz4740_init_cmdline() to the variable .init.data:arcs_cmdline

While were at it, make jz4740_init_cmdline static as well.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/prom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index cfeac15..4a70407 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -23,7 +23,7 @@
 #include <asm/bootinfo.h>
 #include <asm/mach-jz4740/base.h>
 
-void jz4740_init_cmdline(int argc, char *argv[])
+static __init void jz4740_init_cmdline(int argc, char *argv[])
 {
 	unsigned int count = COMMAND_LINE_SIZE - 1;
 	int i;
-- 
1.5.6.5
