Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 17:41:01 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:51952 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823064Ab3FRPk5WlOGk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 17:40:57 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r5IFeoi6013745
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 18 Jun 2013 08:40:50 -0700 (PDT)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.2.342.3; Tue, 18 Jun 2013 08:40:49 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] mips: delete floating ".previous" section statements
Date:   Tue, 18 Jun 2013 11:40:47 -0400
Message-ID: <1371570047-32492-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

Commit "mips: delete __cpuinit/__CPUINIT usage from MIPS code"
deleted the __CPUINIT instances, however there were two instances
of ".previous" that were being used in paring with the __CPUINIT
(i.e. section ".cpuinit.text").

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Feel free to squash this into the larger commit; sorry I didn't
 notice it 15m earlier...  :(  Oh well.]

 arch/mips/kernel/bmips_vec.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index f739aed..596bf2f 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -186,7 +186,6 @@ bmips_reset_nmi_vec_end:
 END(bmips_reset_nmi_vec)
 
 	.set	pop
-	.previous
 
 /***********************************************************************
  * CPU1 warm restart vector (used for second and subsequent boots).
@@ -247,5 +246,3 @@ LEAF(bmips_enable_xks01)
 	jr	ra
 
 END(bmips_enable_xks01)
-
-	.previous
-- 
1.8.1.2
