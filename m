Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 15:46:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45491 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990508AbdAFOqFF5O7a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 15:46:05 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 224468135EE6B;
        Fri,  6 Jan 2017 14:45:56 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 14:45:58 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 0/3] KVM: MIPS: Use CP0_BadInstr[P] for emulation
Date:   Fri, 6 Jan 2017 14:44:40 +0000
Message-ID: <cover.bf96bfd5329a1b0bbde5c97362c9284cafcc0300.1483713106.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56216
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

This series implements the use of the CP0_BadInstr and CP0_BadInstrP
registers for instruction emulation in MIPS KVM when they are available.
These provide the encoding of a faulting instruction (and its prior
branch instruction if applicable).

The use of these registers should be more robust than using
kvm_get_inst(), as it actually gives the instruction encoding seen by
the hardware rather than relying on user accessors after the fact, which
can be fooled by incoherent icache or a racing code modification. It
will also work with VZ, where the guest virtual memory isn't directly
accessible by the host with user accessors.

The series is based on my recent "KVM: MIPS: Implement GVA page tables"
series

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org

James Hogan (3):
  KVM: MIPS/T&E: Don't treat code fetch faults as MMIO
  KVM: MIPS: Improve kvm_get_inst() error return
  KVM: MIPS: Use CP0_BadInstr[P] for emulation

 arch/mips/include/asm/kvm_host.h |  34 +++++++-
 arch/mips/kvm/emulate.c          | 132 +++++++++++++++++++++-----------
 arch/mips/kvm/entry.c            |  14 +++-
 arch/mips/kvm/mips.c             |   7 +-
 arch/mips/kvm/mmu.c              |   9 +--
 arch/mips/kvm/trap_emul.c        |  12 +++-
 6 files changed, 155 insertions(+), 53 deletions(-)

-- 
git-series 0.8.10
