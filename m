Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 22:36:54 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:46328 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224895AbUJRVgt>; Mon, 18 Oct 2004 22:36:49 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP id EBE7C18596
	for <linux-mips@linux-mips.org>; Mon, 18 Oct 2004 14:36:47 -0700 (PDT)
Message-ID: <4174376F.9050605@mvista.com>
Date: Mon, 18 Oct 2004 14:36:47 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [PATCH]Support for MTD on MIPS Malta
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

Attached patch implements support for MTD on the MIPS Malta. Please review

Thanks
Manish Lachwani

Index: linux/arch/mips/mips-boards/malta/malta_setup.c
===================================================================
--- linux.orig/arch/mips/mips-boards/malta/malta_setup.c
+++ linux/arch/mips/mips-boards/malta/malta_setup.c
@@ -22,6 +22,11 @@
 #include <linux/pci.h>
 #include <linux/tty.h>
 
+#ifdef CONFIG_MTD
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#endif
+
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
@@ -53,6 +58,30 @@
        { "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
 };
 
+#ifdef CONFIG_MTD
+static struct mtd_partition malta_mtd_partitions[] = {
+       {
+               .name =         "YAMON",
+               .offset =       0x0,
+               .size =         0x100000,
+               .mask_flags =   MTD_WRITEABLE
+       },
+       {
+               .name =         "User FS",
+               .offset =       0x100000,
+               .size =         0x2e0000
+       },
+       {
+               .name =         "Board Config",
+               .offset =       0x3e0000,
+               .size =         0x020000,
+               .mask_flags =   MTD_WRITEABLE
+       }
+};
+
+#define number_partitions      
(sizeof(malta_mtd_partitions)/sizeof(struct mtd_partition))
+#endif
+
 const char *get_system_type(void)
 {
        return "MIPS Malta";
@@ -179,6 +208,15 @@
        };
 #endif
 #endif
+
+#ifdef CONFIG_MTD
+       /*
+        * Support for MTD on Malta. Use the generic physmap driver
+        */
+       physmap_configure(0x1e000000, 0x400000, 4, NULL);
+       physmap_set_partitions(malta_mtd_partitions, number_partitions);
+#endif
+
        mips_reboot_setup();
 
        board_time_init = mips_time_init;
