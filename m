Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:45:12 +0200 (CEST)
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:30302
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995034AbdH2PnQNk1c1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 17:43:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QMuNDD7K9pBypPMkFk0brDucFY+XEQszTdkdExH0g94=;
 b=f5a9F0N3RGJcEqxxZoK0TD9LdUVq0Ha7cw7Wr+0+hK9+7EluLu2xplC9VLn2f02Z/1ic3N8YJPMAqzMOUb/K3gkeimYo91pU9MYsufWQiJ+eGQu7AeRZAPuzu4nOYGJEPMvfPTnPAR7ZJMGXibPaEwnYIszCFp83G5oj9lVpBNs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Tue, 29
 Aug 2017 15:42:55 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 2/8] watchdog: octeon-wdt: Remove old boot vector code.
Date:   Tue, 29 Aug 2017 10:40:32 -0500
Message-Id: <1504021238-3184-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e323e7d-d9a5-48d8-58c4-08d4eef49e77
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:FJ4foHBNW6iwlWKQ40oXpenTFKaqFzX4kAEyHw6tzNC/KadFT8rW6goj6Fn3ZZy6ZAv1mTiHAQag7kqYTs2b0V+cCkON8pLBfqj6X+iebcarIw1TE4dXvtgBJn1Wj4efT4HxGL0fJ77LXCwaNuI/oBp9ysUQex9M0iFePKMMzYDxQt/uo9pRA2bGQHj9Qe8HGc3C9QC74mjUaNRMDNJ95onVgam1YhpYPqGO00nQ+z4T0KBMgpCWBMSN46hqsLne;25:Ygg+pPLf9wbjV//Jne9852hlrbWJ0ewUY9LtXVs2CuzNuZ8nf4CNZo6ggzVtncdyEG3eRAerfAforucK02n4/ayy4hLr0XFy1mSQ9u3ohwqCNOx3cCb5NjyP+3Ml83xu7/ZKXU/cam19GsnHd7QU/8mnIeZrjieps2u+5rJD5qTMxUVUjNgKXdcI2YNvPAIk4pOwYoVqnHPTdHuSM8aGn/wB2JLV70s5i2Dsd7EMWjV4BD1I1z5jUldCqmXhyb+nmlEqnjZrUccjqG4e6/C2JpWHFJK4VBUCTAlpoGJxiD9Fef5+gsttJSVceeEl3ka7ug+FnySNGowzZ4I2SuQALw==;31:UuGKw6ngBDd5nz0LPPdhYMi+GBYn0w9hv3fTXRZDom1jmDfPPAMqh7eJP5cP5tRYw5zHz32lAiwiuOd3pXPXZIdkt0GpVf8OuzA1DR0U0uPej7DJI7LR9q9jEIxwUMkRY0oWUpwtoymcO3QJGVo7aVJjAffgXw9WOwq6t0hmvS7l8m/cgkPO1iiCF4u7zpSZhG3GxGDToixGD0VVufyNOkK9HVNjg4gIUPlm0vLdOs8=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:c09NXb2N1alkJqM3TsN7GosEzE6Ya3fclwtFjDa+Fkiz8TH7mnomto1tJu6PP+QG8zmz2agyvMggAJXartDyyOJV44KBpARr8Qh3dD1qtHI6dzA9IX9TFtzWNSsLxUwEFKHosC2LhYelEJbIPXApnIvM223moWLEIKiPbx066BkxaERiRyNoPfs5QTs3ctQTUDspT5HrsssydJPsG7UMkcWfNuQTobmtmSpXxaaSox/My6VpiCtAbCVEyFeJr4gk0VySyfcOo+Oitf/4yDQpldIJ91blzfpva36q/+qkPFHkVuRU7DNI92zzq0leJtrmSJ9HckfR40aB6ys8LTY7kd2FnAauv8HdreEoiKriCWRq3F0IaSvNLytDPDjaY7ucO/qbJg6lqujTR1dgwplESKyOtkZMNvDEyGLz6Yz+TwBlUhkPMdPOR1WvI6oCItCn3cEt3CXiTbFFnG6j+oNwxZ8e6Gm11C05D9fWxQ9NdLWPps17MB7TT/zPOmvS61No;4:t04EI8HKch5LUztgjC+WX0yG+11nttY+BcXgHlDvZfTvtyB1l52Uqz70wlYInFXs1WD6kLooP3ZJ29jKPUn1wNF/8kxys8vd8CYeFRHyfdv65L0OwPf/IdgjIDv5CHRFZC+VHfCqe+WkpazQi48lGkXtsBSsmcwgkcKwHzu+tslKHMxQQ2V1GIhTyGB0azCUFeS56u5zYW24r5W7gI/MEvMY7xjWyEezKEudSpCmzeHzxwKQhXG5bgA26RHDCiCQ
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3803DDED88F9162549D50F85809F0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0414DF926F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6009001)(189002)(199003)(189998001)(7736002)(72206003)(97736004)(36756003)(305945005)(5003940100001)(69596002)(33646002)(50226002)(8676002)(81166006)(7350300001)(50466002)(81156014)(68736007)(3846002)(6116002)(48376002)(6506006)(66066001)(86362001)(47776003)(53936002)(110136004)(50986999)(76176999)(5660300001)(6666003)(6486002)(2906002)(2950100002)(25786009)(42186005)(53416004)(6512007)(106356001)(101416001)(478600001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:D4xdCt8x+c3ITowLaAW6OH67V+z6h7QOagLJPPv?=
 =?us-ascii?Q?Rowom4YJCol193PoBfgoY8XLQjvGtkAcaiKlYoApQTEFsWhra+GW2jKryMcH?=
 =?us-ascii?Q?nXNTmujl6k2e1J0lyXTUXMqODeA4BzeSph+KmkNYdn83cNv472v7lEMnwemj?=
 =?us-ascii?Q?eUXOtYntrzge0l0j9UTcZl4hsoDL9y9pCPK5nZuU/+uxwo0t0/t2UTtKlsID?=
 =?us-ascii?Q?x/9ASFTyWzRGH88JkeNpcmsKuY+8wwRctJsT7xF60t/1bIpKlhoQamq+yxRJ?=
 =?us-ascii?Q?Ao4OBl7at7UmFMwF4ZbgNGb98KVHzbRPN9LJuR1ucfE62RtYUvKECCt7Rjo3?=
 =?us-ascii?Q?0/USRmdFnWESQHR2MBxjmTCgzvrG1U/LbU72Rmkx1vdpuuHmMCAtBdk/rcHG?=
 =?us-ascii?Q?whn/v+cErbIWZtIhxXmtorS+pHBoT/YveicbF/mVMpj7DP7y8infCDfv4wzb?=
 =?us-ascii?Q?acWscYcE2AF93F9uQVvpVjJRNsubLLNjl9uud/RjxMJFa6prFaofvuajAPNo?=
 =?us-ascii?Q?s98PoLIUblCxPl/dJq1QdAOuabV83JwBh0gv/ZTcvtuM9sUcKUAi4a5jOC+R?=
 =?us-ascii?Q?6EwtZz3kgAQh5ymdfduKqmCX7d77QOS1fJmnACqeMiG5yToNOrLjSkitpNnt?=
 =?us-ascii?Q?lcc8hhSqArYEGA71uiNQlLnhCB0MGjqfz2akSsKOSn5emoE1I6WDVL+z4qlO?=
 =?us-ascii?Q?nST9ESwbcGZRlPYiHK5fUv9K5eC2vpy5N23IIJiHAYc3vBoM/bKnBuDrScNV?=
 =?us-ascii?Q?s6ghA+FBSZcfHNTcTW4YxO4uB0TJaBkeCNrIGAmVfWkmAbP0CiDDKvJ18kDx?=
 =?us-ascii?Q?rrKB1DIpeRm2GteFx2lWcyucDE8lboqfQ+11tNVTL6kL4CV2AchDEX7FKYJZ?=
 =?us-ascii?Q?ZVbJ3av2s7nX4IhffBwKSL+aNLVv0ESXtU1OHkuAlwpnKuanFJgWdk3VLSh0?=
 =?us-ascii?Q?M5PxZekOdWkGPKaeMYYVtjkOJhLiwkq8SJnNBbV4rmKb05jR348qGpjfa8rS?=
 =?us-ascii?Q?fyok7TprNzObzgIxxes96jlwr24DDB2JloFFYLmaAECp2T9L5ZGLhRkYxgwG?=
 =?us-ascii?Q?3K401xjbAqcVmua181A0jnchWMZNl4qalU/r4wAvwgby/W5uOfg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:CNY6gUqD1tAxZSiLNToX2/7ERXoykAOsKBhPjpANFw03Ci0JitUpRT/DzOCrRy2biTcSQbzBJT5cOQeRFNyV8kRLJJnEW54FdkrwhIhLcTQS6md4S6YZ+MvBT4hYoUlZG4hOrB6sYqL4Xxs7U3UN9eFXFMZmF5xFAC0bFpdokvZyt9SupvAV2nmY0JuRbqCs97tN5ydfmXHY0XWicvJGOojpfCYHhkXIIckFpZsFQDA6JgW9NguSlKw0VuaZkFm7DK63UmkZ+2byPLBHRfSf9TgMrm/SWQe3u17uyN/NzSWo6Tx+0YYsf/YG+8LaaewXgGpaJdqOehkxra5doRSJBA==;5:KgPrs1dsGwicuAaN3y3tGzfifZMZrUMyqKihmf16WRH9snjkngVIDTuNNctBwdfpxPMpB7gxCjdulEstPvsYBKcvhez9lNg+DqaUUOPeKyHloeziwqcmF7KjjlAC2N80BezkDTMdDxoZEyUzBszJVw==;24:zKqfmti8Z3oVeNTLPCwQe2Jp+DxJpEnwhhcFLvYk/GS8obj6m2pu+Fa4PUxsHi1iFEZJrg0vbbKHUJkJYkZDBhYsBr7350Qlnn42XQ6Xdsc=;7:IoaMCzkTMoCGrjT6rPIPDW9Mg/ANn27Mwn6NQfl4ug/D7j2aHc/rnw1TWzRkLxrj4v7LCH2LCtnNOmK0yWpNeQ6ZwsID7Rmg6DXxYbQzr2WswPfEjUnoRHAutozY6A2+28Rlop35di7JAvqi2RISgEThfRQl7BkLhmu2IRnpXzKzXJMU51QaNSDn+DOVY5q29cRMkMXFgpVyZEqzdqNDeveZgXbeT8/e9m71NN9H+ww=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2017 15:42:55.9135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/watchdog/octeon-wdt-main.c | 134 +++----------------------------------
 drivers/watchdog/octeon-wdt-nmi.S  |  42 +++++++++---
 2 files changed, 44 insertions(+), 132 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index b5cdceb..fbdd484 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -73,6 +73,7 @@
 #include <asm/uasm.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-boot-vector.h>
 
 /* The count needed to achieve timeout_sec. */
 static unsigned int timeout_cnt;
@@ -104,122 +105,10 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static u32 nmi_stage1_insns[64] __initdata;
-/* We need one branch and therefore one relocation per target label. */
-static struct uasm_label labels[5] __initdata;
-static struct uasm_reloc relocs[5] __initdata;
-
-enum lable_id {
-	label_enter_bootloader = 1
-};
-
-/* Some CP0 registers */
-#define K0		26
-#define C0_CVMMEMCTL 11, 7
-#define C0_STATUS 12, 0
-#define C0_EBASE 15, 1
-#define C0_DESAVE 31, 0
+static struct cvmx_boot_vector_element *octeon_wdt_bootvector;
 
 void octeon_wdt_nmi_stage2(void);
 
-static void __init octeon_wdt_build_stage1(void)
-{
-	int i;
-	int len;
-	u32 *p = nmi_stage1_insns;
-#ifdef CONFIG_HOTPLUG_CPU
-	struct uasm_label *l = labels;
-	struct uasm_reloc *r = relocs;
-#endif
-
-	/*
-	 * For the next few instructions running the debugger may
-	 * cause corruption of k0 in the saved registers. Since we're
-	 * about to crash, nobody probably cares.
-	 *
-	 * Save K0 into the debug scratch register
-	 */
-	uasm_i_dmtc0(&p, K0, C0_DESAVE);
-
-	uasm_i_mfc0(&p, K0, C0_STATUS);
-#ifdef CONFIG_HOTPLUG_CPU
-	if (octeon_bootloader_entry_addr)
-		uasm_il_bbit0(&p, &r, K0, ilog2(ST0_NMI),
-			      label_enter_bootloader);
-#endif
-	/* Force 64-bit addressing enabled */
-	uasm_i_ori(&p, K0, K0, ST0_UX | ST0_SX | ST0_KX);
-	uasm_i_mtc0(&p, K0, C0_STATUS);
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (octeon_bootloader_entry_addr) {
-		uasm_i_mfc0(&p, K0, C0_EBASE);
-		/* Coreid number in K0 */
-		uasm_i_andi(&p, K0, K0, 0xf);
-		/* 8 * coreid in bits 16-31 */
-		uasm_i_dsll_safe(&p, K0, K0, 3 + 16);
-		uasm_i_ori(&p, K0, K0, 0x8001);
-		uasm_i_dsll_safe(&p, K0, K0, 16);
-		uasm_i_ori(&p, K0, K0, 0x0700);
-		uasm_i_drotr_safe(&p, K0, K0, 32);
-		/*
-		 * Should result in: 0x8001,0700,0000,8*coreid which is
-		 * CVMX_CIU_WDOGX(coreid) - 0x0500
-		 *
-		 * Now ld K0, CVMX_CIU_WDOGX(coreid)
-		 */
-		uasm_i_ld(&p, K0, 0x500, K0);
-		/*
-		 * If bit one set handle the NMI as a watchdog event.
-		 * otherwise transfer control to bootloader.
-		 */
-		uasm_il_bbit0(&p, &r, K0, 1, label_enter_bootloader);
-		uasm_i_nop(&p);
-	}
-#endif
-
-	/* Clear Dcache so cvmseg works right. */
-	uasm_i_cache(&p, 1, 0, 0);
-
-	/* Use K0 to do a read/modify/write of CVMMEMCTL */
-	uasm_i_dmfc0(&p, K0, C0_CVMMEMCTL);
-	/* Clear out the size of CVMSEG	*/
-	uasm_i_dins(&p, K0, 0, 0, 6);
-	/* Set CVMSEG to its largest value */
-	uasm_i_ori(&p, K0, K0, 0x1c0 | 54);
-	/* Store the CVMMEMCTL value */
-	uasm_i_dmtc0(&p, K0, C0_CVMMEMCTL);
-
-	/* Load the address of the second stage handler */
-	UASM_i_LA(&p, K0, (long)octeon_wdt_nmi_stage2);
-	uasm_i_jr(&p, K0);
-	uasm_i_dmfc0(&p, K0, C0_DESAVE);
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (octeon_bootloader_entry_addr) {
-		uasm_build_label(&l, p, label_enter_bootloader);
-		/* Jump to the bootloader and restore K0 */
-		UASM_i_LA(&p, K0, (long)octeon_bootloader_entry_addr);
-		uasm_i_jr(&p, K0);
-		uasm_i_dmfc0(&p, K0, C0_DESAVE);
-	}
-#endif
-	uasm_resolve_relocs(relocs, labels);
-
-	len = (int)(p - nmi_stage1_insns);
-	pr_debug("Synthesized NMI stage 1 handler (%d instructions)\n", len);
-
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < len; i++)
-		pr_debug("\t.word 0x%08x\n", nmi_stage1_insns[i]);
-	pr_debug("\t.set pop\n");
-
-	if (len > 32)
-		panic("NMI stage 1 handler exceeds 32 instructions, was %d\n",
-		      len);
-}
-
 static int cpu2core(int cpu)
 {
 #ifdef CONFIG_SMP
@@ -402,6 +291,8 @@ static int octeon_wdt_cpu_online(unsigned int cpu)
 
 	core = cpu2core(cpu);
 
+	octeon_wdt_bootvector[core].target_ptr = (u64)octeon_wdt_nmi_stage2;
+
 	/* Disable it before doing anything with the interrupts. */
 	ciu_wdog.u64 = 0;
 	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
@@ -544,6 +435,12 @@ static int __init octeon_wdt_init(void)
 	int ret;
 	u64 *ptr;
 
+	octeon_wdt_bootvector = cvmx_boot_vector_get();
+	if (!octeon_wdt_bootvector) {
+		pr_err("Error: Cannot allocate boot vector.\n");
+		return -ENOMEM;
+	}
+
 	/*
 	 * Watchdog time expiration length = The 16 bits of LEN
 	 * represent the most significant bits of a 24 bit decrementer
@@ -576,17 +473,6 @@ static int __init octeon_wdt_init(void)
 		return ret;
 	}
 
-	/* Build the NMI handler ... */
-	octeon_wdt_build_stage1();
-
-	/* ... and install it. */
-	ptr = (u64 *) nmi_stage1_insns;
-	for (i = 0; i < 16; i++) {
-		cvmx_write_csr(CVMX_MIO_BOOT_LOC_ADR, i * 8);
-		cvmx_write_csr(CVMX_MIO_BOOT_LOC_DAT, ptr[i]);
-	}
-	cvmx_write_csr(CVMX_MIO_BOOT_LOC_CFGX(0), 0x81fc0000);
-
 	cpumask_clear(&irq_enabled_cpus);
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "watchdog/octeon:online",
diff --git a/drivers/watchdog/octeon-wdt-nmi.S b/drivers/watchdog/octeon-wdt-nmi.S
index 8a900a5..97f6eb7 100644
--- a/drivers/watchdog/octeon-wdt-nmi.S
+++ b/drivers/watchdog/octeon-wdt-nmi.S
@@ -3,20 +3,40 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2007 Cavium Networks
+ * Copyright (C) 2007-2017 Cavium, Inc.
  */
 #include <asm/asm.h>
 #include <asm/regdef.h>
 
-#define SAVE_REG(r)	sd $r, -32768+6912-(32-r)*8($0)
+#define CVMSEG_BASE	-32768
+#define CVMSEG_SIZE	6912
+#define SAVE_REG(r)	sd $r, CVMSEG_BASE + CVMSEG_SIZE - ((32 - r) * 8)($0)
 
         NESTED(octeon_wdt_nmi_stage2, 0, sp)
 	.set 	push
 	.set 	noreorder
 	.set 	noat
-	/* Save all registers to the top CVMSEG. This shouldn't
+	/* Clear Dcache so cvmseg works right. */
+	cache	1,0($0)
+	/* Use K0 to do a read/modify/write of CVMMEMCTL */
+	dmfc0	k0, $11, 7
+	/* Clear out the size of CVMSEG	*/
+	dins	k0, $0, 0, 6
+	/* Set CVMSEG to its largest value */
+	ori	k0, k0, 0x1c0 | 54
+	/* Store the CVMMEMCTL value */
+	dmtc0	k0, $11, 7
+	/*
+	 * Restore K0 from the debug scratch register, it was saved in
+	 * the boot-vector code.
+	 */
+	dmfc0	k0, $31
+
+	/*
+	 * Save all registers to the top CVMSEG. This shouldn't
 	 * corrupt any state used by the kernel. Also all registers
-	 * should have the value right before the NMI. */
+	 * should have the value right before the NMI.
+	 */
 	SAVE_REG(0)
 	SAVE_REG(1)
 	SAVE_REG(2)
@@ -49,16 +69,22 @@
 	SAVE_REG(29)
 	SAVE_REG(30)
 	SAVE_REG(31)
+	/* Write zero to all CVMSEG locations per Core-15169 */
+	dli	a0, CVMSEG_SIZE - (33 * 8)
+1:	sd	zero, CVMSEG_BASE(a0)
+	daddiu	a0, a0, -8
+	bgez	a0, 1b
+	nop
 	/* Set the stack to begin right below the registers */
-	li	sp, -32768+6912-32*8
+	dli	sp, CVMSEG_BASE + CVMSEG_SIZE - (32 * 8)
 	/* Load the address of the third stage handler */
-	dla	a0, octeon_wdt_nmi_stage3
+	dla	$25, octeon_wdt_nmi_stage3
 	/* Call the third stage handler */
-	jal	a0
+	jal	$25
 	/* a0 is the address of the saved registers */
 	 move	a0, sp
 	/* Loop forvever if we get here. */
-1:	b	1b
+2:	b	2b
 	nop
 	.set pop
 	END(octeon_wdt_nmi_stage2)
-- 
2.1.4
