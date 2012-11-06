Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 23:38:23 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51437 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826027Ab2KFWiWrvu2T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2012 23:38:22 +0100
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6AD326;
        Tue,  6 Nov 2012 22:38:15 +0000 (UTC)
Date:   Tue, 6 Nov 2012 14:38:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 03/16] mm: check rb_subtree_gap correctness
Message-Id: <20121106143815.2d311383.akpm@linux-foundation.org>
In-Reply-To: <1352155633-8648-4-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
        <1352155633-8648-4-git-send-email-walken@google.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Mon,  5 Nov 2012 14:47:00 -0800
Michel Lespinasse <walken@google.com> wrote:

> When CONFIG_DEBUG_VM_RB is enabled, check that rb_subtree_gap is
> correctly set for every vma and that mm->highest_vm_end is also correct.
> 
> Also add an explicit 'bug' variable to track if browse_rb() detected any
> invalid condition.
> 
> ...
>
> @@ -365,7 +365,7 @@ static void vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
>  #ifdef CONFIG_DEBUG_VM_RB
>  static int browse_rb(struct rb_root *root)
>  {
> -	int i = 0, j;
> +	int i = 0, j, bug = 0;
>  	struct rb_node *nd, *pn = NULL;
>  	unsigned long prev = 0, pend = 0;
>  
> @@ -373,29 +373,33 @@ static int browse_rb(struct rb_root *root)
>  		struct vm_area_struct *vma;
>  		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
>  		if (vma->vm_start < prev)
> -			printk("vm_start %lx prev %lx\n", vma->vm_start, prev), i = -1;
> +			printk("vm_start %lx prev %lx\n", vma->vm_start, prev), bug = 1;
>  		if (vma->vm_start < pend)
> -			printk("vm_start %lx pend %lx\n", vma->vm_start, pend);
> +			printk("vm_start %lx pend %lx\n", vma->vm_start, pend), bug = 1;
>  		if (vma->vm_start > vma->vm_end)
> -			printk("vm_end %lx < vm_start %lx\n", vma->vm_end, vma->vm_start);
> +			printk("vm_end %lx < vm_start %lx\n", vma->vm_end, vma->vm_start), bug = 1;
> +		if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma))
> +			printk("free gap %lx, correct %lx\n",
> +			       vma->rb_subtree_gap,
> +			       vma_compute_subtree_gap(vma)), bug = 1;

OK, now who did that.  Whoever it was: stop it or you'll have your
kernel license revoked!

--- a/mm/mmap.c~mm-check-rb_subtree_gap-correctness-fix
+++ a/mm/mmap.c
@@ -372,16 +372,25 @@ static int browse_rb(struct rb_root *roo
 	for (nd = rb_first(root); nd; nd = rb_next(nd)) {
 		struct vm_area_struct *vma;
 		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
-		if (vma->vm_start < prev)
-			printk("vm_start %lx prev %lx\n", vma->vm_start, prev), bug = 1;
-		if (vma->vm_start < pend)
-			printk("vm_start %lx pend %lx\n", vma->vm_start, pend), bug = 1;
-		if (vma->vm_start > vma->vm_end)
-			printk("vm_end %lx < vm_start %lx\n", vma->vm_end, vma->vm_start), bug = 1;
-		if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma))
+		if (vma->vm_start < prev) {
+			printk("vm_start %lx prev %lx\n", vma->vm_start, prev);
+			bug = 1;
+		}
+		if (vma->vm_start < pend) {
+			printk("vm_start %lx pend %lx\n", vma->vm_start, pend);
+			bug = 1;
+		}
+		if (vma->vm_start > vma->vm_end) {
+			printk("vm_end %lx < vm_start %lx\n",
+				vma->vm_end, vma->vm_start);
+			bug = 1;
+		}
+		if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma)) {
 			printk("free gap %lx, correct %lx\n",
 			       vma->rb_subtree_gap,
-			       vma_compute_subtree_gap(vma)), bug = 1;
+			       vma_compute_subtree_gap(vma));
+			bug = 1;
+		}
 		i++;
 		pn = nd;
 		prev = vma->vm_start;
@@ -390,8 +399,10 @@ static int browse_rb(struct rb_root *roo
 	j = 0;
 	for (nd = pn; nd; nd = rb_prev(nd))
 		j++;
-	if (i != j)
-		printk("backwards %d, forwards %d\n", j, i), bug = 1;
+	if (i != j) {
+		printk("backwards %d, forwards %d\n", j, i);
+		bug = 1;
+	}
 	return bug ? -1 : i;
 }
 
@@ -411,14 +422,20 @@ void validate_mm(struct mm_struct *mm)
 		vma = vma->vm_next;
 		i++;
 	}
-	if (i != mm->map_count)
-		printk("map_count %d vm_next %d\n", mm->map_count, i), bug = 1;
-	if (highest_address != mm->highest_vm_end)
+	if (i != mm->map_count) {
+		printk("map_count %d vm_next %d\n", mm->map_count, i);
+		bug = 1;
+	}
+	if (highest_address != mm->highest_vm_end) {
 		printk("mm->highest_vm_end %lx, found %lx\n",
-		       mm->highest_vm_end, highest_address), bug = 1;
+		       mm->highest_vm_end, highest_address);
+		bug = 1;
+	}
 	i = browse_rb(&mm->mm_rb);
-	if (i != mm->map_count)
-		printk("map_count %d rb %d\n", mm->map_count, i), bug = 1;
+	if (i != mm->map_count) {
+		printk("map_count %d rb %d\n", mm->map_count, i);
+		bug = 1;
+	}
 	BUG_ON(bug);
 }
 #else
