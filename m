Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2015 18:00:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27904 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008505AbbIYQAVfcn3i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Sep 2015 18:00:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A81083F96A166;
        Fri, 25 Sep 2015 17:00:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 25 Sep 2015 17:00:15 +0100
Received: from localhost (192.168.159.196) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 25 Sep
 2015 17:00:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 1/3] MIPS: mm: compile maar_init unconditionally
Date:   Fri, 25 Sep 2015 08:59:36 -0700
Message-ID: <1443196778-5528-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1443196778-5528-1-git-send-email-paul.burton@imgtec.com>
References: <1443196778-5528-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.196]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

maar_init was previously only compiled when CONFIG_NEED_MULTIPLE_NODES
was not set, which has been fine since it is only called from the
standard implementation of mem_init which has the same condition. In
preparation for calling it from the SMP startup code on secondary CPUs,
move maar_init outside of the #ifndef such that it is always compiled.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>

---

Changes in v2:
- New patch, to fix ip27_defconfig builds.

 arch/mips/mm/init.c | 126 ++++++++++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 66d0f49..074ac54 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -252,6 +252,69 @@ void __init fixrange_init(unsigned long start, unsigned long end,
 #endif
 }
 
+unsigned __weak platform_maar_init(unsigned num_pairs)
+{
+	struct maar_config cfg[BOOT_MEM_MAP_MAX];
+	unsigned i, num_configured, num_cfg = 0;
+	phys_addr_t skip;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+		case BOOT_MEM_INIT_RAM:
+			break;
+		default:
+			continue;
+		}
+
+		skip = 0x10000 - (boot_mem_map.map[i].addr & 0xffff);
+
+		cfg[num_cfg].lower = boot_mem_map.map[i].addr;
+		cfg[num_cfg].lower += skip;
+
+		cfg[num_cfg].upper = cfg[num_cfg].lower;
+		cfg[num_cfg].upper += boot_mem_map.map[i].size - 1;
+		cfg[num_cfg].upper -= skip;
+
+		cfg[num_cfg].attrs = MIPS_MAAR_S;
+		num_cfg++;
+	}
+
+	num_configured = maar_config(cfg, num_cfg, num_pairs);
+	if (num_configured < num_cfg)
+		pr_warn("Not enough MAAR pairs (%u) for all bootmem regions (%u)\n",
+			num_pairs, num_cfg);
+
+	return num_configured;
+}
+
+static void maar_init(void)
+{
+	unsigned num_maars, used, i;
+
+	if (!cpu_has_maar)
+		return;
+
+	/* Detect the number of MAARs */
+	write_c0_maari(~0);
+	back_to_back_c0_hazard();
+	num_maars = read_c0_maari() + 1;
+
+	/* MAARs should be in pairs */
+	WARN_ON(num_maars % 2);
+
+	/* Configure the required MAARs */
+	used = platform_maar_init(num_maars / 2);
+
+	/* Disable any further MAARs */
+	for (i = (used * 2); i < num_maars; i++) {
+		write_c0_maari(i);
+		back_to_back_c0_hazard();
+		write_c0_maar(0);
+		back_to_back_c0_hazard();
+	}
+}
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 int page_is_ram(unsigned long pagenr)
 {
@@ -334,69 +397,6 @@ static inline void mem_init_free_highmem(void)
 #endif
 }
 
-unsigned __weak platform_maar_init(unsigned num_pairs)
-{
-	struct maar_config cfg[BOOT_MEM_MAP_MAX];
-	unsigned i, num_configured, num_cfg = 0;
-	phys_addr_t skip;
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		switch (boot_mem_map.map[i].type) {
-		case BOOT_MEM_RAM:
-		case BOOT_MEM_INIT_RAM:
-			break;
-		default:
-			continue;
-		}
-
-		skip = 0x10000 - (boot_mem_map.map[i].addr & 0xffff);
-
-		cfg[num_cfg].lower = boot_mem_map.map[i].addr;
-		cfg[num_cfg].lower += skip;
-
-		cfg[num_cfg].upper = cfg[num_cfg].lower;
-		cfg[num_cfg].upper += boot_mem_map.map[i].size - 1;
-		cfg[num_cfg].upper -= skip;
-
-		cfg[num_cfg].attrs = MIPS_MAAR_S;
-		num_cfg++;
-	}
-
-	num_configured = maar_config(cfg, num_cfg, num_pairs);
-	if (num_configured < num_cfg)
-		pr_warn("Not enough MAAR pairs (%u) for all bootmem regions (%u)\n",
-			num_pairs, num_cfg);
-
-	return num_configured;
-}
-
-static void maar_init(void)
-{
-	unsigned num_maars, used, i;
-
-	if (!cpu_has_maar)
-		return;
-
-	/* Detect the number of MAARs */
-	write_c0_maari(~0);
-	back_to_back_c0_hazard();
-	num_maars = read_c0_maari() + 1;
-
-	/* MAARs should be in pairs */
-	WARN_ON(num_maars % 2);
-
-	/* Configure the required MAARs */
-	used = platform_maar_init(num_maars / 2);
-
-	/* Disable any further MAARs */
-	for (i = (used * 2); i < num_maars; i++) {
-		write_c0_maari(i);
-		back_to_back_c0_hazard();
-		write_c0_maar(0);
-		back_to_back_c0_hazard();
-	}
-}
-
 void __init mem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
-- 
2.5.3
