Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 20:16:41 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42592 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903452Ab2HPSQf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2012 20:16:35 +0200
Received: by pbbrq8 with SMTP id rq8so2036115pbb.36
        for <multiple recipients>; Thu, 16 Aug 2012 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=w3Tokz21YM55dmrmpD/SIFo8zNpOxfwZxsxLBqx5cUI=;
        b=M9sUdkM7W8O5bAaTq3jN4Nzs0rKNl8Dc5MrgRBYZNl/NPMBcKVfVnxSqDpr3LPlb/I
         h4auET7DcdReiB9CuPZSWEy3R9xMlnfJKWCMqj/xP0KZ2xnML7RlKRnzWCTtMSEEP65z
         ZCjlVPwGLlj+nT+wpeZNdkEQWEYgCBmYG84gw2Byzm/vd29s0HkRc+IY7E2fNcqbtWQY
         LJ3rZomXC8xST8c+KO4z9h0CL9tzIDIsQ1e1lkMnUMDwUruqmioTsDilWePp+YCbQw4a
         1FBzhyYDotqor54U8GvhlPs59BC3vRBvyyzPNNGt4UPjo2KbpOOvh1OztC8PbvWG3VGw
         j3ag==
Received: by 10.68.229.2 with SMTP id sm2mr5134722pbc.57.1345140988170;
        Thu, 16 Aug 2012 11:16:28 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id qo8sm3132068pbb.19.2012.08.16.11.16.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Aug 2012 11:16:27 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7GIFPCI000337;
        Thu, 16 Aug 2012 11:15:25 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7GIFOPb000336;
        Thu, 16 Aug 2012 11:15:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Optimize pgd_init and pmd_init
Date:   Thu, 16 Aug 2012 11:15:22 -0700
Message-Id: <1345140922-301-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.2
X-archive-position: 34224
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

From: David Daney <ddaney@caviumnetworks.com>

On a dual issue processor GCC generates code that saves a couple of
clock cycles per loop if we rearrange things slightly.  Checking for
p != end saves a SLTU per loop, moving the increment to the middle can
let it dual issue on multi-issue processors.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/pgtable-64.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index cda4e30..2540779 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -26,17 +26,17 @@ void pgd_init(unsigned long page)
  	p = (unsigned long *) page;
 	end = p + PTRS_PER_PGD;
 
-	while (p < end) {
+	do {
 		p[0] = entry;
 		p[1] = entry;
 		p[2] = entry;
 		p[3] = entry;
 		p[4] = entry;
-		p[5] = entry;
-		p[6] = entry;
-		p[7] = entry;
 		p += 8;
-	}
+		p[-3] = entry;
+		p[-2] = entry;
+		p[-1] = entry;
+	} while (p != end);
 }
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -47,17 +47,17 @@ void pmd_init(unsigned long addr, unsigned long pagetable)
  	p = (unsigned long *) addr;
 	end = p + PTRS_PER_PMD;
 
-	while (p < end) {
+	do {
 		p[0] = pagetable;
 		p[1] = pagetable;
 		p[2] = pagetable;
 		p[3] = pagetable;
 		p[4] = pagetable;
-		p[5] = pagetable;
-		p[6] = pagetable;
-		p[7] = pagetable;
 		p += 8;
-	}
+		p[-3] = pagetable;
+		p[-2] = pagetable;
+		p[-1] = pagetable;
+	} while (p != end);
 }
 #endif
 
-- 
1.7.11.2
