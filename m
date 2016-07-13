Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:14:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6602 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992554AbcGMNNZzPtvh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:25 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A8D30AD401458;
        Wed, 13 Jul 2016 14:13:06 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, Paul Burton
        <paul.burton@imgtec.com>, Leonid Yegoshin <leonid.yegoshin@imgtec.com>, Felix
 Fietkau <nbd@nbd.name>, David Daney <david.daney@cavium.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Hongliang Tao <taohl@lemote.com>, Huacai
 Chen <chenhc@lemote.com>, Hua Yan <yanh@lemote.com>, Jayachandran C.
        <jchandra@broadcom.com>, Kevin Cernekee <cernekee@gmail.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 00/13] MIPS: c-r4k: SMP cache management fixes
Date:   Wed, 13 Jul 2016 14:12:43 +0100
Message-ID: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

These patches collect together various SMP cache management fixes &
refactorings, particularly to fix the missing SMP calls for indexed
cache ops on MIPS Coherence Manager (CM) based SMP systems since commit
cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores").

Patches 1-6 fix various issues in the SMP code and cache management code
(all in relation to cache management).

Patches 7-12 then prepare r4k_on_each_cpu() and its various
callers/callees to distinguish hit/index cache ops so SMP calls can be
avoided.

Finally patch 13 makes the change for CM so that indexed cache ops are
performed on each core via SMP calls.

Patch 9 should also work around the SMP 34Kc regression Felix saw
recently, but __flush_anon_page() and r4k_flush_data_cache_page()
definitely still need looking at too.

All feedback & testing gratefully received.

James Hogan (13):
  MIPS: SMP: Clear ASID without confusing has_valid_asid()
  MIPS: SMP: Update cpu_foreign_map on CPU disable
  MIPS: SMP: Drop stop_this_cpu() cpu_foreign_map hack
  MIPS: c-r4k: Fix protected_writeback_scache_line for EVA
  MIPS: c-r4k: Fix sigtramp SMP call to use kmap
  MIPS: c-r4k: Avoid dcache flush for sigtramps

  MIPS: c-r4k: Add r4k_on_each_cpu cache op type arg
  MIPS: c-r4k: Fix valid ASID optimisation
  MIPS: c-r4k: Exclude sibling CPUs in SMP calls
  MIPS: c-r4k: Split r4k_flush_kernel_vmap_range()
  MIPS: c-r4k: Local flush_icache_range cache op override
  MIPS: c-r4k: Avoid small flush_icache_range SMP calls

  MIPS: c-r4k: Use SMP calls for CM indexed cache ops

 arch/mips/cavium-octeon/smp.c         |   1 +
 arch/mips/include/asm/r4kcache.h      |   4 +
 arch/mips/include/asm/smp.h           |   4 +-
 arch/mips/kernel/smp-bmips.c          |   1 +
 arch/mips/kernel/smp-cps.c            |   1 +
 arch/mips/kernel/smp.c                |  34 +++--
 arch/mips/loongson64/loongson-3/smp.c |   1 +
 arch/mips/mm/c-r4k.c                  | 274 ++++++++++++++++++++++++++++------
 8 files changed, 257 insertions(+), 63 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: Felix Fietkau <nbd@nbd.name>
Cc: David Daney <david.daney@cavium.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Hongliang Tao <taohl@lemote.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Hua Yan <yanh@lemote.com>
Cc: Jayachandran C. <jchandra@broadcom.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-mips@linux-mips.org
-- 
2.4.10
