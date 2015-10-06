Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 17:47:28 +0200 (CEST)
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:34566 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009534AbbJFPr0nOq5u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Oct 2015 17:47:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4598; q=dns/txt; s=iport;
  t=1444146446; x=1445356046;
  h=from:to:cc:subject:date:message-id;
  bh=T8FffE0iaHXPBqbgnQSO1A0BacsTRxGBRSmm4jNdi4k=;
  b=AgBLvY+jNi+TJ7tQd9VSUoAxNWh+Oz1JDqLK5+vO9j4eg5CSyo1hGuRU
   4j1ZRvIohwjkOuzQGJLfkO+BlQZk7Ct3NVfTjwqnbVEHT1PVj+mDay7Nn
   18WEfeS6oMA7ldftol8QKDhpfn72eUredeklMQpnbcRIDzBc4b9awJ5xp
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A0D9AQBO7BNW/4UNJK1egyeBQroChCIBDYFahhqBODgUAQEBAQEBAYEKhCd4BYE+ARKILr9cAQEBAQEFAgEfC4ZoiguENQWHOIZGiAaNF4FXjzCGeINvHwEBQoIRHYF0HjOIPwEBAQ
X-IronPort-AV: E=Sophos;i="5.17,644,1437436800"; 
   d="scan'208";a="34933741"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by rcdn-iport-4.cisco.com with ESMTP; 06 Oct 2015 15:47:19 +0000
Received: from zorba.cisco.com ([10.21.172.159])
        by alln-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id t96FlEKd028914;
        Tue, 6 Oct 2015 15:47:18 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     xe-kernel@external.cisco.com, Ralf Baechle <ralf@linux-mips.org>
Cc:     Daniel Walker <dwalker@fifo99.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH-RFC 4/7] mips: convert to generic builtin command line
Date:   Tue,  6 Oct 2015 08:47:11 -0700
Message-Id: <1444146434-12776-4-git-send-email-danielwa@cisco.com>
X-Mailer: git-send-email 2.1.4
X-Auto-Response-Suppress: DR, OOF, AutoReply
Return-Path: <danielwa@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danielwa@cisco.com
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

This updates the mips code to use the CONFIG_GENERIC_CMDLINE
option.

Cc: xe-kernel@external.cisco.com
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/mips/Kconfig        |  1 +
 arch/mips/Kconfig.debug  | 47 -----------------------------------------------
 arch/mips/kernel/setup.c | 20 +++-----------------
 3 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0..2b05aeb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -60,6 +60,7 @@ config MIPS
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select GENERIC_CMDLINE
 
 menu "Machine selection"
 
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index e250524..16aab1c 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -32,53 +32,6 @@ config EARLY_PRINTK_8250
 config USE_GENERIC_EARLY_PRINTK_8250
 	bool
 
-config CMDLINE_BOOL
-	bool "Built-in kernel command line"
-	default n
-	help
-	  For most systems, it is firmware or second stage bootloader that
-	  by default specifies the kernel command line options.  However,
-	  it might be necessary or advantageous to either override the
-	  default kernel command line or add a few extra options to it.
-	  For such cases, this option allows you to hardcode your own
-	  command line options directly into the kernel.  For that, you
-	  should choose 'Y' here, and fill in the extra boot arguments
-	  in CONFIG_CMDLINE.
-
-	  The built-in options will be concatenated to the default command
-	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
-	  command line will be ignored and replaced by the built-in string.
-
-	  Most MIPS systems will normally expect 'N' here and rely upon
-	  the command line from the firmware or the second-stage bootloader.
-
-config CMDLINE
-	string "Default kernel command string"
-	depends on CMDLINE_BOOL
-	default ""
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel.  For these platforms, and for the cases
-	  when you want to add some extra options to the command line or ignore
-	  the default command line, you can supply some command-line options at
-	  build time by entering them here.  In other cases you can specify
-	  kernel args so that you don't have to set them up in board prom
-	  initialization routines.
-
-	  For more information, see the CMDLINE_BOOL and CMDLINE_OVERRIDE
-	  options.
-
-config CMDLINE_OVERRIDE
-	bool "Built-in command line overrides firmware arguments"
-	default n
-	depends on CMDLINE_BOOL
-	help
-	  By setting this option to 'Y' you will have your kernel ignore
-	  command line arguments from firmware or second stage bootloader.
-	  Instead, the built-in command line will be used exclusively.
-
-	  Normally, you will choose 'N' here.
-
 config SB1XXX_CORELIS
 	bool "Corelis Debugger"
 	depends on SIBYTE_SB1xxx_SOC
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4795151..de6fc31 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -26,6 +26,7 @@
 #include <linux/sizes.h>
 #include <linux/device.h>
 #include <linux/dma-contiguous.h>
+#include <linux/cmdline.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -67,10 +68,6 @@ struct boot_mem_map boot_mem_map;
 static char __initdata command_line[COMMAND_LINE_SIZE];
 char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
 
-#ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
-#endif
-
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
  * I/O ports are mapped.
@@ -640,19 +637,8 @@ static void __init arch_mem_init(char **cmdline_p)
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if (builtin_cmdline[0]) {
-		strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(arcs_cmdline, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-	strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
-#endif
-#else
-	strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
-#endif
+	cmdline_add_builtin(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
-- 
2.1.4
