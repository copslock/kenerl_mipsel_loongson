From: Paul Burton <paul.burton@mips.com>
Date: Mon, 16 Jul 2018 08:26:36 -0700
Subject: MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads
Message-ID: <20180716152636.wsMxbqQkubyW41vkELyi5rrfYHWCbWkjWDH-IsSiHYk@z>

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit cd87668d601f622e0ebcfea4f78d116d5f572f4d ]

The PCI_OHCI_INT_REG case in pci_ohci_read_reg() contains the following
if statement:

  if ((lo & 0x00000f00) == CS5536_USB_INTR)

CS5536_USB_INTR expands to the constant 11, which gives us the following
condition which can never evaluate true:

  if ((lo & 0xf00) == 11)

At least when using GCC 8.1.0 this falls foul of the tautoligcal-compare
warning, and since the code is built with the -Werror flag the build
fails.

Fix this by shifting lo right by 8 bits in order to match the
corresponding PCI_OHCI_INT_REG case in pci_ohci_write_reg().

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19861/
Cc: Huacai Chen <chenhc@lemote.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/loongson/common/cs5536/cs5536_ohci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/loongson/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_ohci.c
@@ -138,7 +138,7 @@ u32 pci_ohci_read_reg(int reg)
 		break;
 	case PCI_OHCI_INT_REG:
 		_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
-		if ((lo & 0x00000f00) == CS5536_USB_INTR)
+		if (((lo >> PIC_YSEL_LOW_USB_SHIFT) & 0xf) == CS5536_USB_INTR)
 			conf_data = 1;
 		break;
 	default:


Patches currently in stable-queue which might be from paul.burton@mips.com are

queue-3.18/binfmt_elf-respect-error-return-from-regset-active.patch
queue-3.18/mips-loongson64-cs5536-fix-pci_ohci_int_reg-reads.patch
queue-3.18/mips-ath79-fix-system-restart.patch
queue-3.18/mips-fix-isa-virt-bus-conversion-for-non-zero-phys_offset.patch
queue-3.18/mips-warn_on-invalid-dma-cache-maintenance-not-bug_on.patch
