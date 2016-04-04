From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 4 Apr 2016 10:55:38 -0700
Subject: MIPS: BMIPS: Pretty print BMIPS5200 processor name
Message-ID: <20160404175538.PQdYS7i2c4bnvmFG1CNGGICfCcKBb_ojWWyZB3QJlCs@z>

commit 37808d62afcdc420d98875c4b514c178d56f6815 upstream.

Just to ease debugging of multiplatform kernel, make sure we print
"Broadcom BMIPS5200" for the BMIPS5200 implementation instead of
Broadcom BMIPS5000.

Fixes: 68e6a78373a6d ("MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13014/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cpu-probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index dbe0792..cbd4c43 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1248,7 +1248,10 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_BMIPS5000:
 	case PRID_IMP_BMIPS5200:
 		c->cputype = CPU_BMIPS5000;
-		__cpu_name[cpu] = "Broadcom BMIPS5000";
+		if ((c->processor_id & PRID_IMP_MASK) == PRID_IMP_BMIPS5200)
+			__cpu_name[cpu] = "Broadcom BMIPS5200";
+		else
+			__cpu_name[cpu] = "Broadcom BMIPS5000";
 		set_elf_platform(cpu, "bmips5000");
 		c->options |= MIPS_CPU_ULRI;
 		break;
--
2.7.4
