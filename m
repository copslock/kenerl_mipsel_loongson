Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 17:20:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:15530 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817913AbaDYPUhak3Af (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 17:20:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 44A3BBFB3D0E5;
        Fri, 25 Apr 2014 16:20:27 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Fri, 25 Apr
 2014 16:20:30 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 25 Apr 2014 16:20:29 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 25 Apr 2014 16:20:29 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 00/21] MIPS: KVM: Fixes and guest timer rewrite
Date:   Fri, 25 Apr 2014 16:19:43 +0100
Message-ID: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39925
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

Here are a range of MIPS KVM T&E fixes for v3.16. They can also be found
on my kvm_mips_queue branch here:
git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git

They originally served to allow it to work better on Ingenic XBurst
cores which have some peculiarities which break non-portable assumptions
in the MIPS KVM implementation (patches 1-3, 11).

Fixing guest CP0_Count emulation to work without a running host
CP0_Count (patch 11) however required a rewrite of the timer emulation
code to use the kernel monotonic time instead, which needed doing anyway
since basing it directly off the host CP0_Count was broken. Various bugs
were fixed in the process (patches 8-10) and improvements made thanks to
valuable feedback from Paolo Bonzini for the last QEMU MIPS/KVM patchset
(patches 4-7, 13-15).

Finally there are some misc cleanups which I did along the way (patches
16-21).

Only the first patch (fixes MIPS KVM with 4K pages) is marked for
stable. For KVM to work on XBurst it needs the timer rework which is a
fairly complex change, so there's little point marking any of the XBurst
specific changes for stable.

All feedback welcome!

Patches 1-3:
	Fix KVM/MIPS with 4K pages, missing RDHWR SYNCI (XBurst),
	unmoving CP0_Random (XBurst).
Patches 4-7:
	Add EPC, Count, Compare guest CP0 registers to KVM register
	ioctl interface.
Patches 8-10:
	Fix a few potential races relating to timers.
Patches 11-12:
	Rewrite guest timer emulation to use ktime_get().
Patches 13-15:
	Add KVM virtual registers for controlling guest timer, including
	master timer disable, nanosecond bias, and timer frequency.
Patches 16-21:
	Cleanups.

James Hogan (21):
  MIPS: KVM: Allocate at least 16KB for exception handlers
  MIPS: KVM: Use local_flush_icache_range to fix RI on XBurst
  MIPS: KVM: Use tlb_write_random
  MIPS: KVM: Fix CP0_EBASE KVM register id
  MIPS: KVM: Add CP0_EPC KVM register access
  MIPS: KVM: Move KVM_{GET,SET}_ONE_REG definitions into kvm_host.h
  MIPS: KVM: Add CP0_Count/Compare KVM register access
  MIPS: KVM: Deliver guest interrupts after local_irq_disable()
  MIPS: KVM: Fix timer race modifying guest CP0_Cause
  MIPS: KVM: Migrate hrtimer to follow VCPU
  MIPS: KVM: Rewrite count/compare timer emulation
  MIPS: KVM: Override guest kernel timer frequency directly
  MIPS: KVM: Add master disable count interface
  MIPS: KVM: Add nanosecond count bias KVM register
  MIPS: KVM: Add count frequency KVM register
  MIPS: KVM: Make kvm_mips_comparecount_{func,wakeup} static
  MIPS: KVM: Whitespace fixes in kvm_mips_callbacks
  MIPS: KVM: Fix kvm_debug bit-rottage
  MIPS: KVM: Remove ifdef DEBUG around kvm_debug
  MIPS: KVM: Quieten kvm_info() logging
  MIPS: KVM: Remove redundant NULL checks before kfree()

 arch/mips/Kconfig                 |  12 +-
 arch/mips/include/asm/kvm_host.h  | 185 +++++++++---
 arch/mips/include/uapi/asm/kvm.h  |  40 +++
 arch/mips/kvm/kvm_locore.S        |  32 --
 arch/mips/kvm/kvm_mips.c          | 127 ++++----
 arch/mips/kvm/kvm_mips_dyntrans.c |  15 +-
 arch/mips/kvm/kvm_mips_emul.c     | 608 ++++++++++++++++++++++++++++++++++++--
 arch/mips/kvm/kvm_tlb.c           |  60 ++--
 arch/mips/kvm/kvm_trap_emul.c     |  89 +++++-
 arch/mips/mti-malta/malta-time.c  |  14 +-
 10 files changed, 951 insertions(+), 231 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
-- 
1.8.1.2
