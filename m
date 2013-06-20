Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 17:37:20 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:44876 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823049Ab3FTPgyeao7T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 17:36:54 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1Upgum-0004L9-ET; Thu, 20 Jun 2013 10:36:48 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH v2] MIPS: malta: Update GCMP detection.
Date:   Thu, 20 Jun 2013 10:36:42 -0500
Message-Id: <1371742602-10172-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37062
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

Add GCMP detection for IASim Marvell chip emulation support.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
Changes in v2: Remove internal gerrit ID from commit message.

 arch/mips/mti-malta/malta-int.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 0a1339a..c69da37 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -422,8 +422,10 @@ static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
  */
 int __init gcmp_probe(unsigned long addr, unsigned long size)
 {
-	if (mips_revision_sconid != MIPS_REVISION_SCON_ROCIT) {
+	if ((mips_revision_sconid != MIPS_REVISION_SCON_ROCIT)  &&
+	    (mips_revision_sconid != MIPS_REVISION_SCON_GT64120)) {
 		gcmp_present = 0;
+		pr_debug("GCMP NOT present\n");
 		return gcmp_present;
 	}
 
-- 
1.7.2.5
