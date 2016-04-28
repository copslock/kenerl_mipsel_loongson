Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 11:03:27 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:51068 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027656AbcD1JD03umKV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Apr 2016 11:03:26 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 1114518151;
        Thu, 28 Apr 2016 11:03:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dXBJAq0Ebahk; Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 587CF180DD;
        Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 3A2291689;
        Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 2F0451688;
        Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: from lnxrabinv.se.axis.com (lnxrabinv.se.axis.com [10.88.144.1])
        by thoth.se.axis.com (Postfix) with ESMTP id 2C145FF2;
        Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: by lnxrabinv.se.axis.com (Postfix, from userid 10564)
        id 1C1D0201DB; Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
From:   Rabin Vincent <rabin.vincent@axis.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Rabin Vincent <rabinv@axis.com>
Subject: [PATCH 1/2] MIPS: don't add leading spacing to command lines
Date:   Thu, 28 Apr 2016 11:03:08 +0200
Message-Id: <1461834189-9122-1-git-send-email-rabin.vincent@axis.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <rabin.vincent@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin.vincent@axis.com
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

From: Rabin Vincent <rabinv@axis.com>

The leading spaces don't affect functionality but are unnecessary.

Signed-off-by: Rabin Vincent <rabinv@axis.com>
---
 arch/mips/kernel/setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4f60734..6a5c6c0 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -657,13 +657,15 @@ static void __init arch_mem_init(char **cmdline_p)
 		strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
 
 	if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
-		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		if (boot_command_line[0])
+			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
 		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
 	}
 
 #if defined(CONFIG_CMDLINE_BOOL)
 	if (builtin_cmdline[0]) {
-		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		if (boot_command_line[0])
+			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
 		strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
 #endif
-- 
2.7.0
