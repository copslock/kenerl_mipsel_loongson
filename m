Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 11:51:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26199 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040014AbcFIJvJTlqcR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 11:51:09 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 72E5BFAD15F7;
        Thu,  9 Jun 2016 10:51:00 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 10:51:03 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH 0/4] MIPS: KVM: Module + non dynamic translating fixes
Date:   Thu, 9 Jun 2016 10:50:42 +0100
Message-ID: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53909
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

These patches fix a couple of issues I recently spotted when running KVM
under QEMU (i.e. the host MIPS kernel is running under QEMU on a PC).

Patches 1-2: Fix modular KVM broken by QEMU TLB optimisation (Patch 1
marked for stable).

Patches 3-4: Fix cache instruction emulation, exposed by having dynamic
translation of emulated instructions accidentally turned off.

James Hogan (4):
  MIPS: KVM: Fix modular KVM under QEMU
  MIPS: KVM: Include bit 31 in segment matches
  MIPS: KVM: Don't unwind PC when emulating CACHE
  MIPS: KVM: Fix CACHE triggered exception emulation

 arch/mips/include/asm/kvm_host.h |  3 ++-
 arch/mips/kvm/emulate.c          | 21 ++++++++++++++-------
 arch/mips/kvm/interrupt.h        |  1 +
 arch/mips/kvm/locore.S           |  1 +
 arch/mips/kvm/mips.c             | 11 ++++++++++-
 5 files changed, 28 insertions(+), 9 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
-- 
2.4.10
