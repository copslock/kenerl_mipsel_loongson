Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 02:20:59 +0200 (CEST)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36807 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992907AbcJMAUdHebo4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 02:20:33 +0200
Received: by mail-lf0-f66.google.com with SMTP id b75so9576803lfg.3
        for <linux-mips@linux-mips.org>; Wed, 12 Oct 2016 17:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8gEP7ZoklccM5hp1+G67ywmwdx3iOL8C/MYVHp7EmU=;
        b=JuT9DdHzwcRX2d57uF2Ok1/0XzI7mfCPFycwSWgLh256+HHE7svEZXWbxp4Dx344ri
         cPTt+igPbNrjH+BbF106P95yuUwSVX0U64iJtlY8AK71Z2AYJuoQwnx5vu3wXyW/emdk
         ZOvhoNRwvZZNJTTsjHBwe9pY0rqd61FyKapWpnalUl9qgWZZ1BnHxdXlMXlshZs7sL4C
         Z85jYGH0L+yRzDioCGc+CFh0MJsB8hGGvCZ/WM+JTRVZ6/I6YiHJn1Kr5v7tVlurOs8i
         mTBiUoggOdDLPjR1W5+lh0QXRxJPOHV0oqIZJlixH0Q0AusRDBgHFi1fCnFV9VYPDrHH
         Gk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8gEP7ZoklccM5hp1+G67ywmwdx3iOL8C/MYVHp7EmU=;
        b=KbywkthYYbKejZTxmmUe2F6xr8o0Bo4gkNzdhOGQVnvq6gq9DFtC6WFRoaqxC1olRi
         F3unVkADSINP4QTWE+GkXayqYjdSjFxNp3IyO/1H8t8SFrCZ0Lgqq6hIJkdgIfZ4j7jw
         zV1RLV3Gr9bzqRXsvvYfCnHvCJ4azO+mLDy3cgIks976+wGFnE9MOop7IACesGGoD2jL
         lfa2jbGA1oTOf+vdcQ/lhVhu+G2kRWifGwbvJ788ffp2nejYo4/+2cDzD1gR0hI1/mYz
         ykZm7ot8zIvspDV8zLBI/K5JfwPFlf17WjlK0lR2hu6xkXDqQ1XAWU6fYw+czjG1zw/Y
         Th8A==
X-Gm-Message-State: AA6/9RmE5QrxjmhhnkAJvbabLtjOW7E01uH/HkExzQ3T7sDsfjxCphVEHwpUFufrNv/CJw==
X-Received: by 10.28.54.142 with SMTP id y14mr18318wmh.11.1476318027693;
        Wed, 12 Oct 2016 17:20:27 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id qa7sm17277959wjc.39.2016.10.12.17.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Oct 2016 17:20:26 -0700 (PDT)
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
Subject: [PATCH 01/10] mm: remove write/force parameters from __get_user_pages_locked()
Date:   Thu, 13 Oct 2016 01:20:11 +0100
Message-Id: <20161013002020.3062-2-lstoakes@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161013002020.3062-1-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55403
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

This patch removes the write and force parameters from __get_user_pages_locked()
to make the use of FOLL_FORCE explicit in callers as use of this flag can result
in surprising behaviour (and hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/gup.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 96b2b2f..ba83942 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -729,7 +729,6 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 						struct mm_struct *mm,
 						unsigned long start,
 						unsigned long nr_pages,
-						int write, int force,
 						struct page **pages,
 						struct vm_area_struct **vmas,
 						int *locked, bool notify_drop,
@@ -747,10 +746,6 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 
 	if (pages)
 		flags |= FOLL_GET;
-	if (write)
-		flags |= FOLL_WRITE;
-	if (force)
-		flags |= FOLL_FORCE;
 
 	pages_done = 0;
 	lock_dropped = false;
@@ -846,9 +841,15 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 			   int write, int force, struct page **pages,
 			   int *locked)
 {
+	unsigned int flags = FOLL_TOUCH;
+
+	if (write)
+		flags |= FOLL_WRITE;
+	if (force)
+		flags |= FOLL_FORCE;
+
 	return __get_user_pages_locked(current, current->mm, start, nr_pages,
-				       write, force, pages, NULL, locked, true,
-				       FOLL_TOUCH);
+				       pages, NULL, locked, true, flags);
 }
 EXPORT_SYMBOL(get_user_pages_locked);
 
@@ -869,9 +870,15 @@ __always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct m
 {
 	long ret;
 	int locked = 1;
+
+	if (write)
+		gup_flags |= FOLL_WRITE;
+	if (force)
+		gup_flags |= FOLL_FORCE;
+
 	down_read(&mm->mmap_sem);
-	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
-				      pages, NULL, &locked, false, gup_flags);
+	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, pages, NULL,
+				      &locked, false, gup_flags);
 	if (locked)
 		up_read(&mm->mmap_sem);
 	return ret;
@@ -963,9 +970,15 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 		int write, int force, struct page **pages,
 		struct vm_area_struct **vmas)
 {
-	return __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
-				       pages, vmas, NULL, false,
-				       FOLL_TOUCH | FOLL_REMOTE);
+	unsigned int flags = FOLL_TOUCH | FOLL_REMOTE;
+
+	if (write)
+		flags |= FOLL_WRITE;
+	if (force)
+		flags |= FOLL_FORCE;
+
+	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
+				       NULL, false, flags);
 }
 EXPORT_SYMBOL(get_user_pages_remote);
 
@@ -979,9 +992,15 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 		int write, int force, struct page **pages,
 		struct vm_area_struct **vmas)
 {
+	unsigned int flags = FOLL_TOUCH;
+
+	if (write)
+		flags |= FOLL_WRITE;
+	if (force)
+		flags |= FOLL_FORCE;
+
 	return __get_user_pages_locked(current, current->mm, start, nr_pages,
-				       write, force, pages, vmas, NULL, false,
-				       FOLL_TOUCH);
+				       pages, vmas, NULL, false, flags);
 }
 EXPORT_SYMBOL(get_user_pages);
 
-- 
2.10.0
