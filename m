Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 11:52:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35792 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010458AbbGWJvudoAll (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jul 2015 11:51:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6N9pk90009312;
        Thu, 23 Jul 2015 11:51:47 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6N9ph6T009311;
        Thu, 23 Jul 2015 11:51:43 +0200
Message-Id: <cover.1437644062.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
Date:   Thu, 23 Jul 2015 11:34:22 +0200
Subject: [PATCH 0/2] RIXI fixes.
To:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

As part of unrelated work I ran into issus with RIXI support which allows
the creation of pages that are executable but not readable.  Problems
arise with instruction emulation on such pages, for example when a load
or store instruction is taking an unaligned exception, is an FPU
instruction that requires emulation, a trap or break instruction of
which the break code needs to bread and more.

A better solution would be to create a temporary mapping using
kmap_coherent() but that's more complex so left for a later stage.

These patches have been sitting in a shady git tree for years but seem to
work for me.  Nevertheless Comments appreciated.

Cheers,

  Ralf

Ralf Baechle (2):
  MIPS: Handle page faults of executable but unreadable pages correctly.
  MIPS: Partially disable RIXI support.

 arch/mips/mm/cache.c | 8 ++++----
 arch/mips/mm/fault.c | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.4.3
