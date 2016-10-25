Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 17:08:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29346 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992663AbcJYPIhBxTah (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2016 17:08:37 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 572F8394D476E;
        Tue, 25 Oct 2016 16:08:27 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 25 Oct 2016 16:08:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 0/3] KVM: MIPS: Miscellaneous 4.9 fixes
Date:   Tue, 25 Oct 2016 16:08:18 +0100
Message-ID: <cover.c0ced53ae71e1272ec1aaa16007e9eebb1c0eac6.1477320903.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55574
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

A few more fixes intended for v4.9. Patches 2 & 3 are tagged for stable.

- The first fixes lazy user ASID regeneration which was introduced in
  4.9-rc1 and still wasn't quite right for SMP hosts.

- The second is a minor incorrect behaviour in ERET emulation when both
  ERL and EXL are set (i.e. unlikely to hit in practice), which has been
  wrong since MIPS KVM was added in v3.10.

- The third fixes a slightly risky completion of an MMIO load in branch
  delay slot, where it'll try and read guest code outside of the proper
  context. Currently we should only be able to hit this if the MMIO load
  in branch delay slot is in guest TLB mapped (i.e. kernel module) code.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org

James Hogan (3):
  KVM: MIPS: Fix lazy user ASID regenerate for SMP
  KVM: MIPS: Make ERET handle ERL before EXL
  KVM: MIPS: Precalculate MMIO load resume PC

 arch/mips/include/asm/kvm_host.h |  7 ++++---
 arch/mips/kvm/emulate.c          | 32 +++++++++++++++++++-------------
 arch/mips/kvm/mips.c             |  5 ++++-
 arch/mips/kvm/mmu.c              |  4 ----
 4 files changed, 27 insertions(+), 21 deletions(-)

-- 
git-series 0.8.10
