Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 13:22:59 +0100 (WEST)
Received: from arrakis.dune.hu ([195.56.146.235]:57291 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022027AbZFBMWQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 13:22:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by arrakis.dune.hu (Postfix) with ESMTP id 24EB123C0143
	for <linux-mips@linux-mips.org>; Tue,  2 Jun 2009 14:22:16 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from arrakis.dune.hu ([127.0.0.1])
	by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uuof-Zsj8-4E for <linux-mips@linux-mips.org>;
	Tue,  2 Jun 2009 14:22:14 +0200 (CEST)
Received: by arrakis.dune.hu (Postfix, from userid 1000)
	id 22CA923C013F; Tue,  2 Jun 2009 14:22:14 +0200 (CEST)
From:	Imre Kaloz <kaloz@openwrt.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Honor CONFIG_CMDLINE on SiByte
Date:	Tue,  2 Jun 2009 14:22:14 +0200
Message-Id: <1243945334-5090-1-git-send-email-kaloz@openwrt.org>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <kaloz@arrakis.dune.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaloz@openwrt.org
Precedence: bulk
X-list: linux-mips

The SiByte platform code doesn't honor the CONFIG_CMDLINE kernel
option. This patch fixes this issue.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/sibyte/common/cfe.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index 3de30f7..97e997e 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -293,7 +293,11 @@ void __init prom_init(void)
 			 * It's OK for direct boot to not provide a
 			 *  command line
 			 */
+#ifdef CONFIG_CMDLINE
+			strlcpy(arcs_cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#else
 			strcpy(arcs_cmdline, "root=/dev/ram0 ");
+#endif
 		} else {
 			/* The loader should have set the command line */
 			/* too early for panic to do any good */
-- 
1.6.0.4
