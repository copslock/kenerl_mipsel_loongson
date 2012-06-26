Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:59:06 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55035 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903795Ab2FZEvx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:51:53 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbP-0002zj-JF; Mon, 25 Jun 2012 23:42:11 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 15/33] MIPS: Lasat: Cleanup firmware support for the Lasat platform.
Date:   Mon, 25 Jun 2012 23:41:30 -0500
Message-Id: <1340685708-14408-16-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/lasat/prom.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
index 20fde19..8bd3994 100644
--- a/arch/mips/lasat/prom.c
+++ b/arch/mips/lasat/prom.c
@@ -9,7 +9,7 @@
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <linux/ioport.h>
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/lasat/lasat.h>
 #include <asm/cpu.h>
 
@@ -81,9 +81,6 @@ static struct at93c_defs at93c_defs[N_MACHTYPES] = {
 
 void __init prom_init(void)
 {
-	int argc = fw_arg0;
-	char **argv = (char **) fw_arg1;
-
 	setup_prom_vectors();
 
 	if (IS_LASAT_200()) {
@@ -98,11 +95,7 @@ void __init prom_init(void)
 
 	lasat_init_board_info();		/* Read info from EEPROM */
 
-	/* Get the command line */
-	if (argc > 0) {
-		strncpy(arcs_cmdline, argv[0], COMMAND_LINE_SIZE-1);
-		arcs_cmdline[COMMAND_LINE_SIZE-1] = '\0';
-	}
+	fw_init_cmdline();
 
 	/* Set the I/O base address */
 	set_io_port_base(KSEG1);
-- 
1.7.10.3
