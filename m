Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 02:22:18 +0200 (CEST)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35834 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992991AbcJMAUiyB9Y4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 02:20:38 +0200
Received: by mail-lf0-f68.google.com with SMTP id x79so9727633lff.2
        for <linux-mips@linux-mips.org>; Wed, 12 Oct 2016 17:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J7hNHJkTC7Ffiu2FXRztTaYWMFhFliujw26loP3uwnI=;
        b=Tf0wJXb+x8V7G23m+hVL27B49GOArO+pmF6+5AydlzCoHUiS5BCwtczvtJITmHyONk
         xlqI68CjkZmB0jAUH1zeQI9CKhnAgLk/qblxYjUoAUKJn99bM6Xm+n2mB9J4D2UD3sax
         GcCofaZivJ+luOuMXPpHujk/Y5Pxwry/DzEf8+PCb1W0kxiYDVuWpqSBJkHEZQIYO9Da
         LaET67yt7dEnS/e5ASHOwKJdZtteRBfbqVjw4/7BWUEz1lCaVW759sNBGYmR7lr/+9dR
         ZhN3Sh+rPEXzf3qXPUwCNhEFMhIE+JSx5uAKWQIIrs+7U30zHYyYVdVAx3lk+iyzalDh
         Bz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J7hNHJkTC7Ffiu2FXRztTaYWMFhFliujw26loP3uwnI=;
        b=I3kSCHSTS3iL4/y3r8Wl2dPVOxALEcQcO68X7foOCvIhikvIgxvd4NvQqC5vkvymnw
         iCRpGag7iNr5D7PUQM4QQRn33G7wO/exKHuUF4+uDmxrOPi+3bLMXZWJtX1soowCc0/u
         cbgurzcFBPIl2wgjTjpbL82guLxFfCU20FQjELW7Ai0e8JUptOUPI0eMD7RLPmRviJPO
         AIY6nyb3b4iwOZxXfInkm9nqxCNsh343buVOM5n/ZjJ4SuCxSsTycHNzwzexjyFZhmDV
         coRvtC6JwEzzu6FDPnQtjzl47kDUIKXTaqi/MhB7uZ6PbjiIKBZsxBE4gVKLgFrOYutW
         jp2A==
X-Gm-Message-State: AA6/9RlCsWvkM8cuN4LeHOvLQ32Aebk3PW8nl2VlqxSlVg7nhaeBM5Y6viWCQT6AOMGDpA==
X-Received: by 10.194.103.74 with SMTP id fu10mr5169329wjb.14.1476318033453;
        Wed, 12 Oct 2016 17:20:33 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id q8sm17312235wjj.7.2016.10.12.17.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Oct 2016 17:20:32 -0700 (PDT)
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
Subject: [PATCH 04/10] mm: replace get_user_pages_locked() write/force parameters with gup_flags
Date:   Thu, 13 Oct 2016 01:20:14 +0100
Message-Id: <20161013002020.3062-5-lstoakes@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161013002020.3062-1-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55406
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

This patch removes the write and force parameters from get_user_pages_locked()
and replaces them with a gup_flags parameter to make the use of FOLL_FORCE
explicit in callers as use of this flag can result in surprising behaviour (and
hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mm.h |  2 +-
 mm/frame_vector.c  |  8 +++++++-
 mm/gup.c           | 12 +++---------
 mm/nommu.c         |  5 ++++-
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6adc4bc..27ab538 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1282,7 +1282,7 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 			    int write, int force, struct page **pages,
 			    struct vm_area_struct **vmas);
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
-		    int write, int force, struct page **pages, int *locked);
+		    unsigned int gup_flags, struct page **pages, int *locked);
 long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 			       unsigned long start, unsigned long nr_pages,
 			       struct page **pages, unsigned int gup_flags);
diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index 381bb07..81b6749 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -41,10 +41,16 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 	int ret = 0;
 	int err;
 	int locked;
+	unsigned int gup_flags = 0;
 
 	if (nr_frames == 0)
 		return 0;
 
+	if (write)
+		gup_flags |= FOLL_WRITE;
+	if (force)
+		gup_flags |= FOLL_FORCE;
+
 	if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
 		nr_frames = vec->nr_allocated;
 
@@ -59,7 +65,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 		vec->got_ref = true;
 		vec->is_pfns = false;
 		ret = get_user_pages_locked(start, nr_frames,
-			write, force, (struct page **)(vec->ptrs), &locked);
+			gup_flags, (struct page **)(vec->ptrs), &locked);
 		goto out;
 	}
 
diff --git a/mm/gup.c b/mm/gup.c
index cfcb014..7a0d033 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -838,18 +838,12 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
  *          up_read(&mm->mmap_sem);
  */
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
-			   int write, int force, struct page **pages,
+			   unsigned int gup_flags, struct page **pages,
 			   int *locked)
 {
-	unsigned int flags = FOLL_TOUCH;
-
-	if (write)
-		flags |= FOLL_WRITE;
-	if (force)
-		flags |= FOLL_FORCE;
-
 	return __get_user_pages_locked(current, current->mm, start, nr_pages,
-				       pages, NULL, locked, true, flags);
+				       pages, NULL, locked, true,
+				       gup_flags | FOLL_TOUCH);
 }
 EXPORT_SYMBOL(get_user_pages_locked);
 
diff --git a/mm/nommu.c b/mm/nommu.c
index 7e27add..842cfdd 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -176,9 +176,12 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 EXPORT_SYMBOL(get_user_pages);
 
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
-			    int write, int force, struct page **pages,
+			    unsigned int gup_flags, struct page **pages,
 			    int *locked)
 {
+	int write = gup_flags & FOLL_WRITE;
+	int force = gup_flags & FOLL_FORCE;
+
 	return get_user_pages(start, nr_pages, write, force, pages, NULL);
 }
 EXPORT_SYMBOL(get_user_pages_locked);
-- 
2.10.0
