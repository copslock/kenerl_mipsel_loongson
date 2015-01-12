Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 08:08:56 +0100 (CET)
Received: from jaguar.aricent.com ([180.151.2.24]:41161 "EHLO
        jaguar.aricent.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014479AbbALHII6f1vy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 08:08:08 +0100
Received: from jaguar.aricent.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 050A1218BA0;
        Mon, 12 Jan 2015 12:38:02 +0530 (IST)
Received: from GUREXHT01.ASIAN.AD.ARICENT.COM (unknown [10.203.171.136])
        by jaguar.aricent.com (Postfix) with ESMTPS id E07CF218B78;
        Mon, 12 Jan 2015 12:38:01 +0530 (IST)
Received: from imsseuq.aricent.com (10.203.171.248) by
 GUREXHT01.ASIAN.AD.ARICENT.COM (10.203.171.136) with Microsoft SMTP Server id
 8.3.342.0; Mon, 12 Jan 2015 12:38:00 +0530
Received: from h2512.localdomain ([172.16.116.228])     by imsseuq.aricent.com
 (8.13.1/8.13.1) with ESMTP id t0C6VBrE019509;  Mon, 12 Jan 2015 12:01:34 +0530
From:   Abhishek Paliwal <abhishek.paliwal@aricent.com>
To:     <kexin.hao@windriver.com>, <bo.liu@windriver.com>
CC:     Chandrakala.Chavva@caviumnetworks.com, rakesh.garg@aricent.com,
        Abhishek Paliwal <abhishek.paliwal@aricent.com>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        kvm@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4/9] MIPS Add minimal support for OCTEON3 to c-r4k.c
Date:   Mon, 12 Jan 2015 12:36:20 +0530
Message-ID: <1421046385-2535-5-git-send-email-abhishek.paliwal@aricent.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
References: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
Return-Path: <abhishek.paliwal@aricent.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhishek.paliwal@aricent.com
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

commit  18a8cd63c0d800bbc8b91f03054fcb13d308f6ec upstream

These are needed to boot a generic mips64r2 kernel on OCTEONIII.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: James Hogan <james.hogan@imgtec.com>
Cc: kvm@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/7003/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Abhishek Paliwal <abhishek.paliwal@aricent.com>
---
 arch/mips/include/asm/r4kcache.h |  2 ++
 arch/mips/mm/c-r4k.c             | 47 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index c84cadd..3be43ca 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -420,6 +420,8 @@ __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32,
 __BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 64, )
 __BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64, )
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64, )
+__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 128, )
+__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 128, )
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128, )

 __BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 16, )
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index bc941f8..15dfc4a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -109,18 +109,33 @@ static inline void r4k_blast_dcache_page_dc64(unsigned long addr)
        blast_dcache64_page(addr);
 }

+static inline void r4k_blast_dcache_page_dc128(unsigned long addr)
+{
+       blast_dcache128_page(addr);
+}
+
 static void r4k_blast_dcache_page_setup(void)
 {
        unsigned long  dc_lsize = cpu_dcache_line_size();

-       if (dc_lsize == 0)
+       switch (dc_lsize) {
+       case 0:
                r4k_blast_dcache_page = (void *)cache_noop;
-       else if (dc_lsize == 16)
+               break;
+       case 16:
                r4k_blast_dcache_page = blast_dcache16_page;
-       else if (dc_lsize == 32)
+               break;
+       case 32:
                r4k_blast_dcache_page = r4k_blast_dcache_page_dc32;
-       else if (dc_lsize == 64)
+               break;
+       case 64:
                r4k_blast_dcache_page = r4k_blast_dcache_page_dc64;
+               break;
+       case 128:
+               r4k_blast_dcache_page = r4k_blast_dcache_page_dc128;
+               break;
+       default:
+               break;
 }

 static void (* r4k_blast_dcache_page_indexed)(unsigned long addr);
@@ -137,6 +152,8 @@ static void r4k_blast_dcache_page_indexed_setup(void)
                r4k_blast_dcache_page_indexed = blast_dcache32_page_indexed;
        else if (dc_lsize == 64)
                r4k_blast_dcache_page_indexed = blast_dcache64_page_indexed;
+       else if (dc_lsize == 128)
+               r4k_blast_dcache_page_indexed = blast_dcache128_page_indexed;
 }

 void (* r4k_blast_dcache)(void);
@@ -154,6 +171,8 @@ static void r4k_blast_dcache_setup(void)
                r4k_blast_dcache = blast_dcache32;
        else if (dc_lsize == 64)
                r4k_blast_dcache = blast_dcache64;
+       else if (dc_lsize == 128)
+               r4k_blast_dcache = blast_dcache128;
 }

 /* force code alignment (used for TX49XX_ICACHE_INDEX_INV_WAR) */
@@ -243,6 +262,8 @@ static void r4k_blast_icache_page_setup(void)
                r4k_blast_icache_page = blast_icache32_page;
        else if (ic_lsize == 64)
                r4k_blast_icache_page = blast_icache64_page;
+       else if (ic_lsize == 128)
+               r4k_blast_icache_page = blast_icache128_page;
 }


@@ -295,6 +316,8 @@ static void r4k_blast_icache_setup(void)
                        r4k_blast_icache = blast_icache32;
        } else if (ic_lsize == 64)
                r4k_blast_icache = blast_icache64;
+       else if (ic_lsize == 128)
+               r4k_blast_icache = blast_icache128;
 }

 static void (* r4k_blast_scache_page)(unsigned long addr);
@@ -1010,6 +1033,21 @@ static void probe_pcache(void)
                c->dcache.waybit = 0;
                break;

+       case CPU_CAVIUM_OCTEON3:
+               /* For now lie about the number of ways. */
+               c->icache.linesz = 128;
+               c->icache.sets = 16;
+               c->icache.ways = 8;
+               c->icache.flags |= MIPS_CACHE_VTAG;
+               icache_size = c->icache.sets * c->icache.ways * c->icache.linesz;
+
+               c->dcache.linesz = 128;
+               c->dcache.ways = 8;
+               c->dcache.sets = 8;
+               dcache_size = c->dcache.sets * c->dcache.ways * c->dcache.linesz;
+               c->options |= MIPS_CPU_PREFETCH;
+               break;
+
        default:
                if (!(config & MIPS_CONF_M))
                        panic("Don't know how to probe P-caches on this cpu.");
@@ -1291,6 +1329,7 @@ static void setup_scache(void)
                loongson2_sc_init();
                return;

+       case CPU_CAVIUM_OCTEON3:
        case CPU_XLP:
                /* don't need to worry about L2, fully coherent */
                return;
--
1.8.1.4



"DISCLAIMER: This message is proprietary to Aricent and is intended solely for the use of the individual to whom it is addressed. It may contain privileged or confidential information and should not be circulated or used for any purpose other than for what it is intended. If you have received this message in error, please notify the originator immediately. If you are not the intended recipient, you are notified that you are strictly prohibited from using, copying, altering, or disclosing the contents of this message. Aricent accepts no responsibility for loss or damage arising from the use of the information transmitted by this email including damage from virus."
