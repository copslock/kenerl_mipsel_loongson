Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:34:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47384 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043838AbcFWQe5scaoz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:34:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B46B0EA9908A4;
        Thu, 23 Jun 2016 17:34:47 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:51 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 00/14] MIPS: KVM: Dynamically generate exception code
Date:   Thu, 23 Jun 2016 17:34:33 +0100
Message-ID: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54137
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

These patches change the MIPS KVM exception entry code to be dynamically
assembled by the MIPS "uasm" in-kernel assembler, directly into unmapped
memory at run time by a new entry.c. Previously this code was statically
assembled from locore.S at build time and later copied into unmapped
memory at run time.

Patches 1-5 add support for the necessary instructions to uasm.

Patches 6-8 do the minimal-change conversion of locore.S to entry.c
using uasm (I've used -M10% so the diff is shown as a file move).

Patches 9-14 make some related improvements that are possible now that
it is dynamically generated, such as avoiding messy runtime conditionals
in assembly code, making use of KScratch registers when available, and
simplifying the initial GP register save sequence & jump to common code.

Ralf: Since the uasm patches (1-5) are needed for the later patches, I
suggest these all go together via the KVM tree (on which the whole
patchset is based), so Acks are welcome if they're okay with you.

James Hogan (14):
  MIPS: uasm: Add CFC1/CTC1 instructions
  MIPS: uasm: Add CFCMSA/CTCMSA instructions
  MIPS: uasm: Add DI instruction
  MIPS: uasm: Add MTHI/MTLO instructions
  MIPS: uasm: Add r6 MUL encoding

  MIPS; KVM: Convert exception entry to uasm
  MIPS: KVM: Add dumping of generated entry code
  MIPS: KVM: Drop now unused asm offsets

  MIPS: KVM: Omit FPU handling entry code if possible
  MIPS: KVM: Check MSA presence at uasm time
  MIPS: KVM: Drop redundant restore of DDATA_LO
  MIPS: KVM: Dynamically choose scratch registers
  MIPS: KVM: Relative branch to common exit handler
  MIPS: KVM: Save k0 straight into VCPU structure

 arch/mips/include/asm/kvm_host.h    |   9 +-
 arch/mips/include/asm/uasm.h        |   7 +
 arch/mips/include/uapi/asm/inst.h   |  71 ++-
 arch/mips/kernel/asm-offsets.c      |  66 ---
 arch/mips/kvm/Kconfig               |   1 +
 arch/mips/kvm/Makefile              |   2 +-
 arch/mips/kvm/{locore.S => entry.c} | 976 +++++++++++++++++++-----------------
 arch/mips/kvm/interrupt.h           |   4 -
 arch/mips/kvm/mips.c                |  66 ++-
 arch/mips/mm/uasm-micromips.c       |  13 +-
 arch/mips/mm/uasm-mips.c            |  11 +
 arch/mips/mm/uasm.c                 |  24 +-
 12 files changed, 695 insertions(+), 555 deletions(-)
 rename arch/mips/kvm/{locore.S => entry.c} (15%)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
-- 
2.4.10
