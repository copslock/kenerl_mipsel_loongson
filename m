Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 11:46:14 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbcKIKqH0vm8A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 11:46:07 +0100
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 28586B22;
        Wed,  9 Nov 2016 10:46:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: [PATCH 4.4 35/69] KVM: MIPS: Make ERET handle ERL before EXL
Date:   Wed,  9 Nov 2016 11:44:13 +0100
Message-Id: <20161109102902.590301640@linuxfoundation.org>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161109102901.127641653@linuxfoundation.org>
References: <20161109102901.127641653@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/emulate.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -752,15 +752,15 @@ enum emulation_result kvm_mips_emul_eret
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
 		kvm_err("[%#lx] ERET when MIPS_SR_EXL|MIPS_SR_ERL == 0\n",
 			vcpu->arch.pc);
