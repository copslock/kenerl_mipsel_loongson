From: Markos Chandras <markos.chandras@imgtec.com>
Date: Fri, 27 Feb 2015 07:51:32 +0000
Subject: MIPS: Malta: Detect and fix bad memsize values
Message-ID: <20150227075132.e0gxTM5db_YiF5Qs7Tfz50bcu3mUuel-1Ik-pHYaFu0@z>

commit f7f8aea4b97c4d48e42f02cb37026bee445f239f upstream.

memsize denotes the amount of RAM we can access from kseg{0,1} and
that should be up to 256M. In case the bootloader reports a value
higher than that (perhaps reporting all the available RAM) it's best
if we fix it ourselves and just warn the user about that. This is
usually a problem with the bootloader and/or its environment.

[ralf@linux-mips.org: Remove useless parens as suggested bei Sergei.
Reformat long pr_warn statement to fit into 80 column limit.]

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9362/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/mti-malta/malta-memory.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index fdffc806664f..9b3a07d962ce 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -52,6 +52,12 @@ fw_memblock_t * __init fw_getmdesc(int eva)
 		pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
 		physical_memsize = 0x02000000;
 	} else {
+		if (memsize > (256 << 20)) { /* memsize should be capped to 256M */
+			pr_warn("Unsupported memsize value (0x%lx) detected! "
+				"Using 0x10000000 (256M) instead\n",
+				memsize);
+			memsize = 256 << 20;
+		}
 		/* If ememsize is set, then set physical_memsize to that */
 		physical_memsize = ememsize ? : memsize;
 	}
