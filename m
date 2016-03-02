Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 21:47:27 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:49550 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008280AbcCBUr0NSoCn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 21:47:26 +0100
Received: from localhost.localdomain (85-76-14-12-nat.elisa-mobile.fi [85.76.14.12])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 933A6234024;
        Wed,  2 Mar 2016 22:47:25 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: cavium_octeon_defconfig: enable all OCTEON SoC drivers
Date:   Wed,  2 Mar 2016 22:47:19 +0200
Message-Id: <1456951639-6935-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Some drivers for SoC provided functionality are missing.
Enable to those in defconfig to provide better build/testing coverage.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/configs/cavium_octeon_defconfig | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index e57058d..dcac308 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -119,14 +119,16 @@ CONFIG_SPI=y
 CONFIG_SPI_OCTEON=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-# CONFIG_USB_SUPPORT is not set
-CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
-CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
-CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+CONFIG_USB=m
+CONFIG_USB_EHCI_HCD=m
+CONFIG_USB_EHCI_HCD_PLATFORM=m
+CONFIG_USB_OHCI_HCD=m
+CONFIG_USB_OHCI_HCD_PLATFORM=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
 CONFIG_OCTEON_ETHERNET=y
+CONFIG_OCTEON_USB=m
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
@@ -152,6 +154,9 @@ CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_MD5_OCTEON=y
+CONFIG_CRYPTO_SHA1_OCTEON=m
+CONFIG_CRYPTO_SHA256_OCTEON=m
+CONFIG_CRYPTO_SHA512_OCTEON=m
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
2.4.0
