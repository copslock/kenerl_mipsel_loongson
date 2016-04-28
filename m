Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 11:03:43 +0200 (CEST)
Received: from bes.se.axis.com ([195.60.68.10]:37482 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027665AbcD1JD0xzu0V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Apr 2016 11:03:26 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 45F752E2D7;
        Thu, 28 Apr 2016 11:03:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0qR+ioBZBMq6; Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 596942E0EC;
        Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 3AA7C168A;
        Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 2EC1D1687;
        Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: from lnxrabinv.se.axis.com (lnxrabinv.se.axis.com [10.88.144.1])
        by thoth.se.axis.com (Postfix) with ESMTP id 2C6CFFFC;
        Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
Received: by lnxrabinv.se.axis.com (Postfix, from userid 10564)
        id 24F362019A; Thu, 28 Apr 2016 11:03:20 +0200 (CEST)
From:   Rabin Vincent <rabin.vincent@axis.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Rabin Vincent <rabinv@axis.com>
Subject: [PATCH 2/2] MIPS: add support for extending builtin cmdline
Date:   Thu, 28 Apr 2016 11:03:09 +0200
Message-Id: <1461834189-9122-2-git-send-email-rabin.vincent@axis.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1461834189-9122-1-git-send-email-rabin.vincent@axis.com>
References: <1461834189-9122-1-git-send-email-rabin.vincent@axis.com>
Return-Path: <rabin.vincent@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53240
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

Allow the builtin command line to be extended by what the bootloader
passes in.  For example, the bootloader can pass specific arguments
depending on the boot mode, and these should override the defaults in
the builtin cmdline.

The default MIPS_CMDLINE_FROM_BOOTLOADER option prepends the
bootloader's cmdline to the builtin cmdline so is not suitable for this
purpose.

Signed-off-by: Rabin Vincent <rabinv@axis.com>
---
 arch/mips/Kconfig        | 4 ++++
 arch/mips/kernel/setup.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2018c2b..e77c518 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2810,6 +2810,10 @@ choice
 
 	config MIPS_CMDLINE_FROM_BOOTLOADER
 		bool "Bootloader kernel arguments if available"
+
+	config MIPS_CMDLINE_BUILTIN_EXTEND
+		depends on CMDLINE_BOOL
+		bool "Extend builtin kernel arguments with bootloader arguments"
 endchoice
 
 endmenu
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 6a5c6c0..10ceb96 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -624,6 +624,8 @@ static void __init request_crashkernel(struct resource *res)
 #define USE_PROM_CMDLINE	IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
 #define USE_DTB_CMDLINE		IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
 #define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND)
+#define BUILTIN_EXTEND_WITH_PROM	\
+	IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
 
 static void __init arch_mem_init(char **cmdline_p)
 {
@@ -668,6 +670,12 @@ static void __init arch_mem_init(char **cmdline_p)
 			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
 		strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
+
+	if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
+		if (boot_command_line[0])
+			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+	}
 #endif
 #endif
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
-- 
2.7.0
