Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 15:18:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31756 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010718AbcAROSdJXH3m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 15:18:33 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 7710FF053855F;
        Mon, 18 Jan 2016 14:18:24 +0000 (GMT)
Received: from govindraj.kl.imgtec.org (192.168.167.98) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 18 Jan 2016 14:18:27 +0000
From:   Govindraj Raja <Govindraj.Raja@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>
Subject: [PATCH] mips: scache: fix scache init with invalid line size.
Date:   Mon, 18 Jan 2016 14:18:26 +0000
Message-ID: <1453126706-24299-1-git-send-email-Govindraj.Raja@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.98]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51196
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
during r4k_dma_cache_inv as r4k_blast_scache is populated based on
line_size. Scache line_size of 2 is invalid option in r4k_blast_scache_setup.

This issue was faced during a MIPS I6400 based virtual platform bring up
where scache was not available in virtual platform model.

Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
---
 arch/mips/mm/sc-mips.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 3bd0597..6e422bc 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -168,7 +168,8 @@ static int __init mips_sc_probe_cm3(void)
 
 	line_sz = cfg & CM_GCR_L2_CONFIG_LINE_SIZE_MSK;
 	line_sz >>= CM_GCR_L2_CONFIG_LINE_SIZE_SHF;
-	c->scache.linesz = 2 << line_sz;
+	if (line_sz)
+		c->scache.linesz = 2 << line_sz;
 
 	assoc = cfg & CM_GCR_L2_CONFIG_ASSOC_MSK;
 	assoc >>= CM_GCR_L2_CONFIG_ASSOC_SHF;
-- 
2.5.0
