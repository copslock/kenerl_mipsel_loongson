From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 4 Apr 2016 10:55:34 -0700
Subject: MIPS: BMIPS: BMIPS5000 has I cache filing from D cache
Message-ID: <20160404175534._I_Dio5bGSuuTfliHWt0VqEZxA9aQLtVCE689h1wqDw@z>

commit c130d2fd3d59fbd5d269f7d5827bd4ed1d94aec6 upstream.

BMIPS5000 and BMIPS52000 processors have their I-cache filling from the
D-cache. Since BMIPS_GENERIC does not provide (yet) a
cpu-feature-overrides.h file, this was not set anywhere, so make sure
the R4K cache detection takes care of that.

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13010/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/mm/c-r4k.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index fbea443..b2c1685 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1305,6 +1305,10 @@ static void probe_pcache(void)
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;

+	case CPU_BMIPS5000:
+		c->icache.flags |= MIPS_CACHE_IC_F_DC;
+		break;
+
 	case CPU_LOONGSON2:
 		/*
 		 * LOONGSON2 has 4 way icache, but when using indexed cache op,
--
2.7.4
