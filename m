Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:49:38 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46108 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825982Ab2KEWroTijoq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:44 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa7so3934264pbc.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EWmXgsnc9fQxBkhaU80PXECEJTZenWmKG/K/XM0LGgs=;
        b=GuZt5XWNiFx5hgiLEw9nu1n+JYgn2MJdx4q1AihE4XF8KPWFf4UeQg0UC8O+2qAAi5
         mDG0ZfnA9bHSShZ+gvgxgi7X7lbhqoEINHpkenuyCpZnLWqkJlB3+LG+XCvmXlGyrSlT
         SDi5ADsdxpjpd4vhSJHr58tytohB5DvoFYiiawSBwoPJOZ9HydALbR2XFTe2aXE2wmaH
         r7GmE5bokGilDzITWsyF+aqPI3MJIGX/OzP+rpkgD8mwalHRpA0RhoBmHwoxMRuN89fJ
         CzHcP/3gT+QIiE2ffAh5hJ59Po2dNXI7bgFTc5ve0jaPtTCzdGnJXSn5dJw57/Hkc/aV
         q2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=EWmXgsnc9fQxBkhaU80PXECEJTZenWmKG/K/XM0LGgs=;
        b=dNxNj52rJ4Y67jnItuQemguh0w5PlBi0oPHbe2PmK69MsFW4tQxnCOeITirmhAieFP
         mxpsd72t3gD1m3Mb7/GP7Vch7a9RPw1De84hlhqhJrjRvkA2w+qPxRm2kkF2Gw6zvej8
         vyTKNlbTlASbvA0sp5w5ybp/zKbbEUDvDQNfQxXc/BfR/Ax79ZJcpmKrrmEuhaj5D2cV
         vBEuX6tsJNgIsK3ZXIMRcF3s5azrQbXq6zlfxg6QmuALQvqJX5aVDQ5ROE3sW0eAt7eb
         YWb4jBJMVWX8SpIZ944ISd9COGWZC7fgzmntWbI20ef+UxI8/CWf+eOyN8B2D4F28wn3
         /rXg==
Received: by 10.68.238.199 with SMTP id vm7mr21793278pbc.105.1352155663495;
        Mon, 05 Nov 2012 14:47:43 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:42 -0800 (PST)
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
Subject: [PATCH 07/16] mm: fix cache coloring on x86_64 architecture
Date:   Mon,  5 Nov 2012 14:47:04 -0800
Message-Id: <1352155633-8648-8-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQnllONEcAN7WPD62+LytMK8VwSEjLH6LpXQioB+4+9DLw8CKQnb/9BiHhNXjLcNnN/3g6d6QcwI+ltCVcjf9WTfiwxmVyVGf6x86gB3o9Ph7iFLpj/HfITviFGG+hv5fEA0x0pcQPr5qclM4r4pKxRfbkOLFs6F5+2tWzH13+EIKXXAfdHmEBitKfYbRvK965ZTJnsZm+IIGBIjgmDoVW+/D4eO+A==
X-archive-position: 34876
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

Fix the x86-64 cache alignment code to take pgoff into account.
Use the x86 and MIPS cache alignment code as the basis for a generic
cache alignment function.

The old x86 code will always align the mmap to aliasing boundaries,
even if the program mmaps the file with a non-zero pgoff.

If program A mmaps the file with pgoff 0, and program B mmaps the
file with pgoff 1. The old code would align the mmaps, resulting in
misaligned pages:

A:  0123
B:  123

After this patch, they are aligned so the pages line up:

A: 0123
B:  123

Signed-off-by: Michel Lespinasse <walken@google.com>
Proposed-by: Rik van Riel <riel@redhat.com>

---
 arch/x86/kernel/sys_x86_64.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index f00d006d60fd..97ef74b88e0f 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -136,7 +136,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = begin;
 	info.high_limit = end;
 	info.align_mask = filp ? get_align_mask() : 0;
-	info.align_offset = 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
 
@@ -175,7 +175,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
 	info.align_mask = filp ? get_align_mask() : 0;
-	info.align_offset = 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))
 		return addr;
-- 
1.7.7.3
