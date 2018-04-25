From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Wed, 25 Apr 2018 23:10:36 +0200
Subject: MIPS: xilfpga: Actually include FDT in fitImage
Message-ID: <20180425211036.yVEmg7oBy6A3yUlmnqfGcPm1Kg_WEklnjd79p4n3vtU@z>

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 947bc875116042d5375446aa29bc1073c2d38977 upstream.

Commit b35565bb16a5 ("MIPS: generic: Add support for MIPSfpga") added
and its.S file for xilfpga but forgot to add it to
arch/mips/generic/Platform so it is never used.

Fixes: b35565bb16a5 ("MIPS: generic: Add support for MIPSfpga")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.15+
Patchwork: https://patchwork.linux-mips.org/patch/19245/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/generic/Platform |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -16,3 +16,4 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz
 its-y					:= vmlinux.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S


Patches currently in stable-queue which might be from alexandre.belloni@bootlin.com are

queue-4.16/mips-xilfpga-stop-generating-useless-dtb.o.patch
queue-4.16/mips-xilfpga-actually-include-fdt-in-fitimage.patch
