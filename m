Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 17:37:16 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:37563
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbeCVQhB0JQ47 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Mar 2018 17:37:01 +0100
Received: by mail-lf0-x241.google.com with SMTP id m16-v6so10384809lfc.4;
        Thu, 22 Mar 2018 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=rbeOKq5V9eTRT8u5rfUzAgCdLtD99Cqf+/8TfHALzlA=;
        b=HLlgqaEeAPActWCgxUsCCJLKj9jG5NUu7s4Vq7Kiiuq5uGfFpNWhfDFxwmAhVjIbzv
         wUAL0u+htwYgdfPGErQxRE8nttQFT9PTfjxTKFIF81/72KOo2bs0ZFZv4JblZV0mhpaG
         IBPh74bi1lkLP82mUuLMlEivH3iV1lfTbleX3uEbt2sPAZLQmpI3KP9uJ4HIvIMbPOn1
         Ga0T0aPI0bBIkGtVhPG0YNUaik3dhbmPjzQfPw+ItO6459TXv1WsGLZgMKxZu+OGPxV4
         a8AMS4KNFA1i8HHPkL6D05yGiurkn6v1akSfuCku2K7A3QbP623Efy70ht/KIdJX370W
         5huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=rbeOKq5V9eTRT8u5rfUzAgCdLtD99Cqf+/8TfHALzlA=;
        b=VOo9Z8Q/7xBYmZ+q44DNT/Or376xYAX6pEgZQBSYbldn4+2UCI9m+Ee/QqDWYdrCGe
         aXatfyIiwzgANvzCw/1M6SsklEY7Zcz05uMaZW6Y9YVDO1rkPlaAQiSfkPDeNboYi6BX
         3nrYn10PnpA/K0jDyKrY35CHSs5vDY0RCeX2BHQeMmJauCyOKNbm2Ve/1ws+lNHIO+na
         DmrviUQD68ROifSLz1S/i/UfqvjKUN63Aby7Ttf1KEkbljyZmUnvDVd16N/qLDAjCXXO
         baSKezmB4rRisFPlNXocJZQmsGUMxXhJHuL54j/4GadV88OmE6sXmeUV7iD7+Cq4FH9k
         hUHQ==
X-Gm-Message-State: AElRT7EJiv9OBj8UPZoLBPrnY0GbemIEWHNYKYXSYK8OcoYqPhFkB4d2
        pSzCfTn+FZPlQBbYamkO6s8=
X-Google-Smtp-Source: AIpwx494nudMk19aF0byhFwcLpnF6u66xKh6fxV5mTuYViQ5cN1BHb/El+EAFgvRhSo/wmJbdpz97g==
X-Received: by 2002:a19:ca41:: with SMTP id h1-v6mr60764lfj.81.1521736612704;
        Thu, 22 Mar 2018 09:36:52 -0700 (PDT)
Received: from crasher.ptsecurity.ru ([31.44.93.25])
        by smtp.gmail.com with ESMTPSA id q66sm1016261ljq.75.2018.03.22.09.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Mar 2018 09:36:51 -0700 (PDT)
From:   Ilya Smith <blackzert@gmail.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
        fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        blackzert@gmail.com, gregkh@linuxfoundation.org,
        deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        akpm@linux-foundation.org, steve.capper@arm.com,
        punit.agrawal@arm.com, paul.burton@mips.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
        nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, jglisse@redhat.com,
        willy@infradead.org, aarcange@redhat.com, oleg@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH v2 1/2] Randomization of address chosen by mmap.
Date:   Thu, 22 Mar 2018 19:36:37 +0300
Message-Id: <1521736598-12812-2-git-send-email-blackzert@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blackzert@gmail.com
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

Signed-off-by: Ilya Smith <blackzert@gmail.com>
---
 include/linux/mm.h |  16 ++++--
 mm/mmap.c          | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42..c716257 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/page_ref.h>
 #include <linux/memremap.h>
+#include <linux/sched.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -2253,6 +2254,13 @@ struct vm_unmapped_area_info {
 	unsigned long align_offset;
 };
 
+#ifndef CONFIG_MMU
+#define randomize_va_space 0
+#else
+extern int randomize_va_space;
+#endif
+
+extern unsigned long unmapped_area_random(struct vm_unmapped_area_info *info);
 extern unsigned long unmapped_area(struct vm_unmapped_area_info *info);
 extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 
@@ -2268,6 +2276,9 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 static inline unsigned long
 vm_unmapped_area(struct vm_unmapped_area_info *info)
 {
+	/* How about 32 bit process?? */
+	if ((current->flags & PF_RANDOMIZE) && randomize_va_space > 3)
+		return unmapped_area_random(info);
 	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
 		return unmapped_area_topdown(info);
 	else
@@ -2529,11 +2540,6 @@ int drop_caches_sysctl_handler(struct ctl_table *, int,
 void drop_slab(void);
 void drop_slab_node(int nid);
 
-#ifndef CONFIG_MMU
-#define randomize_va_space 0
-#else
-extern int randomize_va_space;
-#endif
 
 const char * arch_vma_name(struct vm_area_struct *vma);
 void print_vma_addr(char *prefix, unsigned long rip);
diff --git a/mm/mmap.c b/mm/mmap.c
index 9efdc021..ba9cebb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -45,6 +45,7 @@
 #include <linux/moduleparam.h>
 #include <linux/pkeys.h>
 #include <linux/oom.h>
+#include <linux/random.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1780,6 +1781,169 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return error;
 }
 
+unsigned long unmapped_area_random(struct vm_unmapped_area_info *info)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *visited_vma = NULL;
+	unsigned long entropy[2];
+	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long addr = 0;
+
+	/* get entropy with prng */
+	prandom_bytes(&entropy, sizeof(entropy));
+	/* small hack to prevent EPERM result */
+	info->low_limit = max(info->low_limit, mmap_min_addr);
+
+	/* Adjust search length to account for worst case alignment overhead */
+	length = info->length + info->align_mask;
+	if (length < info->length)
+		return -ENOMEM;
+
+	/*
+	 * Adjust search limits by the desired length.
+	 * See implementation comment at top of unmapped_area().
+	 */
+	gap_end = info->high_limit;
+	if (gap_end < length)
+		return -ENOMEM;
+	high_limit = gap_end - length;
+
+	low_limit = info->low_limit + info->align_mask;
+	if (low_limit >= high_limit)
+		return -ENOMEM;
+
+	/* Choose random addr in limit range */
+	addr = entropy[0] % ((high_limit - low_limit) >> PAGE_SHIFT);
+	addr = low_limit + (addr << PAGE_SHIFT);
+	addr += (info->align_offset - addr) & info->align_mask;
+
+	/* Check if rbtree root looks promising */
+	if (RB_EMPTY_ROOT(&mm->mm_rb))
+		return -ENOMEM;
+
+	vma = rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
+	if (vma->rb_subtree_gap < length)
+		return -ENOMEM;
+	/* use randomly chosen address to find closest suitable gap */
+	while (true) {
+		gap_start = vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
+		gap_end = vm_start_gap(vma);
+		if (gap_end < low_limit)
+			break;
+		if (addr < vm_start_gap(vma)) {
+			/* random said check left */
+			if (vma->vm_rb.rb_left) {
+				struct vm_area_struct *left =
+					rb_entry(vma->vm_rb.rb_left,
+						 struct vm_area_struct, vm_rb);
+				if (addr <= vm_start_gap(left) &&
+				    left->rb_subtree_gap >= length) {
+					vma = left;
+					continue;
+				}
+			}
+		} else if (addr >= vm_end_gap(vma)) {
+			/* random said check right */
+			if (vma->vm_rb.rb_right) {
+				struct vm_area_struct *right =
+				rb_entry(vma->vm_rb.rb_right,
+					 struct vm_area_struct, vm_rb);
+				/* it want go to the right */
+				if (right->rb_subtree_gap >= length) {
+					vma = right;
+					continue;
+				}
+			}
+		}
+		if (gap_start < low_limit) {
+			if (gap_end <= low_limit)
+				break;
+			gap_start = low_limit;
+		} else if (gap_end > info->high_limit) {
+			if (gap_start >= info->high_limit)
+				break;
+			gap_end = info->high_limit;
+		}
+		if (gap_end > gap_start &&
+		    gap_end - gap_start >= length)
+			goto found;
+		visited_vma = vma;
+		break;
+	}
+	/* not found */
+	while (true) {
+		gap_start = vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
+
+		if (gap_start <= high_limit && vma->vm_rb.rb_right) {
+			struct vm_area_struct *right =
+				rb_entry(vma->vm_rb.rb_right,
+					 struct vm_area_struct, vm_rb);
+			if (right->rb_subtree_gap >= length &&
+			    right != visited_vma) {
+				vma = right;
+				continue;
+			}
+		}
+
+check_current:
+		/* Check if current node has a suitable gap */
+		gap_end = vm_start_gap(vma);
+		if (gap_end <= low_limit)
+			goto go_back;
+
+		if (gap_start < low_limit)
+			gap_start = low_limit;
+
+		if (gap_start <= high_limit &&
+		    gap_end > gap_start && gap_end - gap_start >= length)
+			goto found;
+
+		/* Visit left subtree if it looks promising */
+		if (vma->vm_rb.rb_left) {
+			struct vm_area_struct *left =
+				rb_entry(vma->vm_rb.rb_left,
+					 struct vm_area_struct, vm_rb);
+			if (left->rb_subtree_gap >= length &&
+			    vm_end_gap(left) > low_limit &&
+				left != visited_vma) {
+				vma = left;
+				continue;
+			}
+		}
+go_back:
+		/* Go back up the rbtree to find next candidate node */
+		while (true) {
+			struct rb_node *prev = &vma->vm_rb;
+
+			if (!rb_parent(prev))
+				return -ENOMEM;
+			visited_vma = vma;
+			vma = rb_entry(rb_parent(prev),
+				       struct vm_area_struct, vm_rb);
+			if (prev == vma->vm_rb.rb_right) {
+				gap_start = vma->vm_prev ?
+					vm_end_gap(vma->vm_prev) : low_limit;
+				goto check_current;
+			}
+		}
+	}
+found:
+	/* We found a suitable gap. Clip it with the original high_limit. */
+	if (gap_end > info->high_limit)
+		gap_end = info->high_limit;
+	gap_end -= info->length;
+	gap_end -= (gap_end - info->align_offset) & info->align_mask;
+	/* only one suitable page */
+	if (gap_end ==  gap_start)
+		return gap_start;
+	addr = entropy[1] % (min((gap_end - gap_start) >> PAGE_SHIFT,
+							 0x10000UL));
+	addr = gap_end - (addr << PAGE_SHIFT);
+	addr += (info->align_offset - addr) & info->align_mask;
+	return addr;
+}
+
 unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
 	/*
-- 
2.7.4
