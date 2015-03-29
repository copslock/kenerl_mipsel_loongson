Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2015 04:55:41 +0200 (CEST)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:33925 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007925AbbC2CzKefYi- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Mar 2015 04:55:10 +0200
X-QQ-mid: bizesmtp2t1427597664t478t099
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 29 Mar 2015 10:54:23 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ52B00A0000000
X-QQ-FEAT: 8YYOEVtNMVmd4sE5L9Dy2LA3t25nlCI6s6BXa5pwtqg2rUj5E4KjjGQUZ7NgE
        ApVJ6xWkknzQA5UHLnz+xEcLi8pJIDUQpJzi+xQB7GnGQuIE5+za7mswW5zcM5AEC/CJngt
        A6e063j7WlZn1fLoLVOJ2HhsGLUWwlS7xSELZnsfF3Ha6IZ6mRK4B1TSg1cRkDkDwMgsoKr
        L3KsyK5Sr6xOzWgDt4BF4z4xlleI0PhOHD5fjH7mU4ucoioHkm6RB
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V9 6/7] MIPS: Loongson-3: Add chipset ACPI platform driver
Date:   Sun, 29 Mar 2015 10:54:10 +0800
Message-Id: <1427597650-2368-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1427597650-2368-1-git-send-email-chenhc@lemote.com>
References: <1427597650-2368-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46581
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
 drivers/platform/mips/Makefile    |    3 +
 drivers/platform/mips/acpi_init.c |  150 +++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 0 deletions(-)
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
index 8dfd039..522c8e1 100644
--- a/drivers/platform/mips/Makefile
+++ b/drivers/platform/mips/Makefile
@@ -1 +1,4 @@
+ifdef CONFIG_CPU_LOONGSON3
+obj-y += acpi_init.o
 obj-$(CONFIG_CPU_HWMON) += cpu_hwmon.o
+endif
diff --git a/drivers/platform/mips/acpi_init.c b/drivers/platform/mips/acpi_init.c
new file mode 100644
index 0000000..dbdad79
--- /dev/null
+++ b/drivers/platform/mips/acpi_init.c
@@ -0,0 +1,150 @@
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/export.h>
+
+#define SBX00_ACPI_IO_BASE 0x800
+#define SBX00_ACPI_IO_SIZE 0x100
+
+#define ACPI_PM_EVT_BLK         (SBX00_ACPI_IO_BASE + 0x00) /* 4 bytes */
+#define ACPI_PM_CNT_BLK         (SBX00_ACPI_IO_BASE + 0x04) /* 2 bytes */
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
+static void acpi_hw_clear_status(void)
+{
+	u16 value;
+
+	/* PMStatus: Clear WakeStatus/PwrBtnStatus */
+	value = inw(ACPI_PM_EVT_BLK);
+	value |= (1 << 8 | 1 << 15);
+	outw(value, ACPI_PM_EVT_BLK);
+
+	/* GPEStatus: Clear all generated events */
+	outl(inl(ACPI_GPE0_BLK), ACPI_GPE0_BLK);
+}
+
+void acpi_registers_setup(void)
+{
+	u32 value;
+
+	/* PM Status Base */
+	pm_iowrite(0x20, ACPI_PM_EVT_BLK & 0xff);
+	pm_iowrite(0x21, ACPI_PM_EVT_BLK >> 8);
+
+	/* PM Control Base */
+	pm_iowrite(0x22, ACPI_PM_CNT_BLK & 0xff);
+	pm_iowrite(0x23, ACPI_PM_CNT_BLK >> 8);
+
+	/* GPM Base */
+	pm_iowrite(0x28, ACPI_GPE0_BLK & 0xff);
+	pm_iowrite(0x29, ACPI_GPE0_BLK >> 8);
+
+	/* ACPI End */
+	pm_iowrite(0x2e, ACPI_END & 0xff);
+	pm_iowrite(0x2f, ACPI_END >> 8);
+
+	/* IO Decode: When AcpiDecodeEnable set, South-Bridge uses the contents
+	 * of the PM registers at index 0x20~0x2B to decode ACPI I/O address. */
+	pm_iowrite(0x0e, 1 << 3);
+
+	/* SCI_EN set */
+	outw(1, ACPI_PM_CNT_BLK);
+
+	/* Enable to generate SCI */
+	pm_iowrite(0x10, pm_ioread(0x10) | 1);
+
+	/* GPM3/GPM9 enable */
+	value = inl(ACPI_GPE0_BLK + 4);
+	outl(value | (1 << 14) | (1 << 22), ACPI_GPE0_BLK + 4);
+
+	/* Set GPM9 as input */
+	pm_iowrite(0x8d, pm_ioread(0x8d) & (~(1 << 1)));
+
+	/* Set GPM9 as non-output */
+	pm_iowrite(0x94, pm_ioread(0x94) | (1 << 3));
+
+	/* GPM3 config ACPI trigger SCIOUT */
+	pm_iowrite(0x33, pm_ioread(0x33) & (~(3 << 4)));
+
+	/* GPM9 config ACPI trigger SCIOUT */
+	pm_iowrite(0x3d, pm_ioread(0x3d) & (~(3 << 2)));
+
+	/* GPM3 config falling edge trigger */
+	pm_iowrite(0x37, pm_ioread(0x37) & (~(1 << 6)));
+
+	/* No wait for STPGNT# in ACPI Sx state */
+	pm_iowrite(0x7c, pm_ioread(0x7c) | (1 << 6));
+
+	/* Set GPM3 pull-down enable */
+	value = pm2_ioread(0xf6);
+	value |= ((1 << 7) | (1 << 3));
+	pm2_iowrite(0xf6, value);
+
+	/* Set GPM9 pull-down enable */
+	value = pm2_ioread(0xf8);
+	value |= ((1 << 5) | (1 << 1));
+	pm2_iowrite(0xf8, value);
+}
+
+int __init sbx00_acpi_init(void)
+{
+	register_acpi_resource();
+	acpi_registers_setup();
+	acpi_hw_clear_status();
+
+	return 0;
+}
-- 
1.7.7.3
