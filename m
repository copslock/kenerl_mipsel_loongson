Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2016 12:52:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47118 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992501AbcHKKwtZ1D18 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2016 12:52:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5AE8E6A6A9B48;
        Thu, 11 Aug 2016 11:52:30 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 11 Aug 2016 11:52:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 0/4] MIPS: KVM: Fix MMU/TLB management issues
Date:   Thu, 11 Aug 2016 11:52:06 +0100
Message-ID: <cover.e70247d7d77e67a2331e65b6b7fd3894508e5d28.1470911944.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54479
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

These patches fix several issues in the management of MIPS KVM TLB
faults:

1) kvm_mips_handle_mapped_seg_tlb_fault() misbehaves for virtual address
   zero, which can be hit if the guest creates such a mapping and
   accesses it in a way unexpected for the commpage (e.g. a CACHE
   instruction).

2) kvm_mips_handle_mapped_seg_tlb_fault() doesn't range check the gfn,
   allowing a high mapping by the guest to overflow the guest_pmap[].

3) kvm_mips_handle_kseg0_tlb_fault() has an off by one in its gfn range
   check, which could allow an odd sized guest_pmap[] to be overflowed.

4) some callers of kvm_mips_handle_kseg0_tlb_fault() and
   kvm_mips_handle_mapped_seg_tlb_fault() don't correctly propagate
   errors upwards.

They're all marked for stable but won't apply cleanly before v4.8-rc1
due to recent changes. I have backports ready though.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org>

James Hogan (4):
  MIPS: KVM: Fix mapped fault broken commpage handling
  MIPS: KVM: Add missing gfn range check
  MIPS: KVM: Fix gfn range check in kseg0 tlb faults
  MIPS: KVM: Propagate kseg0/mapped tlb fault errors

 arch/mips/kvm/emulate.c | 35 ++++++++++++++++------
 arch/mips/kvm/mmu.c     | 68 +++++++++++++++++++++++++++---------------
 2 files changed, 70 insertions(+), 33 deletions(-)

-- 
git-series 0.8.7
