Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 17:47:17 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:49681 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012214AbbA2QqmH2eBC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 17:46:42 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1YGsBB-00011X-4b; Thu, 29 Jan 2015 10:42:53 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 0/3] HIGHMEM and cache flush fixes.
Date:   Thu, 29 Jan 2015 10:46:13 -0600
Message-Id: <1422549976-10648-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

This patchset fixes HIGHMEM and utilizes kmap coloring support. The
other two patches fix some cache flushing corner cases.

Leonid Yegoshin (3):
  MIPS: Fix cache flushing for swap pages with non-DMA I/O.
  MIPS: Highmem: Fixes for cache aliasing and color.
  MIPS: Fix I-cache flushing for kmap'd pages.

 arch/mips/Kconfig                    |    1 +
 arch/mips/include/asm/cacheflush.h   |    3 +-
 arch/mips/include/asm/cpu-features.h |    6 ++
 arch/mips/include/asm/fixmap.h       |   18 +++++-
 arch/mips/include/asm/highmem.h      |   33 +++++++++++
 arch/mips/include/asm/page.h         |    5 +-
 arch/mips/include/asm/pgtable.h      |    5 ++
 arch/mips/mm/c-r4k.c                 |   44 ++++++++++++--
 arch/mips/mm/cache.c                 |  108 ++++++++++++++++++++++------------
 arch/mips/mm/highmem.c               |   43 +++++---------
 arch/mips/mm/init.c                  |   35 ++++++-----
 arch/mips/mm/sc-mips.c               |    1 +
 12 files changed, 210 insertions(+), 92 deletions(-)

-- 
1.7.10.4
