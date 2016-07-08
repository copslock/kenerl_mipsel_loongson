Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:54:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54522 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992682AbcGHKxxuwAbv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:53:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0F8104ED0AF28;
        Fri,  8 Jul 2016 11:53:45 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:47 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 00/12] MIPS: KVM: 64-bit host support
Date:   Fri, 8 Jul 2016 11:53:19 +0100
Message-ID: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54258
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

Add basic MIPS KVM support for 64-bit host kernels, primarily to prepare
for VZ support on MIPS64 processors. Note, this does not allow 64-bit
guests to be supported. This patchset is based on my recent r6 support
patchset.

Patches 1-11 fix various distinct parts of KVM MIPS that aren't portable
to a 64-bit host kernel, and patch 12 allows KVM to be enabled on such
kernels.

Only patches 1 & 12 touch anything outside of MIPS KVM. Patch 1 in
particular needs some imput from general MIPS folk.

James Hogan (12):
  MIPS: Fix definition of KSEGX() for 64-bit
  MIPS: KVM: Use virt_to_phys() to get commpage PFN
  MIPS: KVM: Use kmap instead of CKSEG0ADDR()
  MIPS: KVM: Make entry code MIPS64 friendly
  MIPS: KVM: Set CP0_Status.KX on MIPS64
  MIPS: KVM: Use 64-bit CP0_EBase when appropriate
  MIPS: KVM: Fail if ebase doesn't fit in CP0_EBase
  MIPS: KVM: Fix 64-bit big endian dynamic translation
  MIPS: KVM: Sign extend MFC0/RDHWR results
  MIPS: KVM: Fix ptr->int cast via KVM_GUEST_KSEGX()
  MIPS: KVM: Reset CP0_PageMask during host TLB flush
  MIPS: Select HAVE_KVM for MIPS64_R{2,6}

 arch/mips/Kconfig                 |  2 +
 arch/mips/include/asm/addrspace.h |  2 +-
 arch/mips/kvm/dyntrans.c          | 27 +++++++++----
 arch/mips/kvm/emulate.c           |  7 ++--
 arch/mips/kvm/entry.c             | 83 +++++++++++++++++++++++++--------------
 arch/mips/kvm/mips.c              | 12 ++++++
 arch/mips/kvm/mmu.c               |  7 +++-
 arch/mips/kvm/tlb.c               |  4 +-
 8 files changed, 102 insertions(+), 42 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
-- 
2.4.10
