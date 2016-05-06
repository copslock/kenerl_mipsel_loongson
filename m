Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 15:36:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57919 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027805AbcEFNgj3pQtk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2016 15:36:39 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 48536AB6B94D5;
        Fri,  6 May 2016 14:36:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:31 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Jayachandran C." <jchandra@broadcom.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 0/7] MIPS: Add extended ASID support
Date:   Fri, 6 May 2016 14:36:17 +0100
Message-ID: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53291
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

This patchset is based on v4.6-rc4 and adds support for the optional
extended ASIDs present since revision 3.5 of the MIPS32/MIPS64
architecture, which extends the TLB ASIDs from 8 bits to 10 bits. These
are known to be implemented in XLP and I6400 cores.

Along the way a few cleanups are made, particularly for KVM which
manipulates ASIDs from assembly code.

Patch 6 lays most of the groundwork by abstracting asid masks so they
can be variable, and patch 7 adds the actual support for extended ASIDs.

Patches 1-5 do some preliminary clean up around ASID handling, and in
KVM's locore.S to allow patch 7 to support extended ASIDs.

The use of extended ASIDs can be observed by using the 'x' sysrq to dump
TLB values, e.g. by repeatedly running this command:
$(echo x > /proc/sysrq-trigger); dmesg -c | grep asid

James Hogan (4):
  MIPS: KVM/locore.S: Don't preserve host ASID around vcpu_run
  MIPS: Add & use CP0_EntryHi ASID definitions
  MIPS: KVM/locore.S: Only preserve callee saved registers
  MIPS: KVM/locore.S: Relax noat

Paul Burton (3):
  MIPS: KVM: Abstract guest ASID mask
  MIPS: Retrieve ASID masks using function accepting struct cpuinfo_mips
  MIPS: Support extended ASIDs

 arch/mips/Kconfig                   | 17 +++++++
 arch/mips/include/asm/cpu-info.h    | 24 ++++++++++
 arch/mips/include/asm/kvm_host.h    |  5 +-
 arch/mips/include/asm/mipsregs.h    |  2 +
 arch/mips/include/asm/mmu_context.h | 41 +++++++---------
 arch/mips/kernel/asm-offsets.c      | 10 ++++
 arch/mips/kernel/cpu-probe.c        | 13 +++++
 arch/mips/kernel/genex.S            |  2 +-
 arch/mips/kernel/traps.c            |  2 +-
 arch/mips/kvm/emulate.c             | 25 +++++-----
 arch/mips/kvm/locore.S              | 94 +++++++++----------------------------
 arch/mips/kvm/tlb.c                 | 33 ++++++++-----
 arch/mips/lib/dump_tlb.c            | 10 ++--
 arch/mips/lib/r3k_dump_tlb.c        |  9 ++--
 arch/mips/mm/tlb-r3k.c              | 24 ++++++----
 arch/mips/mm/tlb-r4k.c              |  2 +-
 arch/mips/mm/tlb-r8k.c              |  2 +-
 arch/mips/pci/pci-alchemy.c         |  2 +-
 18 files changed, 173 insertions(+), 144 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Jayachandran C. <jchandra@broadcom.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
-- 
2.4.10
