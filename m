Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 23:40:50 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:39714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993086AbcKVWkl2ldbi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2016 23:40:41 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B26AFADC4;
        Tue, 22 Nov 2016 22:40:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] KVM: MIPS: Make ERET handle ERL before EXL
Date:   Tue, 22 Nov 2016 23:40:09 +0100
Message-Id: <20161122224029.29962-21-jslaby@suse.cz>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161122224029.29962-1-jslaby@suse.cz>
References: <20161122224029.29962-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55862
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

commit ede5f3e7b54a4347be4d8525269eae50902bd7cd upstream.

The ERET instruction to return from exception is used for returning from
exception level (Status.EXL) and error level (Status.ERL). If both bits
are set however we should be returning from ERL first, as ERL can
interrupt EXL, for example when an NMI is taken. KVM however checks EXL
first.

Fix the order of the checks to match the pseudocode in the instruction
set manual.

Fixes: e685c689f3a8 ("KVM/MIPS32: Privileged instruction/target branch emulation.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_mips_emul.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 4cfb5bddaa9b..716285497e0e 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -254,15 +254,15 @@ enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
 
-	if (kvm_read_c0_guest_status(cop0) & ST0_EXL) {
+	if (kvm_read_c0_guest_status(cop0) & ST0_ERL) {
+		kvm_clear_c0_guest_status(cop0, ST0_ERL);
+		vcpu->arch.pc = kvm_read_c0_guest_errorepc(cop0);
+	} else if (kvm_read_c0_guest_status(cop0) & ST0_EXL) {
 		kvm_debug("[%#lx] ERET to %#lx\n", vcpu->arch.pc,
 			  kvm_read_c0_guest_epc(cop0));
 		kvm_clear_c0_guest_status(cop0, ST0_EXL);
 		vcpu->arch.pc = kvm_read_c0_guest_epc(cop0);
 
-	} else if (kvm_read_c0_guest_status(cop0) & ST0_ERL) {
-		kvm_clear_c0_guest_status(cop0, ST0_ERL);
-		vcpu->arch.pc = kvm_read_c0_guest_errorepc(cop0);
 	} else {
 		printk("[%#lx] ERET when MIPS_SR_EXL|MIPS_SR_ERL == 0\n",
 		       vcpu->arch.pc);
-- 
2.10.2
