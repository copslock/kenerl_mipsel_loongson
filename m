Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 00:08:57 +0200 (CEST)
Received: from mail-bn1lp0139.outbound.protection.outlook.com ([207.46.163.139]:49654
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816207AbaE1WIzpfaz8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 00:08:55 +0200
Received: from alberich.caveonetworks.com (31.213.222.82) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 21:54:02 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 06/13] MIPS: Add minimal support for OCTEON3 to c-r4k.c
Date:   Wed, 28 May 2014 23:52:09 +0200
Message-ID: <1401313936-11867-7-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: AMSPR01CA013.eurprd01.prod.exchangelabs.com
 (10.255.167.158) To BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(69596002)(99396002)(76482001)(46102001)(77156001)(50466002)(85852003)(50226001)(89996001)(83072002)(53416003)(102836001)(104166001)(101416001)(80022001)(92566001)(64706001)(92726001)(79102001)(19580395003)(83322001)(19580405001)(31966008)(74502001)(74662001)(36756003)(33646001)(86362001)(66066001)(21056001)(81342001)(87286001)(93916002)(62966002)(4396001)(77982001)(48376002)(50986999)(76176999)(87976001)(20776003)(81542001)(42186004)(81156002)(88136002)(47776003);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB386;H:alberich.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

From: David Daney <david.daney@cavium.com>

These are needed to boot a generic mips64r2 kernel on OCTEONIII.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/include/asm/r4kcache.h |    2 ++
 arch/mips/mm/c-r4k.c             |   48 ++++++++++++++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 4 deletions(-)

[andreas.herrmann:
  * Remove R4600_HIT_CACHEOP_WAR_IMPL from r4k_blast_dcache_page_dc128()
  * Use switch statement in r4k_blast_dcache_page_setup()]

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index fe8d1b6..0b8bd28 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -523,6 +523,8 @@ __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32,
 __BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 64, )
 __BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64, )
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64, )
+__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 128, )
+__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 128, )
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128, )
 
 __BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 16, )
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 5c21282..3eb7270 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -108,18 +108,34 @@ static inline void r4k_blast_dcache_page_dc64(unsigned long addr)
 	blast_dcache64_page(addr);
 }
 
+static inline void r4k_blast_dcache_page_dc128(unsigned long addr)
+{
+	blast_dcache128_page(addr);
+}
+
 static void r4k_blast_dcache_page_setup(void)
 {
 	unsigned long  dc_lsize = cpu_dcache_line_size();
 
-	if (dc_lsize == 0)
+	switch (dc_lsize) {
+	case 0:
 		r4k_blast_dcache_page = (void *)cache_noop;
-	else if (dc_lsize == 16)
+		break;
+	case 16:
 		r4k_blast_dcache_page = blast_dcache16_page;
-	else if (dc_lsize == 32)
+		break;
+	case 32:
 		r4k_blast_dcache_page = r4k_blast_dcache_page_dc32;
-	else if (dc_lsize == 64)
+		break;
+	case 64:
 		r4k_blast_dcache_page = r4k_blast_dcache_page_dc64;
+		break;
+	case 128:
+		r4k_blast_dcache_page = r4k_blast_dcache_page_dc128;
+		break;
+	default:
+		break;
+	}
 }
 
 #ifndef CONFIG_EVA
@@ -158,6 +174,8 @@ static void r4k_blast_dcache_page_indexed_setup(void)
 		r4k_blast_dcache_page_indexed = blast_dcache32_page_indexed;
 	else if (dc_lsize == 64)
 		r4k_blast_dcache_page_indexed = blast_dcache64_page_indexed;
+	else if (dc_lsize == 128)
+		r4k_blast_dcache_page_indexed = blast_dcache128_page_indexed;
 }
 
 void (* r4k_blast_dcache)(void);
@@ -175,6 +193,8 @@ static void r4k_blast_dcache_setup(void)
 		r4k_blast_dcache = blast_dcache32;
 	else if (dc_lsize == 64)
 		r4k_blast_dcache = blast_dcache64;
+	else if (dc_lsize == 128)
+		r4k_blast_dcache = blast_dcache128;
 }
 
 /* force code alignment (used for TX49XX_ICACHE_INDEX_INV_WAR) */
@@ -264,6 +284,8 @@ static void r4k_blast_icache_page_setup(void)
 		r4k_blast_icache_page = blast_icache32_page;
 	else if (ic_lsize == 64)
 		r4k_blast_icache_page = blast_icache64_page;
+	else if (ic_lsize == 128)
+		r4k_blast_icache_page = blast_icache128_page;
 }
 
 #ifndef CONFIG_EVA
@@ -337,6 +359,8 @@ static void r4k_blast_icache_setup(void)
 			r4k_blast_icache = blast_icache32;
 	} else if (ic_lsize == 64)
 		r4k_blast_icache = blast_icache64;
+	else if (ic_lsize == 128)
+		r4k_blast_icache = blast_icache128;
 }
 
 static void (* r4k_blast_scache_page)(unsigned long addr);
@@ -1093,6 +1117,21 @@ static void probe_pcache(void)
 		c->dcache.waybit = 0;
 		break;
 
+	case CPU_CAVIUM_OCTEON3:
+		/* For now lie about the number of ways. */
+		c->icache.linesz = 128;
+		c->icache.sets = 16;
+		c->icache.ways = 8;
+		c->icache.flags |= MIPS_CACHE_VTAG;
+		icache_size = c->icache.sets * c->icache.ways * c->icache.linesz;
+
+		c->dcache.linesz = 128;
+		c->dcache.ways = 8;
+		c->dcache.sets = 8;
+		dcache_size = c->dcache.sets * c->dcache.ways * c->dcache.linesz;
+		c->options |= MIPS_CPU_PREFETCH;
+		break;
+
 	default:
 		if (!(config & MIPS_CONF_M))
 			panic("Don't know how to probe P-caches on this cpu.");
@@ -1413,6 +1452,7 @@ static void setup_scache(void)
 		loongson3_sc_init();
 		return;
 
+	case CPU_CAVIUM_OCTEON3:
 	case CPU_XLP:
 		/* don't need to worry about L2, fully coherent */
 		return;
-- 
1.7.9.5
