From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Wed, 25 Apr 2018 23:10:35 +0200
Subject: MIPS: xilfpga: Stop generating useless dtb.o
Message-ID: <20180425211035.zTQkIAedQ6UStXwh_u8U3bJibxVOv3x53tmAgZuF-CQ@z>

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit a5a92abbce56c41ff121db41a33b9c0a0ff39365 upstream.

A dtb.o is generated from nexys4ddr.dts but this is never used since it
has been moved to mips/generic with commit b35565bb16a5 ("MIPS: generic:
Add support for MIPSfpga").

Fixes: b35565bb16a5 ("MIPS: generic: Add support for MIPSfpga")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.15+
Patchwork: https://patchwork.linux-mips.org/patch/19244/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/dts/xilfpga/Makefile |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= nexys4ddr.dtb
-
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))


Patches currently in stable-queue which might be from alexandre.belloni@bootlin.com are

queue-4.16/mips-xilfpga-stop-generating-useless-dtb.o.patch
queue-4.16/mips-xilfpga-actually-include-fdt-in-fitimage.patch
