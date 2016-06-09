Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 11:52:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7210 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040984AbcFIJvLyK17R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 11:51:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ABC57533B6231;
        Thu,  9 Jun 2016 10:51:02 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 10:51:05 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 3/4] MIPS: KVM: Don't unwind PC when emulating CACHE
Date:   Thu, 9 Jun 2016 10:50:45 +0100
Message-ID: <1465465846-31918-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
References: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53911
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

When a CACHE instruction is emulated by kvm_mips_emulate_cache(), the PC
is first updated to point to the next instruction, and afterwards it
falls through the "dont_update_pc" label, which rewinds the PC back to
its original address.

This works when dynamic translation of emulated instructions is enabled,
since the CACHE instruction is replaced with a SYNCI which works without
trapping, however when dynamic translation is disabled the guest hangs
on CACHE instructions as they always trap and are never stepped over.

Roughly swap the meanings of the "done" and "dont_update_pc" to match
kvm_mips_emulate_CP0(), so that "done" will roll back the PC on failure,
and "dont_update_pc" won't change PC at all (for the sake of exceptions
that have already modified the PC).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/kvm/emulate.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 396df6eb0a12..52bec0fe2fbb 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1666,7 +1666,7 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 			cache, op, base, arch->gprs[base], offset);
 		er = EMULATE_FAIL;
 		preempt_enable();
-		goto dont_update_pc;
+		goto done;
 
 	}
 
@@ -1694,16 +1694,20 @@ skip_fault:
 		kvm_err("NO-OP CACHE (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
 			cache, op, base, arch->gprs[base], offset);
 		er = EMULATE_FAIL;
-		preempt_enable();
-		goto dont_update_pc;
 	}
 
 	preempt_enable();
-
-dont_update_pc:
-	/* Rollback PC */
-	vcpu->arch.pc = curr_pc;
 done:
+	/* Rollback PC only if emulation was unsuccessful */
+	if (er == EMULATE_FAIL)
+		vcpu->arch.pc = curr_pc;
+
+dont_update_pc:
+	/*
+	 * This is for exceptions whose emulation updates the PC, so do not
+	 * overwrite the PC under any circumstances
+	 */
+
 	return er;
 }
 
-- 
2.4.10
