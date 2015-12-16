Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:50:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56149 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014039AbbLPXuKAjah0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id E0B2A5E77F46D;
        Wed, 16 Dec 2015 23:49:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:02 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:02 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 00/16] MIPS: KVM: Misc trivial cleanups
Date:   Wed, 16 Dec 2015 23:49:25 +0000
Message-ID: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50649
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

This patchset contains a bunch of miscellaneous cleanups (which are
mostly trivial) for MIPS KVM & MIPS headers, such as:
- Style/whitespace fixes
- General cleanup and removal of dead code.
- Moving/refactoring of general MIPS definitions out of arch/mips/kvm/
  and into arch/mips/include/asm/ so they can be shared with the rest of
  arch/mips. Specifically COP0 register bits, exception codes, cache
  ops, & instruction opcodes.
- Add MAINTAINERS entry for MIPS KVM.

Due to the interaction with other arch/mips/ code, I think it makes
sense for these to go via the MIPS tree.

James Hogan (16):
  MIPS: KVM: Trivial whitespace and style fixes
  MIPS: KVM: Drop some unused definitions from kvm_host.h
  MIPS: Move definition of DC bit to mipsregs.h
  MIPS: KVM: Drop unused kvm_mips_host_tlb_inv_index()
  MIPS: KVM: Convert EXPORT_SYMBOL to _GPL
  MIPS: KVM: Refactor added offsetof()s
  MIPS: KVM: Make kvm_mips_{init,exit}() static
  MIPS: Move Cause.ExcCode trap codes to mipsregs.h
  MIPS: Update trap codes
  MIPS: Use EXCCODE_ constants with set_except_vector()
  MIPS: Break down cacheops.h definitions
  MIPS: KVM: Use cacheops.h definitions
  MIPS: Move KVM specific opcodes into asm/inst.h
  MIPS: KVM: Add missing newline to kvm_err()
  MIPS: KVM: Consistent use of uint*_t in MMIO handling
  MAINTAINERS: Add KVM for MIPS entry

 MAINTAINERS                       |   8 +++
 arch/mips/Kconfig                 |   3 +-
 arch/mips/include/asm/cacheops.h  | 106 ++++++++++++++++++++--------------
 arch/mips/include/asm/kvm_host.h  |  39 +------------
 arch/mips/include/asm/mipsregs.h  |  34 +++++++++++
 arch/mips/include/uapi/asm/inst.h |   3 +-
 arch/mips/kernel/cpu-bugs64.c     |   8 +--
 arch/mips/kernel/traps.c          |  52 ++++++++---------
 arch/mips/kvm/callback.c          |   2 +-
 arch/mips/kvm/dyntrans.c          |  10 +---
 arch/mips/kvm/emulate.c           | 118 ++++++++++++++++----------------------
 arch/mips/kvm/interrupt.c         |   8 +--
 arch/mips/kvm/locore.S            |  12 ++--
 arch/mips/kvm/mips.c              |  38 ++++++------
 arch/mips/kvm/opcode.h            |  22 -------
 arch/mips/kvm/tlb.c               |  77 +++++++------------------
 arch/mips/kvm/trap_emul.c         |   1 -
 17 files changed, 245 insertions(+), 296 deletions(-)
 delete mode 100644 arch/mips/kvm/opcode.h

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
-- 
2.4.10
