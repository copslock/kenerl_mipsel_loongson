Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:52:28 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42849 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825990Ab2KEWr61p4Hn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:58 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa7so3934314pbc.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1bdZJOJFyYYe3TNi395CJvw+NxzxEeeJWLV7JAFL6Og=;
        b=AIjPq8XYet9dz58VUHqEj8ODrvi2kBJdwDm82I+kl5Op6Z5XoxIHFhhjVjERTM/fmZ
         NHemXX1nz7aDbEmv8TpswcOVQ9FvnlTn32JxPDBG23A2ArdZwJiQdhUKuM6riTse8vq1
         LJUPU7mfigQbkCjzPnEZf4EADOo2OGXJ4dnRbQLH3t+A8nHBbtCOr4YZ/eBgfuEeAAFc
         DevtFLiCw+KlzGbTZ7IQnwO+gwGX1J0+n75aQw/B7MX337dy8TLBw03RhFezM8PurhcY
         sspM+kO0FddD0VZxIwh/wS3A9nKyjcGt1FAfLWQ64b5B9Sx0sgmeeth/li/oG3HX3jaW
         HpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=1bdZJOJFyYYe3TNi395CJvw+NxzxEeeJWLV7JAFL6Og=;
        b=B7DFHinTpeP1Ymfcoh6AKRDAfuP3e7cSMHrFYI/9m0VMW7Nz399PZZOUDXr9uR7Ys+
         oey9wUzREuSeMPgzRYXGSmvh0aYOnpA0Az1VKumPZVdkGvvmwdSQ9qaQI/TZtMLgzBWF
         v9JscpDIhMcb8S9CEL6MUggQDai2CxBRNA6/nqIGKHOKZvlJsscmMN983OTCcB9PtWsN
         kdkkTLJ+zqe/m4qr89RjRC1B9bybFb6bPovniLEz66G0qw1sixA5FbYkJTGf2BywPyvP
         SOcrEpUPzDsph6xe+3vDDV0n4u/I+awRoA2F2f/mI79/D5M0JMNJTKxXZ05HjkwBBx6e
         aMBQ==
Received: by 10.68.195.165 with SMTP id if5mr2589992pbc.131.1352155677624;
        Mon, 05 Nov 2012 14:47:57 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:56 -0800 (PST)
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 15/16] mm: use vm_unmapped_area() on sparc32 architecture
Date:   Mon,  5 Nov 2012 14:47:12 -0800
Message-Id: <1352155633-8648-16-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQkJCUAijEUIEo5aYETz2x//1lXf0DRc54OTbzlnKyqpPseKou7oCfV/jSMgcpGz3DGPtj6h2xYYooLOfDQWJjoxaqCci6JuprsjJRGU00VgrmerC5S823wJ+J9hkGiM1VsltBrbKJyDmF/expZA6v9ocJpwCLt2RDxxxs+iuSEFDx3huGpDG4zfccbJ9wDC26YOQ0rqarPIPrRWuENUKMV9OJW7+w==
X-archive-position: 34885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walken@google.com
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

Update the sparc32 arch_get_unmapped_area function to make use of
vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/sparc/kernel/sys_sparc_32.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 0c9b31b22e07..653899849b27 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -39,6 +39,7 @@ asmlinkage unsigned long sys_getpagesize(void)
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct * vmm;
+	struct vm_unmapped_area_info info;
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -56,21 +57,14 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	if (!addr)
 		addr = TASK_UNMAPPED_BASE;
 
-	if (flags & MAP_SHARED)
-		addr = COLOUR_ALIGN(addr);
-	else
-		addr = PAGE_ALIGN(addr);
-
-	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - PAGE_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <= vmm->vm_start)
-			return addr;
-		addr = vmm->vm_end;
-		if (flags & MAP_SHARED)
-			addr = COLOUR_ALIGN(addr);
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = addr;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = (flags & MAP_SHARED) ?
+		(PAGE_MASK & (SHMLBA - 1)) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
+	return vm_unmapped_area(&info);
 }
 
 /*
-- 
1.7.7.3
