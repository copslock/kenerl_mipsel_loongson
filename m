Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 15:20:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29760 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993879AbdBAOTnSgCcg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 15:19:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 413A3F0B543DD;
        Wed,  1 Feb 2017 14:19:33 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 1 Feb 2017 14:19:36 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 4/5] KVM: MIPS/T&E: Expose CP0_EntryLo0/1 registers
Date:   Wed, 1 Feb 2017 14:19:26 +0000
Message-ID: <9431d12b31dd45a307ba2d19353cc3618c2b0b73.1485958267.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
References: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56575
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

Expose the CP0_EntryLo0 and CP0_EntryLo1 registers through the KVM
register access API. This is fairly straightforward for trap & emulate
since we don't support the RI and XI bits. For the sake of future
proofing (particularly for VZ) it is explicitly specified that the API
always exposes the 64-bit version of these registers (i.e. with the RI
and XI bits in bit positions 63 and 62 respectively), and they are
implemented in trap_emul.c rather than mips.c to allow them to be
implemented differently for VZ.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt |  8 ++++++++
 arch/mips/include/asm/kvm_host.h  |  2 ++
 arch/mips/kvm/trap_emul.c         | 14 ++++++++++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 8d52d0f990ae..df4a309ba56e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2061,6 +2061,8 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_LO               | 64
   MIPS  | KVM_REG_MIPS_PC               | 64
   MIPS  | KVM_REG_MIPS_CP0_INDEX        | 32
+  MIPS  | KVM_REG_MIPS_CP0_ENTRYLO0     | 64
+  MIPS  | KVM_REG_MIPS_CP0_ENTRYLO1     | 64
   MIPS  | KVM_REG_MIPS_CP0_CONTEXT      | 64
   MIPS  | KVM_REG_MIPS_CP0_USERLOCAL    | 64
   MIPS  | KVM_REG_MIPS_CP0_PAGEMASK     | 32
@@ -2149,6 +2151,12 @@ patterns depending on whether they're 32-bit or 64-bit registers:
   0x7020 0000 0001 00 <reg:5> <sel:3>   (32-bit)
   0x7030 0000 0001 00 <reg:5> <sel:3>   (64-bit)
 
+Note: KVM_REG_MIPS_CP0_ENTRYLO0 and KVM_REG_MIPS_CP0_ENTRYLO1 are the MIPS64
+versions of the EntryLo registers regardless of the word size of the host
+hardware, host kernel, guest, and whether XPA is present in the guest, i.e.
+with the RI and XI bits (if they exist) in bits 63 and 62 respectively, and
+the PFNX field starting at bit 30.
+
 MIPS KVM control registers (see above) have the following id bit patterns:
   0x7030 0000 0002 <reg:16>
 
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 72bb2d777ab8..f0113ea18989 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -352,7 +352,9 @@ struct kvm_vcpu_arch {
 #define kvm_read_c0_guest_index(cop0)		(cop0->reg[MIPS_CP0_TLB_INDEX][0])
 #define kvm_write_c0_guest_index(cop0, val)	(cop0->reg[MIPS_CP0_TLB_INDEX][0] = val)
 #define kvm_read_c0_guest_entrylo0(cop0)	(cop0->reg[MIPS_CP0_TLB_LO0][0])
+#define kvm_write_c0_guest_entrylo0(cop0, val)	(cop0->reg[MIPS_CP0_TLB_LO0][0] = (val))
 #define kvm_read_c0_guest_entrylo1(cop0)	(cop0->reg[MIPS_CP0_TLB_LO1][0])
+#define kvm_write_c0_guest_entrylo1(cop0, val)	(cop0->reg[MIPS_CP0_TLB_LO1][0] = (val))
 #define kvm_read_c0_guest_context(cop0)		(cop0->reg[MIPS_CP0_TLB_CONTEXT][0])
 #define kvm_write_c0_guest_context(cop0, val)	(cop0->reg[MIPS_CP0_TLB_CONTEXT][0] = (val))
 #define kvm_read_c0_guest_userlocal(cop0)	(cop0->reg[MIPS_CP0_TLB_CONTEXT][2])
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 86a104947e4d..9abde8ef5f26 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -646,6 +646,8 @@ static void kvm_trap_emul_flush_shadow_memslot(struct kvm *kvm,
 
 static u64 kvm_trap_emul_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_INDEX,
+	KVM_REG_MIPS_CP0_ENTRYLO0,
+	KVM_REG_MIPS_CP0_ENTRYLO1,
 	KVM_REG_MIPS_CP0_CONTEXT,
 	KVM_REG_MIPS_CP0_USERLOCAL,
 	KVM_REG_MIPS_CP0_PAGEMASK,
@@ -706,6 +708,12 @@ static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_INDEX:
 		*v = (long)kvm_read_c0_guest_index(cop0);
 		break;
+	case KVM_REG_MIPS_CP0_ENTRYLO0:
+		*v = kvm_read_c0_guest_entrylo0(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYLO1:
+		*v = kvm_read_c0_guest_entrylo1(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_CONTEXT:
 		*v = (long)kvm_read_c0_guest_context(cop0);
 		break;
@@ -817,6 +825,12 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_INDEX:
 		kvm_write_c0_guest_index(cop0, v);
 		break;
+	case KVM_REG_MIPS_CP0_ENTRYLO0:
+		kvm_write_c0_guest_entrylo0(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYLO1:
+		kvm_write_c0_guest_entrylo1(cop0, v);
+		break;
 	case KVM_REG_MIPS_CP0_CONTEXT:
 		kvm_write_c0_guest_context(cop0, v);
 		break;
-- 
git-series 0.8.10
