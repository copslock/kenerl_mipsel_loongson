Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:30:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21699 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbcIAQauaPTE2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:30:50 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ED86EF3D9C03D;
        Thu,  1 Sep 2016 17:30:30 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:30:34 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 0/9] MIPS: General EVA fixes & cleanups
Date:   Thu, 1 Sep 2016 17:30:06 +0100
Message-ID: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54928
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

These patches fix some general MIPS Enhanced Virtual Addressing (EVA)
issues, with the aim of allowing KVM to be fixed to work on EVA host
kernels.

Patches 1-3 improve the CP0_EBase handling, particularly in relation to
the Write Gate (WG) bit which allows the upper bits (63:30 on MIPS64,
31:30 on MIPS32) to be modified. This allows CP0_EBase to be set
correctly with EVA, even when the boot time allocated exception vector
is not in KSeg0. They will also help with Matt's upcoming rproc patches.

Patch 4 then drops the EVA specific L2 cache flushing from
flush_icache_range(), which appeared to work around the partial
CP0_EBase assignment fixed by patch 3.

Patches 5-9 fix the semantics of flush_icache_range(), which only works
on user pointers with EVA. We add a new __flush_icache_user_range() API
in patch 5, fix users of flush_icache_range() with user pointers in
patches 6-8, and finally separate the implementations so that
flush_icache_range() works with kernel addresses in patch 9.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org

James Hogan (8):
  MIPS: traps: 64bit kernels should read CP0_EBase 64bit
  MIPS: traps: Convert ebase to KSeg0
  MIPS: c-r4k: Drop bc_wback_inv() from icache flush
  MIPS: c-r4k: Split user/kernel flush_icache_range()
  MIPS: cacheflush: Use __flush_icache_user_range()
  MIPS: uprobes: Flush icache via kernel address
  MIPS: KVM: Use __local_flush_icache_user_range()
  MIPS: c-r4k: Fix flush_icache_range() for EVA

Matt Redfearn (1):
  MIPS: traps: Ensure full EBase is written

 arch/mips/include/asm/cacheflush.h |  5 +++-
 arch/mips/kernel/traps.c           | 49 +++++++++++++++++++++++++++--
 arch/mips/kernel/uprobes.c         | 13 ++------
 arch/mips/kvm/dyntrans.c           |  4 +-
 arch/mips/mm/c-octeon.c            |  2 +-
 arch/mips/mm/c-r3k.c               |  2 +-
 arch/mips/mm/c-r4k.c               | 52 ++++++++++++++++++++-----------
 arch/mips/mm/c-tx39.c              |  3 ++-
 arch/mips/mm/cache.c               |  6 +++-
 9 files changed, 104 insertions(+), 32 deletions(-)

-- 
git-series 0.8.10
