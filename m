Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:49:19 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42833 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825983Ab2KEWrmfsWKC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:42 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so3945717pad.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KhM51IoX/o53wwywoSj3nTglzSRnF8pnxair4tdjvHI=;
        b=HFqY9qMdauQ47zYh8g4nyssr3mmZf+hVzCY+ZD8LgxdRmfUmQTvs7mLZP8JyNqTHng
         +N83Kg/lq8g5qzKmtOQkrYi+uNWI4lzhqhZmW/Av0SZGBfSyWB92DEUgynVNaBEAFYv4
         2AAoJ1XnAnd8/0LkJvH2K/QK1nz5KtcaFGjL/obg7pU1DXNr4fY6iKRkXVKUWK/36pJ3
         A7c51FpE51O4AbAlbQPUucG5OwnumeEXrmdvLvwCxhB2k53flgNiyvX7ueF58fv93Y5K
         5TtFO+dqpr93Iw9fTgf7LDvy5K+Bz+QG8hHW7M9J0frxwSOmw8h5eFF5/sr1/LT6TluO
         LRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=KhM51IoX/o53wwywoSj3nTglzSRnF8pnxair4tdjvHI=;
        b=ekMeOdvC/mzhc67+IWYBQoEFPNvJ+gpl6ls45eHkz2FULOsHB+vfLHpN9CQDmJyLZI
         aNyzrD3qJl8B6wu40rLrU90HfPFPYmMmW2Vn2rmv2Q7U2kjvreV8dbkPX2CAZSxpD9MS
         +EXXZOwfdKQxkR0+KC5mfmuYHLwJZ2fTeCmhPUNa6ohBDrIuXMHY5eBMXiHu8IPTBDEc
         /Nz5eUm57mLB/0P/wvSDVcz7TdA3SeuVPaTeoKG18Ek1dYKjYpza8uxDkttWCtfP3KaI
         MFSZbPv092M6dTsaYsAp8UH8wBxJg+TLznTt9NS8C6OxcX9EYZrIfl9/j34lMPLSGxaH
         weqQ==
Received: by 10.66.78.231 with SMTP id e7mr32396375pax.44.1352155656174;
        Mon, 05 Nov 2012 14:47:36 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:35 -0800 (PST)
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
Subject: [PATCH 03/16] mm: check rb_subtree_gap correctness
Date:   Mon,  5 Nov 2012 14:47:00 -0800
Message-Id: <1352155633-8648-4-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQmWC2xoqT87/4CVhTjLPaIf4H+y81UzpT1QnGJ5RiBneC8YUACOMyrf/zpJ1yEZSJSqX+a5eIQAGk6MVt0pqPq6B2CDqn011q1SjpmVA3NFAhkPuZGFgp3knNS4mjmm4acdJ+FLf0sUIAj8SKmIezELFzCXzQOvUMZLBdbBjhapmNqijmin7Mahmwj1SdRqN5r+ZBcgbjcyyNvz7x1ZLcssIyjUww==
X-archive-position: 34875
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

When CONFIG_DEBUG_VM_RB is enabled, check that rb_subtree_gap is
correctly set for every vma and that mm->highest_vm_end is also correct.

Also add an explicit 'bug' variable to track if browse_rb() detected any
invalid condition.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Rik van Riel <riel@redhat.com>

---
 mm/mmap.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2de8bcfe859d..769a09cc71af 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -365,7 +365,7 @@ static void vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
 #ifdef CONFIG_DEBUG_VM_RB
 static int browse_rb(struct rb_root *root)
 {
-	int i = 0, j;
+	int i = 0, j, bug = 0;
 	struct rb_node *nd, *pn = NULL;
 	unsigned long prev = 0, pend = 0;
 
@@ -373,29 +373,33 @@ static int browse_rb(struct rb_root *root)
 		struct vm_area_struct *vma;
 		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
 		if (vma->vm_start < prev)
-			printk("vm_start %lx prev %lx\n", vma->vm_start, prev), i = -1;
+			printk("vm_start %lx prev %lx\n", vma->vm_start, prev), bug = 1;
 		if (vma->vm_start < pend)
-			printk("vm_start %lx pend %lx\n", vma->vm_start, pend);
+			printk("vm_start %lx pend %lx\n", vma->vm_start, pend), bug = 1;
 		if (vma->vm_start > vma->vm_end)
-			printk("vm_end %lx < vm_start %lx\n", vma->vm_end, vma->vm_start);
+			printk("vm_end %lx < vm_start %lx\n", vma->vm_end, vma->vm_start), bug = 1;
+		if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma))
+			printk("free gap %lx, correct %lx\n",
+			       vma->rb_subtree_gap,
+			       vma_compute_subtree_gap(vma)), bug = 1;
 		i++;
 		pn = nd;
 		prev = vma->vm_start;
 		pend = vma->vm_end;
 	}
 	j = 0;
-	for (nd = pn; nd; nd = rb_prev(nd)) {
+	for (nd = pn; nd; nd = rb_prev(nd))
 		j++;
-	}
 	if (i != j)
-		printk("backwards %d, forwards %d\n", j, i), i = 0;
-	return i;
+		printk("backwards %d, forwards %d\n", j, i), bug = 1;
+	return bug ? -1 : i;
 }
 
 void validate_mm(struct mm_struct *mm)
 {
 	int bug = 0;
 	int i = 0;
+	unsigned long highest_address = 0;
 	struct vm_area_struct *vma = mm->mmap;
 	while (vma) {
 		struct anon_vma_chain *avc;
@@ -403,11 +407,15 @@ void validate_mm(struct mm_struct *mm)
 		list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 			anon_vma_interval_tree_verify(avc);
 		anon_vma_unlock(vma->anon_vma);
+		highest_address = vma->vm_end;
 		vma = vma->vm_next;
 		i++;
 	}
 	if (i != mm->map_count)
 		printk("map_count %d vm_next %d\n", mm->map_count, i), bug = 1;
+	if (highest_address != mm->highest_vm_end)
+		printk("mm->highest_vm_end %lx, found %lx\n",
+		       mm->highest_vm_end, highest_address), bug = 1;
 	i = browse_rb(&mm->mm_rb);
 	if (i != mm->map_count)
 		printk("map_count %d rb %d\n", mm->map_count, i), bug = 1;
-- 
1.7.7.3
