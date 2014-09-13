Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Sep 2014 10:03:05 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45640 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008110AbaIMIBL4WVre (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Sep 2014 10:01:11 +0200
Received: by mail-pa0-f45.google.com with SMTP id rd3so2878565pab.32
        for <multiple recipients>; Sat, 13 Sep 2014 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4vt6pdbzoDZ39P2H7PmNbUHCnVESaVk3mMSdfAKL4VY=;
        b=Hovj6S6adOiMpH1sgJu2apEkC2cVcbV6KW9JaOBSCVRfGCocyFRSks7YYJhAlTSY34
         +qBZtbICm3a0tmyYdlrfMgmwhex8H7bvjXcnDLc/vqvYZm28lw2s2ma1IUag2BoHo/Jq
         lLdoRxOp61YwJFCydbxMB13BYDsn2ttqgQCY1ivff31K8J94DaQPUApAlz/dVF2BDbix
         kOeDR+S0j84N2ZE2qZ38Xewp0wwUB9ieQsTFcQwHeQrTH/D8sMXfhema7aeEkEjjejxY
         FZTCIWsJbrvi0nKCicbUGblEL4JYaNwHug4GurnjAEBrB1SNBeFkvH4FMgOxNUZPPSmS
         WmAQ==
X-Received: by 10.68.94.226 with SMTP id df2mr19933278pbb.122.1410595265881;
        Sat, 13 Sep 2014 01:01:05 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id wh10sm6062397pac.20.2014.09.13.01.01.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 01:01:05 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 08/11] MIPS: Loongson-3: Add chipset ACPI platform driver
Date:   Sat, 13 Sep 2014 16:00:06 +0800
Message-Id: <1410595207-10994-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1410595207-10994-1-git-send-email-chenhc@lemote.com>
References: <1410595207-10994-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This add south-bridge (SB700/SB710/SB800 chipset) ACPI platform driver
for Loongson-3. This will be used by EC (Embedded Controller, used by
laptops) driver and STR (Suspend To RAM).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson/common/pci.c   |    6 ++
 drivers/platform/mips/Makefile    |    2 +-
 drivers/platform/mips/acpi_init.c |  131 +++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 1 deletions(-)
 create mode 100644 drivers/platform/mips/acpi_init.c

diff --git a/arch/mips/loongson/common/pci.c b/arch/mips/loongson/common/pci.c
index 003ab4e..4e25756 100644
--- a/arch/mips/loongson/common/pci.c
+++ b/arch/mips/loongson/common/pci.c
@@ -78,6 +78,8 @@ static void __init setup_pcimap(void)
 #endif
 }
 
+extern int sbx00_acpi_init(void);
+
 static int __init pcibios_init(void)
 {
 	setup_pcimap();
@@ -89,6 +91,10 @@ static int __init pcibios_init(void)
 #endif
 	register_pci_controller(&loongson_pci_controller);
 
+#ifdef CONFIG_CPU_LOONGSON3
+	sbx00_acpi_init();
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/platform/mips/Makefile b/drivers/platform/mips/Makefile
index 15723a6..acf0084 100644
--- a/drivers/platform/mips/Makefile
+++ b/drivers/platform/mips/Makefile
@@ -1 +1 @@
-obj-y += cpu_hwmon.o
+obj-y += acpi_init.o cpu_hwmon.o
diff --git a/drivers/platform/mips/acpi_init.c b/drivers/platform/mips/acpi_init.c
new file mode 100644
index 0000000..ee2825c
--- /dev/null
+++ b/drivers/platform/mips/acpi_init.c
@@ -0,0 +1,131 @@
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/export.h>
+
+#define SBX00_ACPI_IO_BASE 0x800
+#define SBX00_ACPI_IO_SIZE 0x100
+
+#define ACPI_PM_EVT_BLK         (SBX00_ACPI_IO_BASE + 0x00) /* 4 bytes */
+#define ACPI_PM1_CNT_BLK        (SBX00_ACPI_IO_BASE + 0x04) /* 2 bytes */
+#define ACPI_PMA_CNT_BLK        (SBX00_ACPI_IO_BASE + 0x0F) /* 1 byte */
+#define ACPI_PM_TMR_BLK         (SBX00_ACPI_IO_BASE + 0x18) /* 4 bytes */
+#define ACPI_GPE0_BLK           (SBX00_ACPI_IO_BASE + 0x10) /* 8 bytes */
+#define ACPI_END                (SBX00_ACPI_IO_BASE + 0x80)
+
+#define PM_INDEX        0xCD6
+#define PM_DATA         0xCD7
+#define PM2_INDEX       0xCD0
+#define PM2_DATA        0xCD1
+
+/*
+ * SCI interrupt need acpi space, allocate here
+ */
+
+static int __init register_acpi_resource(void)
+{
+	request_region(SBX00_ACPI_IO_BASE, SBX00_ACPI_IO_SIZE, "acpi");
+	return 0;
+}
+
+static void pmio_write_index(u16 index, u8 reg, u8 value)
+{
+	outb(reg, index);
+	outb(value, index + 1);
+}
+
+static u8 pmio_read_index(u16 index, u8 reg)
+{
+	outb(reg, index);
+	return inb(index + 1);
+}
+
+void pm_iowrite(u8 reg, u8 value)
+{
+	pmio_write_index(PM_INDEX, reg, value);
+}
+EXPORT_SYMBOL(pm_iowrite);
+
+u8 pm_ioread(u8 reg)
+{
+	return pmio_read_index(PM_INDEX, reg);
+}
+EXPORT_SYMBOL(pm_ioread);
+
+void pm2_iowrite(u8 reg, u8 value)
+{
+	pmio_write_index(PM2_INDEX, reg, value);
+}
+EXPORT_SYMBOL(pm2_iowrite);
+
+u8 pm2_ioread(u8 reg)
+{
+	return pmio_read_index(PM2_INDEX, reg);
+}
+EXPORT_SYMBOL(pm2_ioread);
+
+void sci_interrupt_setup(void)
+{
+	u32 temp32;
+
+	/* pm1 base */
+	pm_iowrite(0x22, ACPI_PM1_CNT_BLK & 0xff);
+	pm_iowrite(0x23, ACPI_PM1_CNT_BLK >> 8);
+
+	/* gpm base */
+	pm_iowrite(0x28, ACPI_GPE0_BLK & 0xFF);
+	pm_iowrite(0x29, ACPI_GPE0_BLK >> 8);
+
+	/* gpm base */
+	pm_iowrite(0x2e, ACPI_END & 0xFF);
+	pm_iowrite(0x2f, ACPI_END >> 8);
+
+	/* io decode: When AcpiDecodeEnable set, South-Bridge uses the contents
+	 * of the PM registers at index 20-2B to decode ACPI I/O address. e.g.,
+	 * AcpiSmiEn & SmiCmdEn */
+	pm_iowrite(0x0E, 1<<3 | 0<<2);
+
+	/* SCI_EN set */
+	outw(1, ACPI_PM1_CNT_BLK);
+
+	/* enable to generate SCI */
+	pm_iowrite(0x10, pm_ioread(0x10) | 1);
+
+	/* gpm3/gpm9 enable */
+	temp32 = inl(ACPI_GPE0_BLK + 4);
+	outl(temp32 | (1 << 14) | (1 << 22), ACPI_GPE0_BLK + 4);
+
+	/* set gpm9 as input */
+	pm_iowrite(0x8d, pm_ioread(0x8d) & (~(1 << 1)));
+
+	/* set gpm9 as non-output */
+	pm_iowrite(0x94, pm_ioread(0x94) | (1 << 3));
+
+	/* gpm3 config ACPI trigger SCIOUT */
+	pm_iowrite(0x33, pm_ioread(0x33) & (~(3 << 4)));
+
+	/* gpm9 config ACPI trigger SCIOUT */
+	pm_iowrite(0x3d, pm_ioread(0x3d) & (~(3 << 2)));
+
+	/* gpm3 config falling edge trigger */
+	pm_iowrite(0x37, pm_ioread(0x37) & (~(1 << 6)));
+
+	/* set gpm3 pull-down enable */
+	temp32 = pm2_ioread(0xf6);
+	temp32 |= ((1 << 7) | (1 << 3));
+	pm2_iowrite(0xf6, temp32);
+
+	/* set gpm9 pull-down enable */
+	temp32 = pm2_ioread(0xf8);
+	temp32 |= ((1 << 5) | (1 << 1));
+	pm2_iowrite(0xf8, temp32);
+}
+
+int __init sbx00_acpi_init(void)
+{
+	register_acpi_resource();
+
+	sci_interrupt_setup();
+
+	return 0;
+}
-- 
1.7.7.3
