Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2014 05:58:57 +0100 (CET)
Received: from ec2-54-194-5-104.eu-west-1.compute.amazonaws.com ([54.194.5.104]:57047
        "EHLO smtpbgie2.qq.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008751AbaL1E6hDgTpp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Dec 2014 05:58:37 +0100
X-QQ-mid: bizesmtp5t1419742688t263t264
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 28 Dec 2014 12:58:07 +0800 (CST)
X-QQ-SSF: 01100000002000F0FI42B00A0000000
X-QQ-FEAT: xflb0yrtfs9qg/Vn2pmGxZQUY6EaOfGuMbcFd5bFmtaI4i/Xq/X5BzRqDQt7R
        JYYB8Adj60O1XcxR12urjzMCIUP/He/xXOoTQZ+zgtMaLWKYUbKeH/4Q+9dcQdTFkMSan26
        7qMYKpPb2ITlNTN163fA7/2prqnxB65Hmil5Z5OPyvHvIhVh1827Lk/c7Jyc8AcfmJGD1mA
        3fpr34CCUJZpngdzcm+nEOmU1pp4PocEGpabSyAy0fw==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V6 7/8] MIPS: Loongson-3: Add chipset ACPI platform driver
Date:   Sun, 28 Dec 2014 12:58:01 +0800
Message-Id: <1419742681-15140-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1419742681-15140-1-git-send-email-chenhc@lemote.com>
References: <1419742681-15140-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44944
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
 drivers/platform/mips/Makefile    |    1 +
 drivers/platform/mips/acpi_init.c |  131 +++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 0 deletions(-)
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
index 8dfd039..20e471d 100644
--- a/drivers/platform/mips/Makefile
+++ b/drivers/platform/mips/Makefile
@@ -1 +1,2 @@
+obj-y += acpi_init.o
 obj-$(CONFIG_CPU_HWMON) += cpu_hwmon.o
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



7SuA
