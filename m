Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:50:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59069 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992111AbdAPMttuksfk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:49 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BBCC494C9C593;
        Mon, 16 Jan 2017 12:49:38 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:41 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 0/13] KVM: MIPS: Dirty logging, SYNC_MMU & READONLY_MEM
Date:   Mon, 16 Jan 2017 12:49:21 +0000
Message-ID: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56320
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

Note: My intention is to take this series via the MIPS KVM tree. This
series is based on my other series posted this cycle:
[0/10] KVM: MIPS: Implement GVA page tables and shadow flushing
[0/3]  KVM: MIPS: Use CP0_BadInstr[P] for emulation
[0/30] KVM: MIPS: Implement GVA page tables

This series adds proper dirty page logging, KVM_CAP_SYNC_MMU, and
KVM_CAP_READONLY_MEM support to MIPS KVM.

The existing dirty page logging support (integral to live migration) was
basically incomplete as pages were never marked read only or recorded as
being dirty on a TLB modified exception. This series incrementally adds
proper support, using the dirty bit in the GPA and GVA page tables to
trigger TLB modified exceptions.

Support is added for KVM_CAP_SYNC_MMU, which adds MMU notifiers so that
KVM can react to asynchronous (and synchronous) host virtual MM changes.
This allows for several features to work with guest RAM which require
mappings to be altered or protected, such as copy-on-write, KSM (Kernel
Samepage Merging), idle page tracking, memory swapping, and guest memory
ballooning, as well as paving the way for KVM_CAP_READONLY_MEM.

Finally support is added for read only memory regions
(KVM_CAP_READONLY_MEM), which can be supported fairly minimally once
dirty page logging and KVM_CAP_SYNC_MMU are in place. This allows memory
regions to be marked read only to the guest so that reads work but
writes trigger MMIO.

The patches are roughly grouped as follows:

Patches 1-2:
  Preliminary changes for readonly regions / dirty logging.

Patches 3-5:
  Add handling of read only regions (or areas with no region) as MMIO,
  and also call fault handling for dirty logging.

Patches 6-11:
  Incrementally add proper dirty logging support, first making ranges of
  GPA clean when log read or region is made readonly, then adding the
  fast path fault handling for dirty logging, and finally transferring
  GPA protection bits (including dirty) across to GVA page tables so
  they take effect.

Patch 12:
  Add KVM_CAP_SYNC_MMU support.

Patch 13:
  Enable KVM_CAP_READONLY_MEM. This is after KVM_CAP_SYNC_MMU support as
  it needs to use gfn_to_pfn_prot() to know whether the GFN is read
  only, which opens up the possibility of getting copy-on-write enabled
  pages, which aren't safe without KVM_CAP_SYNC_MMU since the guest
  mappings wouldn't get updated after a copy-on-write took place.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org

James Hogan (13):
  KVM: MIPS/T&E: Ignore user writes to CP0_Config7
  KVM: MIPS: Pass type of fault down to kvm_mips_map_page()
  KVM: MIPS/T&E: Abstract bad access handling
  KVM: MIPS/T&E: Treat unhandled guest KSeg0 as MMIO
  KVM: MIPS/T&E: Handle read only GPA in TLB mod
  KVM: MIPS/MMU: Add GPA PT mkclean helper
  KVM: MIPS/MMU: Use generic dirty log & protect helper
  KVM: MIPS: Clean & flush on dirty page logging enable
  KVM: MIPS/MMU: Handle dirty logging on GPA faults
  KVM: MIPS/MMU: Pass GPA PTE bits to KSeg0 GVA PTEs
  KVM: MIPS/MMU: Pass GPA PTE bits to mapped GVA PTEs
  KVM: MIPS/MMU: Implement KVM_CAP_SYNC_MMU
  KVM: MIPS: Claim KVM_CAP_READONLY_MEM support

 arch/mips/include/asm/kvm_host.h |  28 +-
 arch/mips/include/uapi/asm/kvm.h |   2 +-
 arch/mips/kvm/Kconfig            |   2 +-
 arch/mips/kvm/emulate.c          |  38 +--
 arch/mips/kvm/mips.c             |  68 ++--
 arch/mips/kvm/mmu.c              | 546 ++++++++++++++++++++++++++++----
 arch/mips/kvm/trap_emul.c        | 203 +++++++-----
 7 files changed, 693 insertions(+), 194 deletions(-)

-- 
git-series 0.8.10
