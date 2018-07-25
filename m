From: Quentin Schulz <quentin.schulz@bootlin.com>
Date: Wed, 25 Jul 2018 14:21:32 +0200
Subject: MIPS: mscc: ocelot: fix length of memory address space for MIIM
Message-ID: <20180725122132.NRznNa4aDXu00N_-Ro0Jmdv8-rRMaiMKWHQwc6igaxE@z>

From: Quentin Schulz <quentin.schulz@bootlin.com>

[ Upstream commit 49e5bb13adc11fe6e2e40f65c04f3a461aea1fec ]

The length of memory address space for MIIM0 is from 0x7107009c to
0x710700bf included which is 36 bytes long in decimal, or 0x24 bytes in
hexadecimal and not 0x36.

Fixes: 49b031690abe ("MIPS: mscc: Add switch to ocelot")

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20013/
Cc: robh+dt@kernel.org
Cc: mark.rutland@arm.com
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -184,7 +184,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "mscc,ocelot-miim";
-			reg = <0x107009c 0x36>, <0x10700f0 0x8>;
+			reg = <0x107009c 0x24>, <0x10700f0 0x8>;
 			interrupts = <14>;
 			status = "disabled";
 


Patches currently in stable-queue which might be from quentin.schulz@bootlin.com are

queue-4.18/mips-mscc-ocelot-fix-length-of-memory-address-space-for-miim.patch
