Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2014 14:07:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:47476 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825716AbaCNNG133ZDC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Mar 2014 14:06:27 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1CE42D57109A0;
        Fri, 14 Mar 2014 13:06:19 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 14 Mar
 2014 13:06:21 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 14 Mar 2014 13:06:21 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 14 Mar 2014 13:06:20 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Sanjay Lal <sanjayl@kymasys.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/4] MIPS: KVM: Pass reserved instruction exceptions to guest
Date:   Fri, 14 Mar 2014 13:06:07 +0000
Message-ID: <1394802370-20487-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1394802370-20487-1-git-send-email-james.hogan@imgtec.com>
References: <1394802370-20487-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39469
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

Previously a reserved instruction exception while in guest code would
cause a KVM internal error if kvm_mips_handle_ri() didn't recognise the
instruction (including a RDHWR from an unrecognised hardware register).

However the guest OS should really have the opportunity to catch the
exception so that it can take the appropriate actions such as sending a
SIGILL to the guest user process or emulating the instruction itself.

Therefore in these cases emulate a guest RI exception and only return
EMULATE_FAIL if that fails, being careful to revert the PC first in case
the exception occurred in a branch delay slot in which case the PC will
already point to the branch target.

Also turn the printk messages relating to these cases into kvm_debug
messages so that they aren't usually visible.

This allows crashme to run in the guest without killing the entire VM.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
---
 arch/mips/kvm/kvm_mips_emul.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 4b6274b47f33..e75ef8219caf 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1571,17 +1571,17 @@ kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 			arch->gprs[rt] = kvm_read_c0_guest_userlocal(cop0);
 #else
 			/* UserLocal not implemented */
-			er = kvm_mips_emulate_ri_exc(cause, opc, run, vcpu);
+			er = EMULATE_FAIL;
 #endif
 			break;
 
 		default:
-			printk("RDHWR not supported\n");
+			kvm_debug("RDHWR %#x not supported @ %p\n", rd, opc);
 			er = EMULATE_FAIL;
 			break;
 		}
 	} else {
-		printk("Emulate RI not supported @ %p: %#x\n", opc, inst);
+		kvm_debug("Emulate RI not supported @ %p: %#x\n", opc, inst);
 		er = EMULATE_FAIL;
 	}
 
@@ -1590,6 +1590,7 @@ kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 	 */
 	if (er == EMULATE_FAIL) {
 		vcpu->arch.pc = curr_pc;
+		er = kvm_mips_emulate_ri_exc(cause, opc, run, vcpu);
 	}
 	return er;
 }
-- 
1.8.1.2
