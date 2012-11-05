Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:47:39 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46108 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825976Ab2KEWriDvdZY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:38 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa7so3934264pbc.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Aai+/WdvMNX3hHSB0PfhrQwvzJLJOlHhaLEAsjTbDh0=;
        b=DeUh3QUdrSBY2OyF5RzXk8m+2Hx1Mim1LxN5g/YUES5ZGWI5gnVTzEabHpSvIxjcgo
         k7281g8kAJvmW6b0KBL/dVLOcMtl3BAYtPk6m4OEdGXuNSiSgb17gZuHpzx0cLeLVf8t
         g69cCw5EuhKanVp7o/MAOmasM5OBZD0j2bG0L6XjVWxtK62as7MDI9oPSUSjgE1FSpKN
         +1aeqYmLkMySIbIDe2s+qShDSsMS3oyoOLbvzDR9gtmPAER8D5/1unF1LxbSSPfAp1uW
         xpq1vaUKeQJzFwtqKgAArDKcHw8RsE3Ptq/RFbvBAcOHASmiBuFyqECFS+dVgNU9Ht7f
         pcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=Aai+/WdvMNX3hHSB0PfhrQwvzJLJOlHhaLEAsjTbDh0=;
        b=LEf+ZVfSnRqb/xPOFg32UYbEw5QDgNhUGY/6PJaSpJSC/uXghg9Pb93UQzmCm5QWp0
         jhRp7dFbTmT75CkpWnhKDn6zwpxqJA1Y+DKlznJU72JvUzwbohwAf5lkA7T2EEnheypm
         RGjF6BM1a6teYo5lHSiwulgODBruVtSowyTiDVjG48NMz3Bwtuyd9aJEp3zGQ+e3LQNv
         zoZCtqtgtlFbMjkxneh7DAhDUjvok/9yj8KaVliZqhzMN7ctjzWLf2hzJH81CItQfriB
         dYw1Q5o541rMhDBM6Tg4N5SY/PeIP7vstkwiy5ih/E87XHzsITquO93on0cVGYBKKsv+
         6ewQ==
Received: by 10.66.87.133 with SMTP id ay5mr32357798pab.59.1352155651272;
        Mon, 05 Nov 2012 14:47:31 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:30 -0800 (PST)
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
Subject: [PATCH 00/16] mm: use augmented rbtrees for finding unmapped areas
Date:   Mon,  5 Nov 2012 14:46:57 -0800
Message-Id: <1352155633-8648-1-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
X-Gm-Message-State: ALoCoQlFnHQoSnRv045pGlaB7HwhYsZiycvFODXkTZQ4YV4tTS+qv9UQsEDm+4RKR7ts8qY42CAy4KCEEdrltPHEe1c6C/FYzzcybP7K4a3jfVz9VFc9m9RRxjdSUxmpD363N9ZF5C3iTkOMwDkF8EmqFLnFju2xVEteddMnlqLNKQlPRcG6x7Nkz3rG3nLhhT3VG95Zbp5xAMA57B6d2MgnyYxOJUopow==
X-archive-position: 34870
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

Earlier this year, Rik proposed using augmented rbtrees to optimize
our search for a suitable unmapped area during mmap(). This prompted
my work on improving the augmented rbtree code. Rik doesn't seem to
have time to follow up on his idea at this time, so I'm sending this
series to revive the idea.

These changes are against v3.7-rc4. I have not converted all applicable
architectuers yet, but we don't necessarily need to get them all onboard
at once - the series is fully bisectable and additional architectures
can be added later on. I am confident enough in my tests for patches 1-8;
however the second half of the series basically didn't get tested as
I don't have access to all the relevant architectures.

Change log  since the previous (RFC) send:
- Added bug fix in validate_mm(), noticed by Sasha Levin and figured
  out by Bob Liu, which sometimes caused NULL pointer dereference when
  running with CONFIG_DEBUG_VM_RB=y
- Fixed generic and x86_64 arch_get_unmapped_area_topdown to avoid
  allocating new areas at addr=0 as suggested by Rik Van Riel
- Converted more architectures to use the new vm_unmapped_area()
  search function
- Converted hugetlbfs (generic / i386 / sparc64 / tile) to use the new
  vm_unmapped_area() search function as well.

In this resend, I have kept Rik's Reviewed-by tags from the original
RFC submission for patches that haven't been updated other than applying
his suggestions.

Patch 1 is the validate_mm() fix from Bob Liu (+ fixed-the-fix from me :)

Patch 2 augments the VMA rbtree with a new rb_subtree_gap field,
indicating the length of the largest gap immediately preceding any
VMAs in a subtree.

Patch 3 adds new checks to CONFIG_DEBUG_VM_RB to verify the above
information is correctly maintained.

Patch 4 rearranges the vm_area_struct layout so that rbtree searches only
need data that is contained in the first cacheline (this one is from
Rik's original patch series)

Patch 5 adds a generic vm_unmapped_area() search function, which
allows for searching for an address space of any desired length,
within [low; high[ address constraints, with any desired alignment.
The generic arch_get_unmapped_area[_topdown] functions are also converted
to use this.

Patch 6 converts the x86_64 arch_get_unmapped_area[_topdown] functions
to use vm_unmapped_area() as well.

Patch 7 fixes cache coloring on x86_64, as suggested by Rik in his
previous series.

Patch 8 and 9 convert the generic and i386 hugetlbfs code to use
vm_unmapped_area()

Patches 10-16 convert extra architectures to use vm_unmapped_area()

I'm happy that this series removes more code than it adds, as calling
vm_unmapped_area() with the desired arguments is quite shorter than
duplicating the brute force algorithm all over the place. There is
still a bit of repetition between various implementations of
arch_get_unmapped_area[_topdown] functions that could probably be
simplified somehow, but I feel we can keep that for a later step...

Michel Lespinasse (15):
  mm: add anon_vma_lock to validate_mm()
  mm: augment vma rbtree with rb_subtree_gap
  mm: check rb_subtree_gap correctness
  mm: vm_unmapped_area() lookup function
  mm: use vm_unmapped_area() on x86_64 architecture
  mm: fix cache coloring on x86_64 architecture
  mm: use vm_unmapped_area() in hugetlbfs
  mm: use vm_unmapped_area() in hugetlbfs on i386 architecture
  mm: use vm_unmapped_area() on mips architecture
  mm: use vm_unmapped_area() on arm architecture
  mm: use vm_unmapped_area() on sh architecture
  mm: use vm_unmapped_area() on sparc64 architecture
  mm: use vm_unmapped_area() in hugetlbfs on sparc64 architecture
  mm: use vm_unmapped_area() on sparc32 architecture
  mm: use vm_unmapped_area() in hugetlbfs on tile architecture

Rik van Riel (1):
  mm: rearrange vm_area_struct for fewer cache misses

 arch/arm/mm/mmap.c               |  119 ++--------
 arch/mips/mm/mmap.c              |   99 ++-------
 arch/sh/mm/mmap.c                |  126 ++---------
 arch/sparc/kernel/sys_sparc_32.c |   24 +--
 arch/sparc/kernel/sys_sparc_64.c |  132 +++---------
 arch/sparc/mm/hugetlbpage.c      |  123 +++--------
 arch/tile/mm/hugetlbpage.c       |  139 ++----------
 arch/x86/include/asm/elf.h       |    6 +-
 arch/x86/kernel/sys_x86_64.c     |  151 +++----------
 arch/x86/mm/hugetlbpage.c        |  130 ++---------
 arch/x86/vdso/vma.c              |    2 +-
 fs/hugetlbfs/inode.c             |   42 +---
 include/linux/mm.h               |   31 +++
 include/linux/mm_types.h         |   19 ++-
 mm/mmap.c                        |  452 +++++++++++++++++++++++++++++---------
 15 files changed, 616 insertions(+), 979 deletions(-)

-- 
1.7.7.3
