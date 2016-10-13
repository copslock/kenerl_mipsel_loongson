Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 02:24:21 +0200 (CEST)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33591 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992940AbcJMAUtwEEr4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 02:20:49 +0200
Received: by mail-lf0-f67.google.com with SMTP id l131so6886473lfl.0
        for <linux-mips@linux-mips.org>; Wed, 12 Oct 2016 17:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=StCBFv0vocpyrGJ0Bm1hrxLeWrhMGS9dh1heY/5bYPY=;
        b=XI2/RK8mzQbWqscLAd52nvtF+BY1JAzDCCITkhbznxEODWbQvRD0T0/VBqnxL9/Y3F
         fmAr2sfWawxuFxxmSCqRNwNEElEIkfRFjys0+kjHxGtgJGYwAmtCxSAYCao6Yya/DwEJ
         ZJFS7GWMPuyvu2d+v+57INGRtIEz2fs5rCMWVWkFBEBkqEr7aZduKlGNe2qnejeClVfh
         bXIyf1oadU4GeFypfVzy6Pl2bagP1ysj653C25fM50CgvTwuBien2lctSDJ+3x8iF2lD
         4aT4eUmnNgh25SEXZm4pXvClg3xNu95uQMGcamcHbrEpHTnxwKWStrc2JhLga3TdUNaT
         tx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=StCBFv0vocpyrGJ0Bm1hrxLeWrhMGS9dh1heY/5bYPY=;
        b=k39flW3OlThEoF9XlEtkjlNmmoW2h/lcQCfayR5V0AFACmdGDnclxrVgLD90sV8G1S
         9BXpqkyAwlvunmQ/CWBYJM42YBJ+Y9PBxZEH9cbzH+7CfgBPqIPDk+hAYxc0e1Tm0LZB
         VJeqqopllzyY+J4c1FWux2dyCHisotTs2+u2fVl3TmLrEh8j7GGQ3JWXEOP26kXZKW9O
         tx0Wep5/uY1/i9hw0mPmQF2oE9pe7wUEc70EqYxZPXdvz37K7tu4TkKRB9k7BRgRJvSb
         rgmcn8PAI0Bb0YjThYhvL7C3UEGsnyoQ6AAtS47nUcDlSpDrgk1stuDpF+9DL/KRY0gi
         hpWQ==
X-Gm-Message-State: AA6/9RnNlaXEdmk6c7JDi64+uumZATzO7JlCbJOyvDnHaJUVCdPxIv2qFwuV0zAmw0Yiag==
X-Received: by 10.28.69.142 with SMTP id l14mr18991wmi.28.1476318044419;
        Wed, 12 Oct 2016 17:20:44 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id g9sm17367176wjk.25.2016.10.12.17.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Oct 2016 17:20:43 -0700 (PDT)
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
Subject: [PATCH 09/10] mm: replace access_remote_vm() write parameter with gup_flags
Date:   Thu, 13 Oct 2016 01:20:19 +0100
Message-Id: <20161013002020.3062-10-lstoakes@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161013002020.3062-1-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55411
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

This patch removes the write parameter from access_remote_vm() and replaces it
with a gup_flags parameter as use of this function previously _implied_
FOLL_FORCE, whereas after this patch callers explicitly pass this flag.

We make this explicit as use of FOLL_FORCE can result in surprising behaviour
(and hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/proc/base.c     | 19 +++++++++++++------
 include/linux/mm.h |  2 +-
 mm/memory.c        | 11 +++--------
 mm/nommu.c         |  7 +++----
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c2964d8..8e65446 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -252,7 +252,7 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	rv = access_remote_vm(mm, arg_end - 1, &c, 1, 0);
+	rv = access_remote_vm(mm, arg_end - 1, &c, 1, FOLL_FORCE);
 	if (rv <= 0)
 		goto out_free_page;
 
@@ -270,7 +270,8 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			int nr_read;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count,
+					FOLL_FORCE);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -305,7 +306,8 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count,
+					FOLL_FORCE);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -354,7 +356,8 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count,
+					FOLL_FORCE);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -832,6 +835,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
+	unsigned int flags = FOLL_FORCE;
 
 	if (!mm)
 		return 0;
@@ -844,6 +848,9 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!atomic_inc_not_zero(&mm->mm_users))
 		goto free;
 
+	if (write)
+		flags |= FOLL_WRITE;
+
 	while (count > 0) {
 		int this_len = min_t(int, count, PAGE_SIZE);
 
@@ -852,7 +859,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 			break;
 		}
 
-		this_len = access_remote_vm(mm, addr, page, this_len, write);
+		this_len = access_remote_vm(mm, addr, page, this_len, flags);
 		if (!this_len) {
 			if (!copied)
 				copied = -EIO;
@@ -965,7 +972,7 @@ static ssize_t environ_read(struct file *file, char __user *buf,
 		this_len = min(max_len, this_len);
 
 		retval = access_remote_vm(mm, (env_start + src),
-			page, this_len, 0);
+			page, this_len, FOLL_FORCE);
 
 		if (retval <= 0) {
 			ret = retval;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2a481d3..3e5234e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1268,7 +1268,7 @@ static inline int fixup_user_fault(struct task_struct *tsk,
 
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
-		void *buf, int len, int write);
+		void *buf, int len, unsigned int gup_flags);
 
 long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		      unsigned long start, unsigned long nr_pages,
diff --git a/mm/memory.c b/mm/memory.c
index 79ebed3..bac2d99 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3935,19 +3935,14 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
  * @addr:	start address to access
  * @buf:	source or destination buffer
  * @len:	number of bytes to transfer
- * @write:	whether the access is a write
+ * @gup_flags:	flags modifying lookup behaviour
  *
  * The caller must hold a reference on @mm.
  */
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
-		void *buf, int len, int write)
+		void *buf, int len, unsigned int gup_flags)
 {
-	unsigned int flags = FOLL_FORCE;
-
-	if (write)
-		flags |= FOLL_WRITE;
-
-	return __access_remote_vm(NULL, mm, addr, buf, len, flags);
+	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
 }
 
 /*
diff --git a/mm/nommu.c b/mm/nommu.c
index bde7df3..93d5bb5 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1847,15 +1847,14 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
  * @addr:	start address to access
  * @buf:	source or destination buffer
  * @len:	number of bytes to transfer
- * @write:	whether the access is a write
+ * @gup_flags:	flags modifying lookup behaviour
  *
  * The caller must hold a reference on @mm.
  */
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
-		void *buf, int len, int write)
+		void *buf, int len, unsigned int gup_flags)
 {
-	return __access_remote_vm(NULL, mm, addr, buf, len,
-			write ? FOLL_WRITE : 0);
+	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
 }
 
 /*
-- 
2.10.0
