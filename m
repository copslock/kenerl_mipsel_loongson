Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 14:14:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32778 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992482AbcIHMNq6lV7w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Sep 2016 14:13:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ECA1713452260;
        Thu,  8 Sep 2016 13:13:26 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 8 Sep 2016 13:13:29 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: KVM: Emulate MMIO via TLB miss for EVA
Date:   Thu, 8 Sep 2016 13:13:03 +0100
Message-ID: <368061ea72f1b731271dc579f69f73cc4b6a1304.1473335231.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
In-Reply-To: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
References: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55070
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

MIPS Enhanced Virtual Addressing (EVA) allows the virtual memory
segments to be rearranged such that the KSeg0/KSeg1 segments are
accessible TLB mapped to user mode, which would trigger a TLB Miss
exception (due to lack of TLB mappings) instead of an Address Error
exception.

Update the TLB Miss handling similar to Address Error handling for guest
MMIO emulation.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 091553942bcb..3a5484f9aa50 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -175,6 +175,24 @@ static int kvm_trap_emul_handle_tlb_miss(struct kvm_vcpu *vcpu, bool store)
 			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 			ret = RESUME_HOST;
 		}
+	} else if (KVM_GUEST_KERNEL_MODE(vcpu)
+		   && (KSEGX(badvaddr) == CKSEG0 || KSEGX(badvaddr) == CKSEG1)) {
+		/*
+		 * With EVA we may get a TLB exception instead of an address
+		 * error when the guest performs MMIO to KSeg1 addresses.
+		 */
+		kvm_debug("Emulate %s MMIO space\n",
+			  store ? "Store to" : "Load from");
+		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
+		if (er == EMULATE_FAIL) {
+			kvm_err("Emulate %s MMIO space failed\n",
+				store ? "Store to" : "Load from");
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			ret = RESUME_HOST;
+		} else {
+			run->exit_reason = KVM_EXIT_MMIO;
+			ret = RESUME_HOST;
+		}
 	} else {
 		kvm_err("Illegal TLB %s fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
 			store ? "ST" : "LD", cause, opc, badvaddr);
-- 
git-series 0.8.10
