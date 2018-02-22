From: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Date: Thu, 22 Feb 2018 12:02:16 +0900
Subject: [PATCH 1/2] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for
 BCM47XX PCIe erratum
Message-ID: <20180222030216.CHWPWviAAn9DkZVjeZbpBvty81bbnjMBJ4KE6dIjsEY@z>

The erratum and workaround are described by BCM5300X-ES300-RDS.pdf as below.

  R10: PCIe Transactions Periodically Fail

    Description: The BCM5300X PCIe does not maintain transaction ordering.
                 This may cause PCIe transaction failure.
    Fix Comment: Add a dummy PCIe configuration read after a PCIe
                 configuration write to ensure PCIe configuration access
                 ordering. Set ES bit of CP0 configu7 register to enable
                 sync function so that the sync instruction is functional.
    Resolution:  hndpci.c: extpci_write_config()
                 hndmips.c: si_mips_init()
                 mipsinc.h CONF7_ES

This is fixed by the CFE MIPS bcmsi chipset driver also for BCM47XX.
Also the dummy PCIe configuration read is already implemented in the Linux
BCMA driver.
This patch is just to enable ExternalSync in the Linux driver.

Change-Id: Ifc7a0ce46962933731297ad0c82682e7d39328ff
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/mips/include/asm/mipsregs.h | 2 ++
 arch/mips/kernel/cpu-probe.c     | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 858752dac337..1d1f4416a0f3 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -680,6 +680,8 @@
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
+/* ExternalSync */
+#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
 
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cf3fd549e16d..9171928c40dd 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -429,6 +429,13 @@ static inline void check_errata(void)
 		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
 			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
 		break;
+#ifdef CONFIG_BCMA_DRIVER_PCI_HOSTMODE
+	case CPU_74K:
+		/* Enable ExternalSync for sync instruction to take effect */
+		pr_info("ExternalSync has been enabled\n");
+		write_c0_config7(read_c0_config7() | MIPS_CONF7_ES);
+		break;
+#endif
 	default:
 		break;
 	}
-- 
2.16.1

Regards,
Ikegami
