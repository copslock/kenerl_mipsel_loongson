Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2015 16:07:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15239 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026159AbbD0OHggeM7S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2015 16:07:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3603C42F7F56A;
        Mon, 27 Apr 2015 15:07:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Apr 2015 15:07:31 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 27 Apr 2015 15:07:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 0/4] MIPS: Misc fixes (mostly relating to KVM guests)
Date:   Mon, 27 Apr 2015 15:07:15 +0100
Message-ID: <1430143639-22580-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47088
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

Here are a few miscellaneous MIPS fixes, which were mostly found by
running an up to date KVM guest kernel.

Patch 1 fixes the fixmap address for KVM guests, which was never updated
to reside in USEG.

Patch 2 fixes a bug in the XPA patches, which seems to manifest in KVM
guests in particular (for unclear reasons).
Patch 3 makes a tweak related to patch 2.
(Steven's review of these two patches in particular would be
appreciated).

Finally patch 4 enables ZONE_DMA32 on 64-bit Malta kernels to prevent
exhaustion of the 16MiB DMA zone being a problem (try enabling
KVM_PROVE_LOCKING in a recent kernel).

James Hogan (4):
  MIPS: Fix KVM guest fixmap address
  MIPS: tlbex: Fix broken offsets on r2 without XPA
  MIPS: tlbex: Avoid unnecessary _PAGE_PRESENT shifts
  MIPS: Malta: Select 32bit DMA zone for 64-bit kernels

 arch/mips/Kconfig                           |  1 +
 arch/mips/include/asm/mach-generic/spaces.h |  4 ++++
 arch/mips/mm/tlbex.c                        | 31 +++++++++++++++++++++--------
 3 files changed, 28 insertions(+), 8 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
-- 
2.0.5
