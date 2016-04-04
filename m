From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 4 Apr 2016 10:55:35 -0700
Subject: MIPS: BMIPS: Clear MIPS_CACHE_ALIASES earlier
Message-ID: <20160404175535.aYH855o6Kh62EX2woBFsHugf2E9Bn011QF6-doC-JME@z>

commit 73c4ca047f440c79f545bc6133e3033f754cd239 upstream.

BMIPS5000 and BMIPS5200 processor have no D cache aliases, and this is
properly handled by the per-CPU override added at the end of
r4k_cache_init(), the problem is that the output of probe_pcache()
disagrees with that, since this is too late:

Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes

With the change moved earlier, we now have a consistent output with the
settings we are intending to have:

Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, no aliases, linesize 32 bytes

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13011/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/mm/c-r4k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index b2c1685..f22809f 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1307,6 +1307,8 @@ static void probe_pcache(void)

 	case CPU_BMIPS5000:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
+		/* Cache aliases are handled in hardware; allow HIGHMEM */
+		c->dcache.flags &= ~MIPS_CACHE_ALIASES;
 		break;

 	case CPU_LOONGSON2:
@@ -1746,8 +1748,6 @@ void r4k_cache_init(void)
 		flush_icache_range = (void *)b5k_instruction_hazard;
 		local_flush_icache_range = (void *)b5k_instruction_hazard;

-		/* Cache aliases are handled in hardware; allow HIGHMEM */
-		current_cpu_data.dcache.flags &= ~MIPS_CACHE_ALIASES;

 		/* Optimization: an L2 flush implicitly flushes the L1 */
 		current_cpu_data.options |= MIPS_CPU_INCLUSIVE_CACHES;
--
2.7.4
