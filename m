Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:29:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65003 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040983AbcFNK2Q0vQbY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:28:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B7D89EF38AED0;
        Tue, 14 Jun 2016 09:40:39 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Jun 2016 09:40:42 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 0/8] MIPS: KVM: Debug & trace event improvements
Date:   Tue, 14 Jun 2016 09:40:09 +0100
Message-ID: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54042
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

These patches improve debugging and trace events in MIPS KVM.

They are are based on my previous two MIPS KVM patchsets:

[PATCH 0/4] MIPS: KVM: Module + non dynamic translating fixes
[PATCH 00/18] MIPS: KVM: Miscellaneous clean-ups

Patch 1 is just a rename (in preparation for later VZ support), and is
included so that patch 2 doesn't have inconsistent naming or need
changing again later.

Patches 2-6 add and clean up KVM trace events:
- kvm_exit trace event cleaned up
- Add kvm_aux, kvm_asid_change, kvm_enter, kvm_reenter, kvm_out,
  kvm_hwr trace events.

Finally Patches 7-8 make a few minor tweaks for debugging purposes.

James Hogan (8):
  MIPS: KVM: Generalise fpu_inuse for other state
  MIPS: KVM: Add kvm_aux trace event
  MIPS: KVM: Clean up kvm_exit trace event
  MIPS: KVM: Add kvm_asid_change trace event
  MIPS: KVM: Add guest mode switch trace events
  MIPS: KVM: Trace guest register access emulation
  MIPS: KVM: Dump guest tlbs if kvm_get_inst() fails
  MIPS: KVM: Print unknown load/store encodings

 arch/mips/include/asm/kvm_host.h |  30 +----
 arch/mips/kvm/emulate.c          |  56 +++++----
 arch/mips/kvm/mips.c             |  70 +++++------
 arch/mips/kvm/mmu.c              |   1 +
 arch/mips/kvm/stats.c            |  21 ----
 arch/mips/kvm/trace.h            | 248 ++++++++++++++++++++++++++++++++++++++-
 6 files changed, 318 insertions(+), 108 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
-- 
2.4.10
