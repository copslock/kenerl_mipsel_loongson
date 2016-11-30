Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2016 23:58:34 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:42056 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992437AbcK3W6Zr1RiL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Nov 2016 23:58:25 +0100
Received: from hauke-desktop.lan (p20030086280C75006955C9BE4344F859.dip0.t-ipconnect.de [IPv6:2003:86:280c:7500:6955:c9be:4344:f859])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 483EB1001CE;
        Wed, 30 Nov 2016 23:58:25 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] lantiq: activate more drivers in default configuration
Date:   Wed, 30 Nov 2016 23:58:08 +0100
Message-Id: <20161130225808.11620-2-hauke@hauke-m.de>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161130225808.11620-1-hauke@hauke-m.de>
References: <20161130225808.11620-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This activates the following functionalities:
* SMP support (used on xRX200)
* PCI support
* NAND driver
* PHY driver
* UART
* Watchdog
* USB 2.0 controller

These driver are driving different IP cores found on the supported SoCs.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/configs/xway_defconfig | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
index 0ccb642..4365108b 100644
--- a/arch/mips/configs/xway_defconfig
+++ b/arch/mips/configs/xway_defconfig
@@ -1,7 +1,11 @@
 CONFIG_LANTIQ=y
+CONFIG_PCI_LANTIQ=y
 CONFIG_XRX200_PHY_FW=y
 CONFIG_CPU_MIPS32_R2=y
+CONFIG_MIPS_MT_SMP=y
+CONFIG_MIPS_VPE_LOADER=y
 # CONFIG_COMPACTION is not set
+CONFIG_NR_CPUS=2
 CONFIG_HZ_100=y
 # CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
@@ -22,8 +26,8 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
+CONFIG_PCI=y
 # CONFIG_COREDUMP is not set
-# CONFIG_SUSPEND is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -81,6 +85,8 @@ CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_LANTIQ=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_XWAY=y
 CONFIG_EEPROM_93CX6=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -88,6 +94,7 @@ CONFIG_NETDEVICES=y
 CONFIG_LANTIQ_ETOP=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PHYLIB=y
+CONFIG_INTEL_XWAY_PHY=y
 CONFIG_PPP=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MULTILINK=y
@@ -108,17 +115,21 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_LANTIQ=y
 CONFIG_SPI=y
 CONFIG_GPIO_MM_LANTIQ=y
 CONFIG_GPIO_STP_XWAY=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
+CONFIG_LANTIQ_WDT=y
 # CONFIG_HID is not set
 # CONFIG_USB_HID is not set
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_STORAGE_DEBUG=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_DWC2_PCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
-- 
2.10.2
