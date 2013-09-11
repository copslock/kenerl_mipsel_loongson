Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 22:02:06 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:53269 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823097Ab3IKUCAQ7kVI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Sep 2013 22:02:00 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VJqbp-00010X-DM; Wed, 11 Sep 2013 15:01:53 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH] MIPS: Fix errata for some 1074K cores.
Date:   Wed, 11 Sep 2013 15:01:48 -0500
Message-Id: <1378929708-7253-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Fixes errata E16 for some problems on 1074K cores.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/mm/c-r4k.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index f749f68..8d3ed32 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -786,12 +786,12 @@ static inline void alias_74k_erratum(struct cpuinfo_mips *c)
 	 * aliases. In this case it is better to treat the cache as always
 	 * having aliases.
 	 */
-	if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
-		c->dcache.flags |= MIPS_CACHE_VTAG;
-	if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
-		write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
-	if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
-	    ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {
+	if ((c->processor_id & 0xff00) != PRID_IMP_1074K) {
+		if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+		if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+	} else if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0)) {
 		c->dcache.flags |= MIPS_CACHE_VTAG;
 		write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
 	}
-- 
1.7.9.5
