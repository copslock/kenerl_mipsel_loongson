Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 21:03:14 +0200 (CEST)
Received: from mail-la0-f51.google.com ([209.85.215.51]:34086 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6863501AbaGVTB2azoxP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 21:01:28 +0200
Received: by mail-la0-f51.google.com with SMTP id el20so69168lab.38
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=25ONpWtM7bvQh3stQog/eYz5dT17bSGMi2zoNUJ+0iY=;
        b=EV7bwWx3iZ14jBcBD4Od/GHi/dEnB9u+9jBnIjkti0y6ykxR0sstYRQUSu2LKpZBsz
         Dfcr+N7pJiB+sC27a59WoZU3nXqDw2ja69ldxXWU7yvsE2HTEB6qWpWY8rR+8PLDZBFx
         DceYeLDz0FfZH0PZ6/EEo7mGpUQ9V+/RZH5xhlJ611N0qVRnrHLPJCgBmh0Ar+Y6CVnS
         QkRw+wZQjJAKWeRN63klgMFxg1HMRN4KD+qqRcAVctTTlal0MKTt8pbWl+ryAVu5RPRE
         t90WInMC9UKgkDLONkCA8aOQ/SdiFg+0fKnsVUQvUewxTm2Q+8ts7a0h46hJXWTGwpgu
         o2bw==
X-Received: by 10.112.146.202 with SMTP id te10mr20480260lbb.75.1406055682835;
        Tue, 22 Jul 2014 12:01:22 -0700 (PDT)
Received: from octofox.metropolis ([5.18.160.1])
        by mx.google.com with ESMTPSA id a7sm677355lae.37.2014.07.22.12.01.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jul 2014 12:01:21 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, David Rientjes <rientjes@google.com>
Subject: [PATCH 0/8] xtensa: highmem support on cores with aliasing cache
Date:   Tue, 22 Jul 2014 23:01:05 +0400
Message-Id: <1406055673-10100-1-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 1.8.1.4
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

Hi,

this series implements highmem support on xtensa cores with aliasing cache.
It does so by making sure that high memory pages are always mapped at
virtual addresses with color that match color of their physical address.

This involves changing the generic kmap code to make it aware of cache
coloring. This part with corresponding arch changes is cc'd linux-mm,
linux-arch and linux-mips.

The whole series can also be found at:
git://github.com/jcmvbkbc/linux-xtensa.git xtensa-highmem-ca

Leonid Yegoshin (1):
  mm/highmem: make kmap cache coloring aware

Max Filippov (7):
  xtensa: make fixmap region addressing grow with index
  xtensa: allow fixmap and kmap span more than one page table
  xtensa: fix TLBTEMP_BASE_2 region handling in fast_second_level_miss
  xtensa: implement clear_user_highpage and copy_user_highpage
  xtensa: support aliasing cache in k[un]map_atomic
  xtensa: support aliasing cache in kmap
  xtensa: support highmem in aliasing cache flushing code

 arch/xtensa/include/asm/cacheflush.h |   2 +
 arch/xtensa/include/asm/fixmap.h     |  30 +++++++--
 arch/xtensa/include/asm/highmem.h    |  18 +++++-
 arch/xtensa/include/asm/page.h       |  14 ++++-
 arch/xtensa/include/asm/pgtable.h    |   7 ++-
 arch/xtensa/kernel/entry.S           |   2 +-
 arch/xtensa/mm/cache.c               |  77 ++++++++++++++++++++---
 arch/xtensa/mm/highmem.c             |  24 +++++---
 arch/xtensa/mm/misc.S                | 116 ++++++++++++++++-------------------
 arch/xtensa/mm/mmu.c                 |  38 +++++++-----
 mm/highmem.c                         |  19 +++++-
 11 files changed, 235 insertions(+), 112 deletions(-)

Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: David Rientjes <rientjes@google.com>
-- 
1.8.1.4
