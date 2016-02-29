Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Feb 2016 12:41:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53515 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007117AbcB2Llz4x61z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Feb 2016 12:41:55 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 795321F74B3FF;
        Mon, 29 Feb 2016 11:41:47 +0000 (GMT)
Received: from govindraj.kl.imgtec.org (192.168.167.98) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 29 Feb 2016 11:41:49 +0000
From:   Govindraj Raja <Govindraj.Raja@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Govindraj Raja <Govindraj.Raja@imgtec.com>,
        <stable@vger.kernel.org>, Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH v3] mips: scache: fix scache init with invalid line size.
Date:   Mon, 29 Feb 2016 11:41:20 +0000
Message-ID: <1456746080-29232-1-git-send-email-Govindraj.Raja@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.98]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Govindraj.Raja@imgtec.com
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

In current scache init cache line_size is determined from
cpu config register, however if there there no scache
then mips_sc_probe_cm3 function populates a invalid line_size of 2.

The invalid line_size can cause a NULL pointer deference
during r4k_dma_cache_inv as r4k_blast_scache is populated
based on line_size. Scache line_size of 2 is invalid option in
r4k_blast_scache_setup.

This issue was faced during a MIPS I6400 based virtual platform bring up
where scache was not available in virtual platform model.

Changes from v2:
	https://patchwork.linux-mips.org/patch/12243/
	Fix return value, ensure function returns true only if
	scache is identified.

Changes from v1:
	https://patchwork.linux-mips.org/patch/12126/
	Avoid clearing of MIPS_CACHE_NOT_PRESENT if scache is absent

Fixes: 7d53e9c4cd21("MIPS: CM3: Add support for CM3 L2 cache.")
Cc: <stable@vger.kernel.org> # v4.2+
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hartley <James.Hartley@imgtec.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
---
 arch/mips/mm/sc-mips.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 2496475..91dec32 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -164,11 +164,13 @@ static int __init mips_sc_probe_cm3(void)
 
 	sets = cfg & CM_GCR_L2_CONFIG_SET_SIZE_MSK;
 	sets >>= CM_GCR_L2_CONFIG_SET_SIZE_SHF;
-	c->scache.sets = 64 << sets;
+	if (sets)
+		c->scache.sets = 64 << sets;
 
 	line_sz = cfg & CM_GCR_L2_CONFIG_LINE_SIZE_MSK;
 	line_sz >>= CM_GCR_L2_CONFIG_LINE_SIZE_SHF;
-	c->scache.linesz = 2 << line_sz;
+	if (line_sz)
+		c->scache.linesz = 2 << line_sz;
 
 	assoc = cfg & CM_GCR_L2_CONFIG_ASSOC_MSK;
 	assoc >>= CM_GCR_L2_CONFIG_ASSOC_SHF;
@@ -176,9 +178,12 @@ static int __init mips_sc_probe_cm3(void)
 	c->scache.waysize = c->scache.sets * c->scache.linesz;
 	c->scache.waybit = __ffs(c->scache.waysize);
 
-	c->scache.flags &= ~MIPS_CACHE_NOT_PRESENT;
+	if (c->scache.linesz) {
+		c->scache.flags &= ~MIPS_CACHE_NOT_PRESENT;
+		return 1;
+	}
 
-	return 1;
+	return 0;
 }
 
 static inline int __init mips_sc_probe(void)
-- 
2.5.0
