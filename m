Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:17:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62350 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822093AbaE2JRB47Rwg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 98C22BB8661D9;
        Thu, 29 May 2014 10:16:52 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 29 May
 2014 10:16:54 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:16:54 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:16:53 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 00/23] MIPS: KVM: Fixes and guest timer rewrite
Date:   Thu, 29 May 2014 10:16:22 +0100
Message-ID: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40321
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

Here are a range of MIPS KVM T&E fixes, preferably for v3.16 but I know
it's probably a bit late now. Changes are pretty minimal though since
v1 so please consider. They can also be found on my kvm_mips_queue
branch (and the kvm_mips_timer_v2 tag) here:
git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git

They originally served to allow it to work better on Ingenic XBurst
cores which have some peculiarities which break non-portable assumptions
in the MIPS KVM implementation (patches 1-4, 13).

Fixing guest CP0_Count emulation to work without a running host
CP0_Count (patch 13) however required a rewrite of the timer emulation
code to use the kernel monotonic time instead, which needed doing anyway
since basing it directly off the host CP0_Count was broken. Various bugs
were fixed in the process (patches 10-12) and improvements made thanks to
valuable feedback from Paolo Bonzini for the last QEMU MIPS/KVM patchset
(patches 5-7, 15-16).

Finally there are some misc cleanups which I did along the way (patches
17-23).

Only the first patch (fixes MIPS KVM with 4K pages) is marked for
stable. For KVM to work on XBurst it needs the timer rework which is a
fairly complex change, so there's little point marking any of the XBurst
specific changes for stable.

All feedback welcome!

Patches 1-4:
	Fix KVM/MIPS with 4K pages, missing RDHWR SYNCI (XBurst),
	unmoving CP0_Random (XBurst).
Patches 5-9:
	Add EPC, Count, Compare, UserLocal, HWREna guest CP0 registers
	to KVM register ioctl interface.
Patches 10-12:
	Fix a few potential races relating to timers.
Patches 13-14:
	Rewrite guest timer emulation to use ktime_get().
Patches 15-16:
	Add KVM virtual registers for controlling guest timer, including
	master timer disable, and timer frequency.
Patches 17-23:
	Cleanups.

Changes in v2 (tag:kvm_mips_timer_v2):
 Patchset:
 - Drop patch 4 "MIPS: KVM: Fix CP0_EBASE KVM register id" (David
   Daney).
 - Drop patch 14 "MIPS: KVM: Add nanosecond count bias KVM register".
   The COUNT_CTL and COUNT_RESUME API is clean and sufficient.
 - Add missing access to UserLocal and HWREna guest CP0 registers
   (patches 15 and 16).
 - Add export of local_flush_icache_range (patch 2).
 Patch 12 MIPS: KVM: Migrate hrtimer to follow VCPU
 - Move kvm_mips_migrate_count() into kvm_tlb.c to fix a link error when
   KVM is built as a module, since kvm_tlb.c is built statically and
   cannot reference symbols in kvm_mips_emul.c.
 Patch 15 MIPS: KVM: Add master disable count interface
 - Make KVM_REG_MIPS_COUNT_RESUME writable too so that userland can
   control timer using master DC and without bias register. New values
   are rejected if they refer to a monotonic time in the future.
 - Expand on description of KVM_REG_MIPS_COUNT_RESUME about the effects
   of the register and that it can be written.

v1 (tag:kvm_mips_timer_v1):
 see http://marc.info/?l=kvm&m=139843936102657&w=2

James Hogan (23):
  MIPS: KVM: Allocate at least 16KB for exception handlers
  MIPS: Export local_flush_icache_range for KVM
  MIPS: KVM: Use local_flush_icache_range to fix RI on XBurst
  MIPS: KVM: Use tlb_write_random
  MIPS: KVM: Add CP0_EPC KVM register access
  MIPS: KVM: Move KVM_{GET,SET}_ONE_REG definitions into kvm_host.h
  MIPS: KVM: Add CP0_Count/Compare KVM register access
  MIPS: KVM: Add CP0_UserLocal KVM register access
  MIPS: KVM: Add CP0_HWREna KVM register access
  MIPS: KVM: Deliver guest interrupts after local_irq_disable()
  MIPS: KVM: Fix timer race modifying guest CP0_Cause
  MIPS: KVM: Migrate hrtimer to follow VCPU
  MIPS: KVM: Rewrite count/compare timer emulation
  MIPS: KVM: Override guest kernel timer frequency directly
  MIPS: KVM: Add master disable count interface
  MIPS: KVM: Add count frequency KVM register
  MIPS: KVM: Make kvm_mips_comparecount_{func,wakeup} static
  MIPS: KVM: Whitespace fixes in kvm_mips_callbacks
  MIPS: KVM: Fix kvm_debug bit-rottage
  MIPS: KVM: Remove ifdef DEBUG around kvm_debug
  MIPS: KVM: Quieten kvm_info() logging
  MIPS: KVM: Remove redundant NULL checks before kfree()
  MIPS: KVM: Remove redundant semicolon

 arch/mips/Kconfig                 |  12 +-
 arch/mips/include/asm/kvm_host.h  | 183 ++++++++++---
 arch/mips/include/uapi/asm/kvm.h  |  35 +++
 arch/mips/kvm/kvm_locore.S        |  32 ---
 arch/mips/kvm/kvm_mips.c          | 140 +++++-----
 arch/mips/kvm/kvm_mips_dyntrans.c |  15 +-
 arch/mips/kvm/kvm_mips_emul.c     | 557 ++++++++++++++++++++++++++++++++++++--
 arch/mips/kvm/kvm_tlb.c           |  77 +++---
 arch/mips/kvm/kvm_trap_emul.c     |  86 +++++-
 arch/mips/mm/cache.c              |   1 +
 arch/mips/mti-malta/malta-time.c  |  14 +-
 11 files changed, 920 insertions(+), 232 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
-- 
1.9.3
