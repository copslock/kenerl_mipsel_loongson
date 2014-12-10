Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2014 11:50:13 +0100 (CET)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36099 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006508AbaLJKuLRId7C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2014 11:50:11 +0100
Received: by mail-wg0-f52.google.com with SMTP id x12so3215831wgg.25
        for <multiple recipients>; Wed, 10 Dec 2014 02:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=kjPhM9h/mgfPIOmeQoVEBdSey/Gs6TwwOu98FM+KPok=;
        b=ft3HzYX2uFABSNSxeiCnEr3+Qd65zb+LhU/4MSbBfZgmVQlZ0jAEQUEkajKLzxo2ca
         tBrIGgiHjtkkCAXx+sIIyf9m/QHnetYqQ8i5/X9DkH7ppfql6J+NdwLNiRI+mQshs/rK
         +PGHHznEygJ0hBJwLNwBQs/ULNuRHusV843hiphCVzX65g101nw0Q2hhdsRjgmGkSnCl
         p3/V1a0c5DvZRRfMm991K0dhUFrAyS8B4phLHW5UYO6RS0tkXAhpWMgteqjjbS1IOzzf
         /zaYeFPlsXwD9LMPaM8zEUJ1A/HZIMK05CNZtlnt64Ea1OjXumYPnk0M2rDo1hK/9dCH
         2/Uw==
X-Received: by 10.194.77.38 with SMTP id p6mr5715501wjw.50.1418208606024;
        Wed, 10 Dec 2014 02:50:06 -0800 (PST)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id mc10sm17394697wic.24.2014.12.10.02.50.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 02:50:05 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Paul Walmsley <paul@pwsan.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/3] MIPS: BCM47XX: Fix coding style to match kernel standards
Date:   Wed, 10 Dec 2014 11:49:52 +0100
Message-Id: <1418208594-16235-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/bcm47xx_private.h |  4 ++++
 arch/mips/bcm47xx/board.c           |  3 +--
 arch/mips/bcm47xx/nvram.c           | 25 ++++++++++++++-----------
 arch/mips/bcm47xx/prom.c            |  3 +--
 arch/mips/bcm47xx/serial.c          |  8 ++++----
 arch/mips/bcm47xx/setup.c           | 12 ++++++------
 arch/mips/bcm47xx/sprom.c           |  8 ++++----
 arch/mips/bcm47xx/time.c            |  1 -
 8 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
index ea909a5..41796be 100644
--- a/arch/mips/bcm47xx/bcm47xx_private.h
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -1,6 +1,10 @@
 #ifndef LINUX_BCM47XX_PRIVATE_H_
 #define LINUX_BCM47XX_PRIVATE_H_
 
+#ifndef pr_fmt
+#define pr_fmt(fmt)		"bcm47xx: " fmt
+#endif
+
 #include <linux/kernel.h>
 
 /* prom.c */
diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 6e85130..d4a5a51 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -330,9 +330,8 @@ void __init bcm47xx_board_detect(void)
 	err = bcm47xx_nvram_getenv("boardtype", buf, sizeof(buf));
 
 	/* init of nvram failed, probably too early now */
-	if (err == -ENXIO) {
+	if (err == -ENXIO)
 		return;
-	}
 
 	board_detected = bcm47xx_board_get_nvram();
 	bcm47xx_board.board = board_detected->board;
diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 65da3b0..9e7c909 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -18,8 +18,10 @@
 #include <linux/mtd/mtd.h>
 #include <linux/bcm47xx_nvram.h>
 
-#define NVRAM_MAGIC		0x48534C46	/* 'FLSH' */
-#define NVRAM_SPACE		0x8000
+#define NVRAM_MAGIC			0x48534C46	/* 'FLSH' */
+#define NVRAM_SPACE			0x8000
+#define NVRAM_MAX_GPIO_ENTRIES		32
+#define NVRAM_MAX_GPIO_VALUE_LEN	30
 
 #define FLASH_MIN		0x00020000	/* Minimum flash size */
 
@@ -98,8 +100,8 @@ found:
 		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
 		       header->len, NVRAM_SPACE);
 
-	src = (u32 *) header;
-	dst = (u32 *) nvram_buf;
+	src = (u32 *)header;
+	dst = (u32 *)nvram_buf;
 	for (i = 0; i < sizeof(struct nvram_header); i += 4)
 		*dst++ = *src++;
 	for (; i < header->len && i < NVRAM_SPACE && i < size; i += 4)
@@ -192,16 +194,16 @@ int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 	/* Look for name=value and return value */
 	var = &nvram_buf[sizeof(struct nvram_header)];
 	end = nvram_buf + sizeof(nvram_buf) - 2;
-	end[0] = end[1] = '\0';
+	end[0] = '\0';
+	end[1] = '\0';
 	for (; *var; var = value + strlen(value) + 1) {
 		eq = strchr(var, '=');
 		if (!eq)
 			break;
 		value = eq + 1;
-		if ((eq - var) == strlen(name) &&
-			strncmp(var, name, (eq - var)) == 0) {
+		if (eq - var == strlen(name) &&
+		    strncmp(var, name, eq - var) == 0)
 			return snprintf(val, val_len, "%s", value);
-		}
 	}
 	return -ENOENT;
 }
@@ -210,10 +212,11 @@ EXPORT_SYMBOL(bcm47xx_nvram_getenv);
 int bcm47xx_nvram_gpio_pin(const char *name)
 {
 	int i, err;
-	char nvram_var[10];
-	char buf[30];
+	char *nvram_var = "gpioXX";
+	char buf[NVRAM_MAX_GPIO_VALUE_LEN];
 
-	for (i = 0; i < 32; i++) {
+	/* TODO: Optimize it to don't call getenv so many times */
+	for (i = 0; i < NVRAM_MAX_GPIO_ENTRIES; i++) {
 		err = snprintf(nvram_var, sizeof(nvram_var), "gpio%i", i);
 		if (err <= 0)
 			continue;
diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 1b170bf..ab698ba 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -35,7 +35,6 @@
 #include <bcm47xx.h>
 #include <bcm47xx_board.h>
 
-
 static char bcm47xx_system_type[20] = "Broadcom BCM47XX";
 
 const char *get_system_type(void)
@@ -83,7 +82,7 @@ static __init void prom_init_mem(void)
 		/* Loop condition may be not enough, off may be over 1 MiB */
 		if (off + mem >= max) {
 			mem = max;
-			printk(KERN_DEBUG "assume 128MB RAM\n");
+			pr_debug("Assume 128MB RAM\n");
 			break;
 		}
 		if (!memcmp(prom_init, prom_init + mem, 32))
diff --git a/arch/mips/bcm47xx/serial.c b/arch/mips/bcm47xx/serial.c
index 2f5bbd6..df761d3 100644
--- a/arch/mips/bcm47xx/serial.c
+++ b/arch/mips/bcm47xx/serial.c
@@ -36,8 +36,8 @@ static int __init uart8250_init_ssb(void)
 		struct plat_serial8250_port *p = &(uart8250_data[i]);
 		struct ssb_serial_port *ssb_port = &(mcore->serial_ports[i]);
 
-		p->mapbase = (unsigned int) ssb_port->regs;
-		p->membase = (void *) ssb_port->regs;
+		p->mapbase = (unsigned int)ssb_port->regs;
+		p->membase = (void *)ssb_port->regs;
 		p->irq = ssb_port->irq + 2;
 		p->uartclk = ssb_port->baud_base;
 		p->regshift = ssb_port->reg_shift;
@@ -62,8 +62,8 @@ static int __init uart8250_init_bcma(void)
 		struct bcma_serial_port *bcma_port;
 		bcma_port = &(cc->serial_ports[i]);
 
-		p->mapbase = (unsigned int) bcma_port->regs;
-		p->membase = (void *) bcma_port->regs;
+		p->mapbase = (unsigned int)bcma_port->regs;
+		p->membase = (void *)bcma_port->regs;
 		p->irq = bcma_port->irq;
 		p->uartclk = bcma_port->baud_base;
 		p->regshift = bcma_port->reg_shift;
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index b26c9c2..82ff9fd 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(bcm47xx_bus_type);
 
 static void bcm47xx_machine_restart(char *command)
 {
-	printk(KERN_ALERT "Please stand by while rebooting the system...\n");
+	pr_alert("Please stand by while rebooting the system...\n");
 	local_irq_disable();
 	/* Set the watchdog timer to reset immediately */
 	switch (bcm47xx_bus_type) {
@@ -107,7 +107,7 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	char buf[20];
 
 	/* Fill boardinfo structure */
-	memset(&(iv->boardinfo), 0 , sizeof(struct ssb_boardinfo));
+	memset(&iv->boardinfo, 0 , sizeof(struct ssb_boardinfo));
 
 	bcm47xx_fill_ssb_boardinfo(&iv->boardinfo, NULL);
 
@@ -126,7 +126,7 @@ static void __init bcm47xx_register_ssb(void)
 	char buf[100];
 	struct ssb_mipscore *mcore;
 
-	err = ssb_bus_ssbbus_register(&(bcm47xx_bus.ssb), SSB_ENUM_BASE,
+	err = ssb_bus_ssbbus_register(&bcm47xx_bus.ssb, SSB_ENUM_BASE,
 				      bcm47xx_get_invariants);
 	if (err)
 		panic("Failed to initialize SSB bus (err %d)", err);
@@ -136,7 +136,7 @@ static void __init bcm47xx_register_ssb(void)
 		if (strstr(buf, "console=ttyS1")) {
 			struct ssb_serial_port port;
 
-			printk(KERN_DEBUG "Swapping serial ports!\n");
+			pr_debug("Swapping serial ports!\n");
 			/* swap serial ports */
 			memcpy(&port, &mcore->serial_ports[0], sizeof(port));
 			memcpy(&mcore->serial_ports[0], &mcore->serial_ports[1],
@@ -168,7 +168,7 @@ void __init plat_mem_setup(void)
 	struct cpuinfo_mips *c = &current_cpu_data;
 
 	if ((c->cputype == CPU_74K) || (c->cputype == CPU_1074K)) {
-		printk(KERN_INFO "bcm47xx: using bcma bus\n");
+		pr_info("Using bcma bus\n");
 #ifdef CONFIG_BCM47XX_BCMA
 		bcm47xx_bus_type = BCM47XX_BUS_TYPE_BCMA;
 		bcm47xx_sprom_register_fallbacks();
@@ -179,7 +179,7 @@ void __init plat_mem_setup(void)
 #endif
 #endif
 	} else {
-		printk(KERN_INFO "bcm47xx: using ssb bus\n");
+		pr_info("Using ssb bus\n");
 #ifdef CONFIG_BCM47XX_SSB
 		bcm47xx_bus_type = BCM47XX_BUS_TYPE_SSB;
 		bcm47xx_sprom_register_fallbacks();
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index a077ed2..290309e 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -780,8 +780,8 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
 		bcm47xx_fill_sprom_path_r4589(sprom, prefix, fallback);
 		break;
 	default:
-		pr_warn("Unsupported SPROM revision %d detected. Will extract"
-			" v1\n", sprom->revision);
+		pr_warn("Unsupported SPROM revision %d detected. Will extract v1\n",
+			sprom->revision);
 		sprom->revision = 1;
 		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
 		bcm47xx_fill_sprom_r12389(sprom, prefix, fallback);
@@ -828,7 +828,7 @@ static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 		bcm47xx_fill_sprom(out, prefix, false);
 		return 0;
 	} else {
-		pr_warn("bcm47xx: unable to fill SPROM for given bustype.\n");
+		pr_warn("Unable to fill SPROM for given bustype.\n");
 		return -EINVAL;
 	}
 }
@@ -860,7 +860,7 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 		}
 		return 0;
 	default:
-		pr_warn("bcm47xx: unable to fill SPROM for given bustype.\n");
+		pr_warn("Unable to fill SPROM for given bustype.\n");
 		return -EINVAL;
 	}
 }
diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index 5b46510..74224cf 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -22,7 +22,6 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-
 #include <linux/init.h>
 #include <linux/ssb/ssb.h>
 #include <asm/time.h>
-- 
1.8.4.5
