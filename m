Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 00:23:47 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:36971 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904092Ab1KQXXC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 00:23:02 +0100
Received: by ggnb1 with SMTP id b1so2154298ggn.36
        for <linux-mips@linux-mips.org>; Thu, 17 Nov 2011 15:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=5LwffRv1x2KyeQsqQpo9eY8Lr1rGnxyM+DpcBa2mhL0=;
        b=JfRqMyNTQJusz92nVUDpzok+cUwwO+5IVhrQRe9UJNMI9EsAVyX2Mi7tiUUzcRLO9B
         pfhMvKCKaaMp3G8e9GSg==
Received: by 10.101.176.37 with SMTP id d37mr139917anp.162.1321572176251;
        Thu, 17 Nov 2011 15:22:56 -0800 (PST)
Received: by 10.101.176.37 with SMTP id d37mr139885anp.162.1321572176018;
        Thu, 17 Nov 2011 15:22:56 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id l19sm100346306anc.14.2011.11.17.15.22.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 15:22:55 -0800 (PST)
Date:   Thu, 17 Nov 2011 15:22:53 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        linux-arch@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and
 HPAGE_SIZE
In-Reply-To: <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14954

Dummy, non-zero definitions for HPAGE_MASK and HPAGE_SIZE were added in
51c6f666fceb ("mm: ZAP_BLOCK causes redundant work") to avoid a divide
by zero in generic kernel code.

That code has since been removed, but probably should never have been
added in the first place: we don't want HPAGE_SIZE to act like PAGE_SIZE
for code that is working with hugepages, for example, when the dependency
on CONFIG_HUGETLB_PAGE has not been fulfilled.

Because hugepage size can differ from architecture to architecture, each
is required to have their own definitions for both HPAGE_MASK and
HPAGE_SIZE.  This is always done in arch/*/include/asm/page.h.

So, just remove the dummy and dangerous definitions since they are no
longer needed and reveals the correct dependencies.  Tested on
architectures using the definitions with allyesconfig: x86 (even with
thp), hppa, mips, powerpc, s390, sh3, sh4, sparc, and sparc64, and
with defconfig on ia64.

Cc: Robin Holt <holt@sgi.com>
Cc: David Daney <david.daney@cavium.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/hugetlb.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -110,11 +110,6 @@ static inline void copy_huge_page(struct page *dst, struct page *src)
 
 #define hugetlb_change_protection(vma, address, end, newprot)
 
-#ifndef HPAGE_MASK
-#define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
-#define HPAGE_SIZE	PAGE_SIZE
-#endif
-
 #endif /* !CONFIG_HUGETLB_PAGE */
 
 #define HUGETLB_ANON_FILE "anon_hugepage"
