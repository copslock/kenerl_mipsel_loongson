Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:26:11 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1468 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903714Ab2GMQYd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 18:24:33 +0200
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 09:23:31 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 09:23:35 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 460B89F9F5; Fri, 13
 Jul 2012 09:24:15 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server id
 14.1.339.1; Fri, 13 Jul 2012 09:24:14 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 03/12] MIPS: Netlogic: merge of.c into setup.c
Date:   Fri, 13 Jul 2012 21:53:16 +0530
Message-ID: <1342196605-4260-4-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 7C1E94093MK9921388-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
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

Move the function device_tree_init() from netlogic/xlp/of.c
to setup.c, and remove the wrapper functions reserve_mem_mach()
and free_mem_mach().

Remove file netlogic/xlp/of.c, and the Makefile entry for it.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/xlp/Makefile |    1 -
 arch/mips/netlogic/xlp/of.c     |   34 ----------------------------------
 arch/mips/netlogic/xlp/setup.c  |   20 ++++++++++++++++++++
 3 files changed, 20 insertions(+), 35 deletions(-)
 delete mode 100644 arch/mips/netlogic/xlp/of.c

diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index 6b4b972..5bd24b6 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,4 +1,3 @@
 obj-y				+= setup.o platform.o nlm_hal.o
-obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_SMP)		+= wakeup.o
 obj-$(CONFIG_USB)		+= usb-init.o
diff --git a/arch/mips/netlogic/xlp/of.c b/arch/mips/netlogic/xlp/of.c
deleted file mode 100644
index 8e3921c..0000000
--- a/arch/mips/netlogic/xlp/of.c
+++ /dev/null
@@ -1,34 +0,0 @@
-#include <linux/bootmem.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/of_fdt.h>
-#include <asm/byteorder.h>
-
-static int __init reserve_mem_mach(unsigned long addr, unsigned long size)
-{
-	return reserve_bootmem(addr, size, BOOTMEM_DEFAULT);
-}
-
-void __init free_mem_mach(unsigned long addr, unsigned long size)
-{
-	return free_bootmem(addr, size);
-}
-
-void __init device_tree_init(void)
-{
-	unsigned long base, size;
-
-	if (!initial_boot_params)
-		return;
-
-	base = virt_to_phys((void *)initial_boot_params);
-	size = be32_to_cpu(initial_boot_params->totalsize);
-
-	/* Before we do anything, lets reserve the dt blob */
-	reserve_mem_mach(base, size);
-
-	unflatten_device_tree();
-
-	/* free the space reserved for the dt blob */
-	free_mem_mach(base, size);
-}
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 3dec9f2..0d2d679 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -35,6 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/serial_8250.h>
 #include <linux/pm.h>
+#include <linux/bootmem.h>
 
 #include <asm/reboot.h>
 #include <asm/time.h>
@@ -112,6 +113,25 @@ void __init prom_init(void)
 #endif
 }
 
+void __init device_tree_init(void)
+{
+	unsigned long base, size;
+
+	if (!initial_boot_params)
+		return;
+
+	base = virt_to_phys((void *)initial_boot_params);
+	size = be32_to_cpu(initial_boot_params->totalsize);
+
+	/* Before we do anything, lets reserve the dt blob */
+	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
+
+	unflatten_device_tree();
+
+	/* free the space reserved for the dt blob */
+	free_bootmem(base, size);
+}
+
 static struct of_device_id __initdata xlp_ids[] = {
 	{ .compatible = "simple-bus", },
 	{},
-- 
1.7.9.5
