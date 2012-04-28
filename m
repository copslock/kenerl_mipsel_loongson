Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:18:03 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1462 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903725Ab2D1NNM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:13:12 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 06:13:01 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 06:12:10 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id AF3BE9F9F5; Sat, 28
 Apr 2012 06:12:49 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 06:12:49 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 10/12] MIPS: Netlogic: Platform changes for XLR/XLS I2C
Date:   Sat, 28 Apr 2012 18:42:16 +0530
Message-ID: <1335618738-4679-11-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 638533573JG2109473-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add platform code for XLR/XLS I2C controller and devices. Add
devices on the I2C bus on the XLR/XLS developement boards.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/configs/nlm_xlr_defconfig |    4 +++
 arch/mips/netlogic/xlr/platform.c   |   51 +++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index d0b857d..138f698 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -367,6 +367,10 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_RAW_DRIVER=m
+CONFIG_I2C=y
+CONFIG_I2C_XLR=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1374=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID_SUPPORT is not set
diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index cb0ab63..71b44d8 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -14,6 +14,7 @@
 #include <linux/resource.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/i2c.h>
 
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlr/iomap.h>
@@ -186,3 +187,53 @@ int xls_platform_usb_init(void)
 
 arch_initcall(xls_platform_usb_init);
 #endif
+
+#ifdef CONFIG_I2C
+static struct i2c_board_info nlm_i2c_board_info1[] __initdata = {
+	/* All XLR boards have this RTC and Max6657 Temp Chip */
+	[0] = {
+		.type	= "ds1374",
+		.addr	= 0x68
+	},
+	[1] = {
+		.type	= "lm90",
+		.addr	= 0x4c
+	},
+};
+
+static struct resource i2c_resources[] = {
+	[0] = {
+		.start	= 0,	/* filled at init */
+		.end	= 0,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device nlm_xlr_i2c_1 = {
+	.name           = "xlr-i2cbus",
+	.id             = 1,
+	.num_resources	= 1,
+	.resource	= i2c_resources,
+};
+
+static int __init nlm_i2c_init(void)
+{
+	int err = 0;
+	unsigned int offset;
+
+	/* I2C bus 0 does not have any useful devices, configure only bus 1 */
+	offset = NETLOGIC_IO_I2C_1_OFFSET;
+	nlm_xlr_i2c_1.resource[0].start = CPHYSADDR(nlm_mmio_base(offset));
+	nlm_xlr_i2c_1.resource[0].end = nlm_xlr_i2c_1.resource[0].start + 0xfff;
+
+	platform_device_register(&nlm_xlr_i2c_1);
+
+	err = i2c_register_board_info(1, nlm_i2c_board_info1,
+				ARRAY_SIZE(nlm_i2c_board_info1));
+	if (err < 0)
+		pr_err("nlm-i2c: cannot register board I2C devices\n");
+	return err;
+}
+
+arch_initcall(nlm_i2c_init);
+#endif
-- 
1.7.9.5
