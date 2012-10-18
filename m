Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2012 02:20:49 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45168 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823091Ab2JRAUsQgAfG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Oct 2012 02:20:48 +0200
Received: by mail-pb0-f49.google.com with SMTP id xa7so8046402pbc.36
        for <multiple recipients>; Wed, 17 Oct 2012 17:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wnovXh+/dC0aSqLFj1dXaiSEUJM7/+yNvklxkaV2zx0=;
        b=APIYuYuzKuqQvDilWgzEDglaYm3j4mBsYrQ1Mpy3553mB33SpWU+p2NlElfvuKQkDI
         4IfckBYtxTJXlPwxBXmSM5jOegzQsSxxyfQpMy+s8LEMoBD69tpk5R1CW8eIEfnTPmnL
         a1Zrol6VqZ5L77hEDcNVGdLaYXldUJ1vCrKUuB86UO29EpPXlmmNMSejFc5zNiQLj5tc
         6RWrHKBchQlxj4GkPExQBsIaj8En8J2j+rkFLV/44X47fVbRnuG/n8BaickgGLlZax6J
         COCQ7of7MMbpOR5pGP61wvn8yqdb6oUbrOLv1A97VwxO+XtjqNY73by60a3/RmPBlNmW
         /4Ug==
Received: by 10.68.225.5 with SMTP id rg5mr60327151pbc.73.1350519641713;
        Wed, 17 Oct 2012 17:20:41 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pw9sm13243163pbb.42.2012.10.17.17.20.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Oct 2012 17:20:40 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q9I0KLlZ004616;
        Wed, 17 Oct 2012 17:20:21 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q9I0KL1G004615;
        Wed, 17 Oct 2012 17:20:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Remove redundant TLB invalidate from pmdp_splitting_flush().
Date:   Wed, 17 Oct 2012 17:20:20 -0700
Message-Id: <1350519620-4582-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 34717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/pgtable-64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index 6c9a477..5408bb5 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -71,7 +71,7 @@ void pmdp_splitting_flush(struct vm_area_struct *vma,
 	if (!pmd_trans_splitting(*pmdp)) {
 		pmd_t pmd = pmd_mksplitting(*pmdp);
 		set_pmd_at(vma->vm_mm, address, pmdp, pmd);
-		flush_tlb_range(vma, address, address + HPAGE_SIZE);
+		/* TLB already flushed by set_pmd_at() */
 	}
 }
 
-- 
1.7.11.7
