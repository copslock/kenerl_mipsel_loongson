From: James Hogan <james.hogan@imgtec.com>
Date: Fri, 4 Mar 2016 10:10:51 +0000
Subject: MIPS: smp.c: Fix uninitialised temp_foreign_map
Message-ID: <20160304101051.SSTEtbCQVX9VLBKj4eoj4LmAzz6b0JoioNpIAgBhdoY@z>

commit d825c06bfe8b885b797f917ad47365d0e9c21fbb upstream.

When calculate_cpu_foreign_map() recalculates the cpu_foreign_map
cpumask it uses the local variable temp_foreign_map without initialising
it to zero. Since the calculation only ever sets bits in this cpumask
any existing bits at that memory location will remain set and find their
way into cpu_foreign_map too. This could potentially lead to cache
operations suboptimally doing smp calls to multiple VPEs in the same
core, even though the VPEs share primary caches.

Therefore initialise temp_foreign_map using cpumask_clear() before use.

Fixes: cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12759/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index a31896c..df62553 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -120,6 +120,7 @@ static inline void calculate_cpu_foreign_map(void)
 	cpumask_t temp_foreign_map;

 	/* Re-calculate the mask */
+	cpumask_clear(&temp_foreign_map);
 	for_each_online_cpu(i) {
 		core_present = 0;
 		for_each_cpu(k, &temp_foreign_map)
--
2.7.0
