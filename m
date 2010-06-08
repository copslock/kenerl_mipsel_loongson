Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jun 2010 19:06:11 +0200 (CEST)
Received: from waldemar-brodkorb.de ([81.169.141.189]:6022 "EHLO
        helium.waldemar-brodkorb.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491962Ab0FHRGH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Jun 2010 19:06:07 +0200
Received: by helium.waldemar-brodkorb.de (Postfix, from userid 1000)
        id 6FE588B90F; Tue,  8 Jun 2010 19:06:01 +0200 (CEST)
Date:   Tue, 8 Jun 2010 19:06:01 +0200
From:   Waldemar Brodkorb <mips@waldemar-brodkorb.de>
To:     linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: Add NVRAM support for bcm47xx devices
Message-ID: <20100608170601.GA8537@waldemar-brodkorb.de>
Reply-To: Waldemar Brodkorb <mips@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: OpenBSD 4.5 amd64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@waldemar-brodkorb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5721

When trying to netboot a Linksys WRT54GS WLAN router, the bootup fails,
because of following error message:

...
[    0.424000] b44: b44.c:v2.0
[    0.424000] b44: Invalid MAC address found in EEPROM
[    0.432000] b44 ssb0:1: Problem fetching invariants of chip,aborting
[    0.436000] b44: probe of ssb0:1 failed with error -22
...

The router uses a CFE bootloader, but most of the needed environment
variables for network card initialization, are not available from CFE
via printenv and even though not via cfe_getenv().
The required environment variables are saved in a special partition
in flash memory. The attached patch implement nvram_getenv and enables
bootup via NFS root on my router.

Most of the patch is extracted from the OpenWrt subversion repository and
stripped down and cleaned up to just fix this issue.

Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
Reviewed-by: Phil Sutter <phil@nwl.cc>
---
 arch/mips/bcm47xx/Makefile                 |    2 +-
 arch/mips/bcm47xx/nvram.c                  |  100 ++++++++++++++++++++++++++++
 arch/mips/bcm47xx/setup.c                  |   39 ++++++++----
 arch/mips/include/asm/mach-bcm47xx/nvram.h |   34 ++++++++++
 4 files changed, 162 insertions(+), 13 deletions(-)
 create mode 100644 arch/mips/bcm47xx/nvram.c
 create mode 100644 arch/mips/include/asm/mach-bcm47xx/nvram.h

diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index 35294b1..7465e8a 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,4 +3,4 @@
 # under Linux.
 #
 
-obj-y := gpio.o irq.o prom.o serial.o setup.o time.o wgt634u.o
+obj-y := gpio.o irq.o nvram.o prom.o serial.o setup.o time.o wgt634u.o
diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
new file mode 100644
index 0000000..74b2b44
--- /dev/null
+++ b/arch/mips/bcm47xx/nvram.c
@@ -0,0 +1,100 @@
+/*
+ * BCM947xx nvram variable access
+ *
+ * Copyright (C) 2005 Broadcom Corporation
+ * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ssb/ssb.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <asm/byteorder.h>
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/mach-bcm47xx/nvram.h>
+#include <asm/mach-bcm47xx/bcm47xx.h>
+
+static char nvram_buf[NVRAM_SPACE];
+
+/* Probe for NVRAM header */
+static void __init early_nvram_init(void)
+{
+	struct ssb_mipscore *mcore = &ssb_bcm47xx.mipscore;
+	struct nvram_header *header;
+	int i;
+	u32 base, lim, off;
+	u32 *src, *dst;
+
+	base = mcore->flash_window;
+	lim = mcore->flash_window_size;
+
+	off = FLASH_MIN;
+	while (off <= lim) {
+		/* Windowed flash access */
+		header = (struct nvram_header *)
+			KSEG1ADDR(base + off - NVRAM_SPACE);
+		if (header->magic == NVRAM_HEADER)
+			goto found;
+		off <<= 1;
+	}
+
+	/* Try embedded NVRAM at 4 KB and 1 KB as last resorts */
+	header = (struct nvram_header *) KSEG1ADDR(base + 4096);
+	if (header->magic == NVRAM_HEADER)
+		goto found;
+
+	header = (struct nvram_header *) KSEG1ADDR(base + 1024);
+	if (header->magic == NVRAM_HEADER)
+		goto found;
+
+	return;
+
+found:
+	src = (u32 *) header;
+	dst = (u32 *) nvram_buf;
+	for (i = 0; i < sizeof(struct nvram_header); i += 4)
+		*dst++ = *src++;
+	for (; i < header->len && i < NVRAM_SPACE; i += 4)
+		*dst++ = le32_to_cpu(*src++);
+}
+
+int nvram_getenv(char *name, char *val, size_t val_len)
+{
+	char *var, *value, *end, *eq;
+
+	if (!name)
+		return 1;
+
+	if (!nvram_buf[0])
+		early_nvram_init();
+
+	/* Look for name=value and return value */
+	var = &nvram_buf[sizeof(struct nvram_header)];
+	end = nvram_buf + sizeof(nvram_buf) - 2;
+	end[0] = end[1] = '\0';
+	for (; *var; var = value + strlen(value) + 1) {
+		eq = strchr(var, '=');
+		if (!eq)
+			break;
+		value = eq + 1;
+		if ((eq - var) == strlen(name) &&
+			strncmp(var, name, (eq - var)) == 0) {
+			snprintf(val, val_len, "%s", value);
+			return 0;
+		}
+	}
+	return 1;
+}
+EXPORT_SYMBOL(nvram_getenv);
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index d442e11..b1aee33 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -1,8 +1,8 @@
 /*
  *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
- *  Copyright (C) 2005 Waldemar Brodkorb <wbx@openwrt.org>
  *  Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
  *  Copyright (C) 2006 Michael Buesch <mb@bu3sch.de>
+ *  Copyright (C) 2010 Waldemar Brodkorb <wbx@openadk.org>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -33,6 +33,7 @@
 #include <asm/time.h>
 #include <bcm47xx.h>
 #include <asm/fw/cfe/cfe_api.h>
+#include <asm/mach-bcm47xx/nvram.h>
 
 struct ssb_bus ssb_bcm47xx;
 EXPORT_SYMBOL(ssb_bcm47xx);
@@ -81,28 +82,42 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	/* Fill boardinfo structure */
 	memset(&(iv->boardinfo), 0 , sizeof(struct ssb_boardinfo));
 
-	if (cfe_getenv("boardvendor", buf, sizeof(buf)) >= 0)
+	if (cfe_getenv("boardvendor", buf, sizeof(buf)) >= 0 ||
+	    nvram_getenv("boardvendor", buf, sizeof(buf)) >= 0)
 		iv->boardinfo.type = (u16)simple_strtoul(buf, NULL, 0);
-	if (cfe_getenv("boardtype", buf, sizeof(buf)) >= 0)
+	if (cfe_getenv("boardtype", buf, sizeof(buf)) >= 0 ||
+	    nvram_getenv("boardtype", buf, sizeof(buf)) >= 0)
 		iv->boardinfo.type = (u16)simple_strtoul(buf, NULL, 0);
-	if (cfe_getenv("boardrev", buf, sizeof(buf)) >= 0)
+	if (cfe_getenv("boardrev", buf, sizeof(buf)) >= 0 ||
+	    nvram_getenv("boardrev", buf, sizeof(buf)) >= 0)
 		iv->boardinfo.rev = (u16)simple_strtoul(buf, NULL, 0);
 
 	/* Fill sprom structure */
 	memset(&(iv->sprom), 0, sizeof(struct ssb_sprom));
 	iv->sprom.revision = 3;
 
-	if (cfe_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
+	if (cfe_getenv("et0macaddr", buf, sizeof(buf)) >= 0 ||
+	    nvram_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
 		str2eaddr(buf, iv->sprom.et0mac);
-	if (cfe_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
+
+	if (cfe_getenv("et1macaddr", buf, sizeof(buf)) >= 0 ||
+	    nvram_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
 		str2eaddr(buf, iv->sprom.et1mac);
-	if (cfe_getenv("et0phyaddr", buf, sizeof(buf)) >= 0)
-		iv->sprom.et0phyaddr = simple_strtoul(buf, NULL, 10);
-	if (cfe_getenv("et1phyaddr", buf, sizeof(buf)) >= 0)
-		iv->sprom.et1phyaddr = simple_strtoul(buf, NULL, 10);
-	if (cfe_getenv("et0mdcport", buf, sizeof(buf)) >= 0)
+
+	if (cfe_getenv("et0phyaddr", buf, sizeof(buf)) >= 0 ||
+	    nvram_getenv("et0phyaddr", buf, sizeof(buf)) >= 0)
+		iv->sprom.et0phyaddr = simple_strtoul(buf, NULL, 0);
+
+	if (cfe_getenv("et1phyaddr", buf, sizeof(buf)) >= 0 ||
+	    nvram_getenv("et1phyaddr", buf, sizeof(buf)) >= 0)
+		iv->sprom.et1phyaddr = simple_strtoul(buf, NULL, 0);
+
+	if (cfe_getenv("et0mdcport", buf, sizeof(buf)) >= 0 ||
+	    nvram_getenv("et0mdcport", buf, sizeof(buf)) >= 0)
 		iv->sprom.et0mdcport = simple_strtoul(buf, NULL, 10);
-	if (cfe_getenv("et1mdcport", buf, sizeof(buf)) >= 0)
+
+	if (cfe_getenv("et1mdcport", buf, sizeof(buf)) >= 0 ||
+	    nvram_getenv("et1mdcport", buf, sizeof(buf)) >= 0)
 		iv->sprom.et1mdcport = simple_strtoul(buf, NULL, 10);
 
 	return 0;
diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h b/arch/mips/include/asm/mach-bcm47xx/nvram.h
new file mode 100644
index 0000000..b8b5fe8
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm47xx/nvram.h
@@ -0,0 +1,34 @@
+/*
+ *  Copyright (C) 2005, Broadcom Corporation
+ *  Copyright (C) 2006, Felix Fietkau <nbd@openwrt.org>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef __NVRAM_H
+#define __NVRAM_H
+
+struct nvram_header {
+	u32 magic;
+	u32 len;
+	u32 crc_ver_init;	/* 0:7 crc, 8:15 ver, 16:31 sdram_init */
+	u32 config_refresh;	/* 0:15 sdram_config, 16:31 sdram_refresh */
+	u32 config_ncdl;	/* ncdl values for memc */
+};
+
+#define NVRAM_HEADER		0x48534C46	/* 'FLSH' */
+#define NVRAM_VERSION		1
+#define NVRAM_HEADER_SIZE	20
+#define NVRAM_SPACE		0x8000
+
+#define FLASH_MIN		0x00020000	/* Minimum flash size */
+
+#define NVRAM_MAX_VALUE_LEN 255
+#define NVRAM_MAX_PARAM_LEN 64
+
+int nvram_getenv(char *name, char *val, size_t val_len);
+
+#endif
-- 
1.7.0.4
