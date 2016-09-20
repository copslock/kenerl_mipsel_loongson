Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 14:03:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53542 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991984AbcITMDAXuVW6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 14:03:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 53C6A8765EBB9;
        Tue, 20 Sep 2016 13:02:41 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 20 Sep 2016 13:02:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH 0/4] KVM: MIPS: SMP & TLB invalidation fixes
Date:   Tue, 20 Sep 2016 13:02:26 +0100
Message-ID: <cover.b4aaacd5414bd20c4eb4d53417956b268d69d1af.1474372617.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55208
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

This patchset primarily fixes MIPS KVM guest TLB invalidation on SMP
hosts (patch 1, for 4.8 and stable), and optimises this code a little
(patches 2-4, for 4.9).

The main fix effectively invalidates the guest's TLB on all other CPUs
by clearing their host ASIDs for this vCPU's guest kernel (and guest
user) mode. This happens whenever a change to the guest mappings takes
place, and is in addition to the TLB invalidation on the local CPU. This
ensures that upon their next execution of this vCPU that stale mappings
aren't used.

The rest of the patches convert the local invalidation to use clearing
of ASIDs too, makes that lazy for guest user mode mappings when the
guest ASID changes, and drops a dubious optimisation around guest ASID
changes. The use of ASID clearing is faster and doesn't flush TLB
entries from other address spaces, but does result in entries for guest
KSeg0 (which don't actually change) being invalidated too.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org

James Hogan (4):
  KVM: MIPS: Drop other CPU ASIDs on guest MMU changes
  KVM: MIPS: Split kernel/user ASID regeneration
  KVM: MIPS: Invalidate TLB by regenerating ASIDs
  KVM: MIPS: Drop dubious EntryHi optimisation

 arch/mips/include/asm/kvm_host.h |  3 +-
 arch/mips/kvm/emulate.c          | 78 +++++++++++++++++++++++++++------
 arch/mips/kvm/mips.c             | 30 +++++++++++++-
 arch/mips/kvm/mmu.c              | 16 ++++++-
 4 files changed, 111 insertions(+), 16 deletions(-)

-- 
git-series 0.8.10
