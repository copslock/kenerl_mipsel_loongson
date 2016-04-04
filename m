From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 4 Apr 2016 10:55:36 -0700
Subject: MIPS: BMIPS: local_r4k___flush_cache_all needs to blast S-cache
Message-ID: <20160404175536.9gLBO3_soXpx12J7vWzmH8_dpDMGmVmJdmtrrx1LpmI@z>

commit f675843ddfdfdf467d08cc922201614a149e439e upstream.

local_r4k___flush_cache_all() is missing a special check for BMIPS5000
processors, we need to blast the S-cache, just like other MTI processors
since we have an inclusive cache. We also need an additional __sync() to
make sure this is completed.

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13012/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/mm/c-r4k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index f22809f..a50011a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -447,6 +447,11 @@ static inline void local_r4k___flush_cache_all(void * args)
 		r4k_blast_scache();
 		break;

+	case CPU_BMIPS5000:
+		r4k_blast_scache();
+		__sync();
+		break;
+
 	default:
 		r4k_blast_dcache();
 		r4k_blast_icache();
--
2.7.4
