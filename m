Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 02:23:31 +0200 (CEST)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33540 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993003AbcJMAUp2CsE4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 02:20:45 +0200
Received: by mail-lf0-f66.google.com with SMTP id l131so6886253lfl.0
        for <linux-mips@linux-mips.org>; Wed, 12 Oct 2016 17:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XSu+d2QFxhn7HadzNfOSbhuTLDJMR9KfBQVOTAKUjd0=;
        b=xFIDZKivQqyyI7LizL/KK6zKAxjxFqYpqpLa1RLsHM5sEyUPgvjX5jKofIohoV3YIQ
         UR62hxZA9PG+R9PUpJOERLHJn20Q1cTeGtSWFPvm9/HtDmGyp3ePNhk2FSoQB68SpZvW
         bz+qcttCI8pEstrEqw6MjYYdGH91ZLQEdg4AExs1YNQuN2xmx3T2e3k5EgMTAcB3Labk
         7Uef7pGxbytJJVwPRxHhQGfsrg1Kzruxopt3QtTbQlQle2wL5UWQPnUDcskon/nGObig
         zz6AuOvD1PSrHaDHFOnfBHRe+nQsyO36eXM91S5VnL2SB7bwT76OtYIOfveIopjM1XIh
         srwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XSu+d2QFxhn7HadzNfOSbhuTLDJMR9KfBQVOTAKUjd0=;
        b=dzP8wl7efKX/cw3IZag/cs1ieuH+YDOv8rbkndUlAZu/TNPNuEk1SNCqvXnbN/e1ye
         9Er+CecJnLK5nyhJEmGQuEfoPAoNs5uS/r0Gdgk/AHo0vWT6NqfDmvXzjUkAoZ8kHFrl
         /ixRGKxsAOq98LZ+sdqgtTby2xV64EbkysPU/GyjaMrlI+HZCOz/C6hmNinFVqEC/eAQ
         /oX79/RH3/i3z83jQlWM9OtppJIFWXTG8DsNbW63ucKdAi83dfQHUULNny1oH7lxunXX
         3apQgx+RYGOnrCdt8oUzZYWaYDu6xwxNn8sIjYh4b2UUoAhXMqDyvk5LNURCACbLm4fl
         UgYw==
X-Gm-Message-State: AA6/9RkTcHC2dfrxOYn3cYamz8mHi2e5RZXM43PNFX770+xHwOb+JH+iS/gsd5IuMOtnsA==
X-Received: by 10.194.20.231 with SMTP id q7mr4964884wje.57.1476318039949;
        Wed, 12 Oct 2016 17:20:39 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id pe5sm17382305wjb.15.2016.10.12.17.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Oct 2016 17:20:38 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-fbdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 07/10] mm: replace get_user_pages_remote() write/force parameters with gup_flags
Date:   Thu, 13 Oct 2016 01:20:17 +0100
Message-Id: <20161013002020.3062-8-lstoakes@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161013002020.3062-1-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lstoakes@gmail.com
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

This patch removes the write and force parameters from get_user_pages_remote()
and replaces them with a gup_flags parameter to make the use of FOLL_FORCE
explicit in callers as use of this flag can result in surprising behaviour (and
hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c   |  7 +++++--
 drivers/gpu/drm/i915/i915_gem_userptr.c |  6 +++++-
 drivers/infiniband/core/umem_odp.c      |  7 +++++--
 fs/exec.c                               |  9 +++++++--
 include/linux/mm.h                      |  2 +-
 kernel/events/uprobes.c                 |  6 ++++--
 mm/gup.c                                | 22 +++++++---------------
 mm/memory.c                             |  6 +++++-
 security/tomoyo/domain.c                |  2 +-
 9 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 5ce3603..0370b84 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -748,19 +748,22 @@ static struct page **etnaviv_gem_userptr_do_get_pages(
 	int ret = 0, pinned, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
 	struct page **pvec;
 	uintptr_t ptr;
+	unsigned int flags = 0;
 
 	pvec = drm_malloc_ab(npages, sizeof(struct page *));
 	if (!pvec)
 		return ERR_PTR(-ENOMEM);
 
+	if (!etnaviv_obj->userptr.ro)
+		flags |= FOLL_WRITE;
+
 	pinned = 0;
 	ptr = etnaviv_obj->userptr.ptr;
 
 	down_read(&mm->mmap_sem);
 	while (pinned < npages) {
 		ret = get_user_pages_remote(task, mm, ptr, npages - pinned,
-					    !etnaviv_obj->userptr.ro, 0,
-					    pvec + pinned, NULL);
+					    flags, pvec + pinned, NULL);
 		if (ret < 0)
 			break;
 
diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915/i915_gem_userptr.c
index e537930..c6f780f 100644
--- a/drivers/gpu/drm/i915/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
@@ -508,6 +508,10 @@ __i915_gem_userptr_get_pages_worker(struct work_struct *_work)
 	pvec = drm_malloc_gfp(npages, sizeof(struct page *), GFP_TEMPORARY);
 	if (pvec != NULL) {
 		struct mm_struct *mm = obj->userptr.mm->mm;
+		unsigned int flags = 0;
+
+		if (!obj->userptr.read_only)
+			flags |= FOLL_WRITE;
 
 		ret = -EFAULT;
 		if (atomic_inc_not_zero(&mm->mm_users)) {
@@ -517,7 +521,7 @@ __i915_gem_userptr_get_pages_worker(struct work_struct *_work)
 					(work->task, mm,
 					 obj->userptr.ptr + pinned * PAGE_SIZE,
 					 npages - pinned,
-					 !obj->userptr.read_only, 0,
+					 flags,
 					 pvec + pinned, NULL);
 				if (ret < 0)
 					break;
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 75077a0..1f0fe32 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -527,6 +527,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem *umem, u64 user_virt, u64 bcnt,
 	u64 off;
 	int j, k, ret = 0, start_idx, npages = 0;
 	u64 base_virt_addr;
+	unsigned int flags = 0;
 
 	if (access_mask == 0)
 		return -EINVAL;
@@ -556,6 +557,9 @@ int ib_umem_odp_map_dma_pages(struct ib_umem *umem, u64 user_virt, u64 bcnt,
 		goto out_put_task;
 	}
 
+	if (access_mask & ODP_WRITE_ALLOWED_BIT)
+		flags |= FOLL_WRITE;
+
 	start_idx = (user_virt - ib_umem_start(umem)) >> PAGE_SHIFT;
 	k = start_idx;
 
@@ -574,8 +578,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem *umem, u64 user_virt, u64 bcnt,
 		 */
 		npages = get_user_pages_remote(owning_process, owning_mm,
 				user_virt, gup_num_pages,
-				access_mask & ODP_WRITE_ALLOWED_BIT,
-				0, local_page_list, NULL);
+				flags, local_page_list, NULL);
 		up_read(&owning_mm->mmap_sem);
 
 		if (npages < 0)
diff --git a/fs/exec.c b/fs/exec.c
index 6fcfb3f..4e497b9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -191,6 +191,7 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 {
 	struct page *page;
 	int ret;
+	unsigned int gup_flags = FOLL_FORCE;
 
 #ifdef CONFIG_STACK_GROWSUP
 	if (write) {
@@ -199,12 +200,16 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 			return NULL;
 	}
 #endif
+
+	if (write)
+		gup_flags |= FOLL_WRITE;
+
 	/*
 	 * We are doing an exec().  'current' is the process
 	 * doing the exec and bprm->mm is the new process's mm.
 	 */
-	ret = get_user_pages_remote(current, bprm->mm, pos, 1, write,
-			1, &page, NULL);
+	ret = get_user_pages_remote(current, bprm->mm, pos, 1, gup_flags,
+			&page, NULL);
 	if (ret <= 0)
 		return NULL;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 686a477..2a481d3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1276,7 +1276,7 @@ long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		      struct vm_area_struct **vmas, int *nonblocking);
 long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 			    unsigned long start, unsigned long nr_pages,
-			    int write, int force, struct page **pages,
+			    unsigned int gup_flags, struct page **pages,
 			    struct vm_area_struct **vmas);
 long get_user_pages(unsigned long start, unsigned long nr_pages,
 			    unsigned int gup_flags, struct page **pages,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d4129bb..f9ec9ad 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -300,7 +300,8 @@ int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
 
 retry:
 	/* Read the page with vaddr into memory */
-	ret = get_user_pages_remote(NULL, mm, vaddr, 1, 0, 1, &old_page, &vma);
+	ret = get_user_pages_remote(NULL, mm, vaddr, 1, FOLL_FORCE, &old_page,
+			&vma);
 	if (ret <= 0)
 		return ret;
 
@@ -1710,7 +1711,8 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	 * but we treat this as a 'remote' access since it is
 	 * essentially a kernel access to the memory.
 	 */
-	result = get_user_pages_remote(NULL, mm, vaddr, 1, 0, 1, &page, NULL);
+	result = get_user_pages_remote(NULL, mm, vaddr, 1, FOLL_FORCE, &page,
+			NULL);
 	if (result < 0)
 		return result;
 
diff --git a/mm/gup.c b/mm/gup.c
index dc91303..0deecf3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -905,9 +905,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * @mm:		mm_struct of target mm
  * @start:	starting user address
  * @nr_pages:	number of pages from start to pin
- * @write:	whether pages will be written to by the caller
- * @force:	whether to force access even when user mapping is currently
- *		protected (but never forces write access to shared mapping).
+ * @gup_flags:	flags modifying lookup behaviour
  * @pages:	array that receives pointers to the pages pinned.
  *		Should be at least nr_pages long. Or NULL, if caller
  *		only intends to ensure the pages are faulted in.
@@ -936,9 +934,9 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * or similar operation cannot guarantee anything stronger anyway because
  * locks can't be held over the syscall boundary.
  *
- * If write=0, the page must not be written to. If the page is written to,
- * set_page_dirty (or set_page_dirty_lock, as appropriate) must be called
- * after the page is finished with, and before put_page is called.
+ * If gup_flags & FOLL_WRITE == 0, the page must not be written to. If the page
+ * is written to, set_page_dirty (or set_page_dirty_lock, as appropriate) must
+ * be called after the page is finished with, and before put_page is called.
  *
  * get_user_pages is typically used for fewer-copy IO operations, to get a
  * handle on the memory by some means other than accesses via the user virtual
@@ -955,18 +953,12 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  */
 long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
-		int write, int force, struct page **pages,
+		unsigned int gup_flags, struct page **pages,
 		struct vm_area_struct **vmas)
 {
-	unsigned int flags = FOLL_TOUCH | FOLL_REMOTE;
-
-	if (write)
-		flags |= FOLL_WRITE;
-	if (force)
-		flags |= FOLL_FORCE;
-
 	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
-				       NULL, false, flags);
+				       NULL, false,
+				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
 }
 EXPORT_SYMBOL(get_user_pages_remote);
 
diff --git a/mm/memory.c b/mm/memory.c
index fc1987d..20a9adb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3873,6 +3873,10 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	void *old_buf = buf;
+	unsigned int flags = FOLL_FORCE;
+
+	if (write)
+		flags |= FOLL_WRITE;
 
 	down_read(&mm->mmap_sem);
 	/* ignore errors, just check how much was successfully transferred */
@@ -3882,7 +3886,7 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 		struct page *page = NULL;
 
 		ret = get_user_pages_remote(tsk, mm, addr, 1,
-				write, 1, &page, &vma);
+				flags, &page, &vma);
 		if (ret <= 0) {
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index ade7c6c..682b73a 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -881,7 +881,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 	 * the execve().
 	 */
 	if (get_user_pages_remote(current, bprm->mm, pos, 1,
-				0, 1, &page, NULL) <= 0)
+				FOLL_FORCE, &page, NULL) <= 0)
 		return false;
 #else
 	page = bprm->page[pos / PAGE_SIZE];
-- 
2.10.0
