Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 20:35:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25994 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992067AbcGDSfhn7fQ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 20:35:37 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 23F52DE513BE2;
        Mon,  4 Jul 2016 19:35:28 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 4 Jul 2016 19:35:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 0/9] MIPS: KVM: MIPS r6 support
Date:   Mon, 4 Jul 2016 19:35:06 +0100
Message-ID: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54199
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

Add basic MIPS KVM support for MIPS32r6, primarily to prepare for VZ
support on r6 processors. This patchset is based on my recent uasm
conversion patchset.

Patches 1-2 from Paul are general MIPS changes which make a couple of
tweaks to the naming of opcode definitions. They aren't expected to
conflict with MIPS changes in v4.8.

Patches 3-9 make fairly simple changes to support r6, and are self
explanatory.

James Hogan (7):
  MIPS: KVM: Fix fpu.S misassembly with r6
  MIPS: KVM: Fix pre-r6 ll/sc instructions on r6
  MIPS: KVM: Don't save/restore lo/hi for r6
  MIPS: KVM: Support r6 compact branch emulation
  MIPS: KVM: Recognise r6 CACHE encoding
  MIPS: KVM: Decode RDHWR more strictly
  MIPS: KVM: Emulate generic QEMU machine on r6 T&E

Paul Burton (2):
  MIPS: inst.h: Rename b{eq,ne}zcji[al]c_op to pop{6,7}6_op
  MIPS: inst.h: Rename cbcond{0,1}_op to pop{1,3}0_op

 arch/mips/include/asm/kvm_host.h  |  6 +--
 arch/mips/include/uapi/asm/inst.h |  8 ++--
 arch/mips/kernel/branch.c         |  8 ++--
 arch/mips/kvm/dyntrans.c          |  5 ++-
 arch/mips/kvm/emulate.c           | 77 +++++++++++++++++++++++++++++++++++----
 arch/mips/kvm/entry.c             | 16 ++------
 arch/mips/kvm/fpu.S               |  7 +++-
 arch/mips/kvm/mips.c              |  6 +++
 arch/mips/kvm/trap_emul.c         |  8 +++-
 arch/mips/math-emu/cp1emu.c       |  8 ++--
 10 files changed, 110 insertions(+), 39 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
-- 
2.4.10
