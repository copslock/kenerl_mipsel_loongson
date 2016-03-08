Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2016 01:04:15 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:52286 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006883AbcCHAENwVNu3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Mar 2016 01:04:13 +0100
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2554D1D;
        Tue,  8 Mar 2016 00:04:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 4.4 62/74] MIPS: scache: Fix scache init with invalid line size.
Date:   Mon,  7 Mar 2016 16:03:27 -0800
Message-Id: <20160308000317.270430835@linuxfoundation.org>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <20160308000315.294406921@linuxfoundation.org>
References: <20160308000315.294406921@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Govindraj Raja <govindraj.raja@imgtec.com>

commit 56fa81fc9a5445938f3aa2e63d15ab63dc938ad6 upstream.

In current scache init cache line_size is determined from
cpu config register, however if there there no scache
then mips_sc_probe_cm3 function populates a invalid line_size of 2.

The invalid line_size can cause a NULL pointer deference
during r4k_dma_cache_inv as r4k_blast_scache is populated
based on line_size. Scache line_size of 2 is invalid option in
r4k_blast_scache_setup.

This issue was faced during a MIPS I6400 based virtual platform bring up
where scache was not available in virtual platform model.

Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
Fixes: 7d53e9c4cd21("MIPS: CM3: Add support for CM3 L2 cache.")
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hartley <James.Hartley@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12710/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/sc-mips.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -164,11 +164,13 @@ static int __init mips_sc_probe_cm3(void
 
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
@@ -176,9 +178,12 @@ static int __init mips_sc_probe_cm3(void
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
 
 void __weak platform_early_l2_init(void)
