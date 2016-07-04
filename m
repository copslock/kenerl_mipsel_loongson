Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 20:38:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51683 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992399AbcGDSfndyzb7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 20:35:43 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D9B184690732F;
        Mon,  4 Jul 2016 19:35:32 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 4 Jul 2016 19:35:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 7/9] MIPS: KVM: Recognise r6 CACHE encoding
Date:   Mon, 4 Jul 2016 19:35:13 +0100
Message-ID: <1467657315-19975-8-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
References: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54206
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

Recognise the new MIPSr6 CACHE instruction encoding rather than the
pre-r6 one when an r6 kernel is being built. A SPECIAL3 opcode is used
and the immediate field is reduced to 9 bits wide since MIPSr6.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c |  5 ++++-
 arch/mips/kvm/emulate.c  | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index 8a1833b9eb38..91ebd2b6034f 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -72,7 +72,10 @@ int kvm_mips_trans_cache_va(union mips_instruction inst, u32 *opc,
 	synci_inst.i_format.opcode = bcond_op;
 	synci_inst.i_format.rs = inst.i_format.rs;
 	synci_inst.i_format.rt = synci_op;
-	synci_inst.i_format.simmediate = inst.i_format.simmediate;
+	if (cpu_has_mips_r6)
+		synci_inst.i_format.simmediate = inst.spec3_format.simmediate;
+	else
+		synci_inst.i_format.simmediate = inst.i_format.simmediate;
 
 	return kvm_mips_trans_replace(vcpu, opc, synci_inst);
 }
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index f0fa9e956056..62e6a7b313ae 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1601,7 +1601,10 @@ enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 
 	base = inst.i_format.rs;
 	op_inst = inst.i_format.rt;
-	offset = inst.i_format.simmediate;
+	if (cpu_has_mips_r6)
+		offset = inst.spec3_format.simmediate;
+	else
+		offset = inst.i_format.simmediate;
 	cache = op_inst & CacheOp_Cache;
 	op = op_inst & CacheOp_Op;
 
@@ -1764,11 +1767,27 @@ enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 		er = kvm_mips_emulate_load(inst, cause, run, vcpu);
 		break;
 
+#ifndef CONFIG_CPU_MIPSR6
 	case cache_op:
 		++vcpu->stat.cache_exits;
 		trace_kvm_exit(vcpu, KVM_TRACE_EXIT_CACHE);
 		er = kvm_mips_emulate_cache(inst, opc, cause, run, vcpu);
 		break;
+#else
+	case spec3_op:
+		switch (inst.spec3_format.func) {
+		case cache6_op:
+			++vcpu->stat.cache_exits;
+			trace_kvm_exit(vcpu, KVM_TRACE_EXIT_CACHE);
+			er = kvm_mips_emulate_cache(inst, opc, cause, run,
+						    vcpu);
+			break;
+		default:
+			goto unknown;
+		};
+		break;
+unknown:
+#endif
 
 	default:
 		kvm_err("Instruction emulation not supported (%p/%#x)\n", opc,
-- 
2.4.10
