Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 01:05:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5394 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994627AbdCNAFjDovRY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 01:05:39 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2EED962D85842;
        Tue, 14 Mar 2017 00:05:28 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 00:05:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <stable@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] KVM: MIPS/Emulate: Fix preemption warning
Date:   Tue, 14 Mar 2017 00:05:15 +0000
Message-ID: <20170314000515.26573-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57185
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

Host kernels with preemption enabled will emit the following preemption
warning when the guest FPU is used:

BUG: using smp_processor_id() in preemptible [00000000] code: qemu-system-mip/1495
caller is kvm_mips_emulate_CP0+0xa48/0xea0 [kvm]
...
Call Trace:
[<ffffffff81122d50>] show_stack+0x88/0xa8
[<ffffffff814307ac>] dump_stack+0x9c/0xd0
[<ffffffff81459f24>] check_preemption_disabled+0x124/0x130
[<ffffffffc000e908>] kvm_mips_emulate_CP0+0xa48/0xea0 [kvm]
[<ffffffffc000f9f0>] kvm_mips_emulate_inst+0x190/0x268 [kvm]
[<ffffffffc0016220>] kvm_trap_emul_handle_cop_unusable+0x48/0x160 [kvm]
[<ffffffffc000c120>] kvm_mips_handle_exit+0x520/0x7e0 [kvm]

This is due to the use of current_cpu_data.fpu_id from a preemptible
context to read the MIPS_FPIR_F64 bit. We don't currently support
asymmetric FPU capabilities with KVM, so just use boot_cpu_data instead
to silence the warning.

Fixes: 6cdc65e31d4f ("MIPS: KVM: Emulate FPU bits in COP0 interface")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org> # 4.1.x-
---
 arch/mips/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index d40cfaad4529..9bc55619252a 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1279,7 +1279,7 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 				 * Also don't allow FR to be set if host doesn't
 				 * support it.
 				 */
-				if (!(current_cpu_data.fpu_id & MIPS_FPIR_F64))
+				if (!(boot_cpu_data.fpu_id & MIPS_FPIR_F64))
 					val &= ~ST0_FR;
 
 
-- 
2.11.1
