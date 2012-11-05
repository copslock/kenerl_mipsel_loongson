Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:50:16 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43960 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825973Ab2KEWrp5sFGd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:45 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so3945704pad.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=42IS+hQRw1ADfOLftQzPl7PxMg4IQjJkQMFWMKDSP6c=;
        b=BTWWcGITnt10w9ODDwzgVyd4fvZLIhoOhGhassjJtWC3ep5kwz47pCPaaIoLUk/Ur5
         ixwrhWYgkYixMKf5MBFXzRLMEnpnjtUzCGgg2ndY7QYADYIE6r8tIzOnOP6K0K1vzc5M
         uE/Es2Df5i+72RiMVMrC6X3XAINjM+0HtJ9K0RPE0Mt4XolV0OKT02DlyAAer8hJCrlk
         XSdkRECfbXvnRVKXNca5RHFA0tTq4aoA00jhNElKODpOwlu8g8Jd9A1Y2O0TXfjw+oBK
         +T3ulyXwuveJEMwYrN/POaEgPFgBsMJGZsYmx+3NHhMQKfPQz44JHt86G7SiRU0t1y7s
         hhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=42IS+hQRw1ADfOLftQzPl7PxMg4IQjJkQMFWMKDSP6c=;
        b=ax8iMSvDmgYzZXOpUhFnS+Za6d5sZtIhORAIvUIQDzzjWhjXiROjW1NZ1B1F2jgYVb
         yNsBUHdxWsubGrrbMCqGYFtQGWrqqot1+kfiOFUVVxnK4VXIvrKwdP0ejNweApEuv0ub
         3KuqNnQ+cNZo1dM0BOfQu2SJmykVdq4t6i+Bmo1WOC3gwShX7Gpxa4wJiMxkWwjAtnzP
         9MmOmnQ4hRw1cepp//Q3qr7M8bAe/WPlAMRimFAxtA+d30XQuD83jVou5agh/6LN1HtQ
         qwScKHIL7VVUcmI+BjYOX9m7utCNmKVEDUuSF9vQO276eYNxrvZRld0lH2QybJtfKoe+
         rPWg==
Received: by 10.68.143.201 with SMTP id sg9mr35295148pbb.32.1352155665025;
        Mon, 05 Nov 2012 14:47:45 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:44 -0800 (PST)
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
Subject: [PATCH 08/16] mm: use vm_unmapped_area() in hugetlbfs
Date:   Mon,  5 Nov 2012 14:47:05 -0800
Message-Id: <1352155633-8648-9-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQnq/dUP1bbwBdMYwgMn4N2NUks4IZs0SvotUNSdExWQTTwk8U+e7sfRc46RYQJV0omFa53G0wVARb4uHOtQlrLhwCKxPtrj2Mz4kMXC6O2bYA5NWskWcA9YN9e7J6NL+Lj9ZGONpz3m/De5De5gd33kTjCZqrVtr1Vya/cYGrJtkTZVDNCymlflu2I9Na01W5gWKwWaWtPstQTuMYMfu9K0Ldl55w==
X-archive-position: 34878
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

Update the hugetlb_get_unmapped_area function to make use of
vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 fs/hugetlbfs/inode.c |   42 ++++++++----------------------------------
 1 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c5bc355d8243..14bc0c1fb4fb 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -151,8 +151,8 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long start_addr;
 	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
@@ -173,39 +173,13 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 			return addr;
 	}
 
-	if (len > mm->cached_hole_size)
-		start_addr = mm->free_area_cache;
-	else {
-		start_addr = TASK_UNMAPPED_BASE;
-		mm->cached_hole_size = 0;
-	}
-
-full_search:
-	addr = ALIGN(start_addr, huge_page_size(h));
-
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
-			/*
-			 * Start a new search - just in case we missed
-			 * some holes.
-			 */
-			if (start_addr != TASK_UNMAPPED_BASE) {
-				start_addr = TASK_UNMAPPED_BASE;
-				mm->cached_hole_size = 0;
-				goto full_search;
-			}
-			return -ENOMEM;
-		}
-
-		if (!vma || addr + len <= vma->vm_start) {
-			mm->free_area_cache = addr + len;
-			return addr;
-		}
-		if (addr + mm->cached_hole_size < vma->vm_start)
-			mm->cached_hole_size = vma->vm_start - addr;
-		addr = ALIGN(vma->vm_end, huge_page_size(h));
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = TASK_UNMAPPED_BASE;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
 }
 #endif
 
-- 
1.7.7.3
