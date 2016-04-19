From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 19 Apr 2016 15:35:39 -0700
Subject: MIPS: BMIPS: Adjust mips-hpt-frequency for BCM7435
Message-ID: <20160419223539.IjDBlPp9SibXR6igAvG_jZWn6TVEKvA3nHUoC6ReND8@z>

commit 80fa40acaa1dad5a0a9c15ed2e5d2e72461843f5 upstream.

The CPU actually runs at 1405Mhz which gives us a 175625000 Hz MIPS timer
frequency (CPU frequency / 8).

Fixes: e4c7d009654a ("MIPS: BMIPS: Add BCM7435 dtsi")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: john@phrozen.org
Cc: cernekee@gmail.com
Cc: jaedon.shin@gmail.com
Patchwork: https://patchwork.linux-mips.org/patch/13132/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 8b9432c..27b2b8e 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -7,7 +7,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;

-		mips-hpt-frequency = <163125000>;
+		mips-hpt-frequency = <175625000>;

 		cpu@0 {
 			compatible = "brcm,bmips5200";
--
2.7.4
