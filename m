From: "Rafał Miłecki" <rafal@milecki.pl>
Date: Fri, 27 Jul 2018 13:13:39 +0200
Subject: Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20180727111339.kgOhnP_BPI--nsWp-5BWZxVVzAI01pTtbPmXUoKbyWU@z>

From: "Rafał Miłecki" <rafal@milecki.pl>

[ Upstream commit d5ea019f8a381f88545bb26993b62ec24a2796b7 ]

This reverts commit 2a027b47dba6 ("MIPS: BCM47XX: Enable 74K Core
ExternalSync for PCIe erratum").

Enabling ExternalSync caused a regression for BCM4718A1 (used e.g. in
Netgear E3000 and ASUS RT-N16): it simply hangs during PCIe
initialization. It's likely that BCM4717A1 is also affected.

I didn't notice that earlier as the only BCM47XX devices with PCIe I
own are:
1) BCM4706 with 2 x 14e4:4331
2) BCM4706 with 14e4:4360 and 14e4:4331
it appears that BCM4706 is unaffected.

While BCM5300X-ES300-RDS.pdf seems to document that erratum and its
workarounds (according to quotes provided by Tokunori) it seems not even
Broadcom follows them.

According to the provided info Broadcom should define CONF7_ES in their
SDK's mipsinc.h and implement workaround in the si_mips_init(). Checking
both didn't reveal such code. It *could* mean Broadcom also had some
problems with the given workaround.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Michael Marley <michael@michaelmarley.com>
Patchwork: https://patchwork.linux-mips.org/patch/20032/
URL: https://bugs.openwrt.org/index.php?do=details&task_id=1688
Cc: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/bcm47xx/setup.c        |    6 ------
 arch/mips/include/asm/mipsregs.h |    3 ---
 2 files changed, 9 deletions(-)

--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -249,12 +249,6 @@ static int __init bcm47xx_cpu_fixes(void
 		 */
 		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
 			cpu_wait = NULL;
-
-		/*
-		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
-		 * Enable ExternalSync for sync instruction to take effect
-		 */
-		set_c0_config7(MIPS_CONF7_ES);
 		break;
 #endif
 	}
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -605,8 +605,6 @@
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
-/* ExternalSync */
-#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
 
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
@@ -2014,7 +2012,6 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
-__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)


Patches currently in stable-queue which might be from rafal@milecki.pl are

queue-4.4/revert-mips-bcm47xx-enable-74k-core-externalsync-for-pcie-erratum.patch
