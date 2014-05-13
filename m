Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2014 11:18:22 +0200 (CEST)
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:37571 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6837168AbaEMJRDgeFkA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2014 11:17:03 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.80.1)
        (envelope-from <jslaby@suse.cz>)
        id 1Wk8pQ-0002Ur-3c; Tue, 13 May 2014 11:16:52 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: KVM: Pass reserved instruction exceptions to guest
Date:   Tue, 13 May 2014 11:16:01 +0200
Message-Id: <1399972612-9510-2-git-send-email-jslaby@suse.cz>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1399972612-9510-1-git-send-email-jslaby@suse.cz>
References: <1399972612-9510-1-git-send-email-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 15505679362270d02c449626385cb74af8905514 upstream.

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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
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
1.9.3
