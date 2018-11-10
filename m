From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 11 Nov 2018 00:06:12 +0200
Subject: MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver
Message-ID: <20181110220612.cLLpCNbu3-RsikmMYJwVB75cnsYX-OL7KIUA-vkGxww@z>

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit 82fba2df7f7c019627f24c5036dc99f41731d770 upstream.

Re-enable OCTEON USB driver which is needed on older hardware
(e.g. EdgeRouter Lite) for mass storage etc. This got accidentally
deleted when config options were changed for OCTEON2/3 USB.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: f922bc0ad08b ("MIPS: Octeon: cavium_octeon_defconfig: Enable more drivers")
Patchwork: https://patchwork.linux-mips.org/patch/21077/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/configs/cavium_octeon_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -140,6 +140,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
 CONFIG_OCTEON_ETHERNET=y
+CONFIG_OCTEON_USB=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RAS=y
 CONFIG_EXT4_FS=y


Patches currently in stable-queue which might be from aaro.koskinen@iki.fi are

queue-4.14/mips-octeon-cavium_octeon_defconfig-re-enable-octeon-usb-driver.patch
