Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2017 00:44:16 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36045 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993893AbdBOXngbwSoO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Feb 2017 00:43:36 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1ce8U1-0002J4-9E; Wed, 15 Feb 2017 22:55:33 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1ce8Tl-00035q-DT; Wed, 15 Feb 2017 22:55:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
 "Ralf Baechle" <ralf@linux-mips.org>,
 linux-mips@linux-mips.org,
 "James Hogan" <james.hogan@imgtec.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 kvm@vger.kernel.org,
 ""Radim
 =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date:   Wed, 15 Feb 2017 22:41:40 +0000
Message-ID: <lsq.1487198500.549032511@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 163/306] KVM: MIPS: Make ERET handle ERL before EXL
In-Reply-To: <lsq.1487198498.99718322@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.40-rc1 review patch.  If anyone has any objections, please let me know.

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
Cc: "Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kvm/kvm_mips_emul.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -761,15 +761,15 @@ enum emulation_result kvm_mips_emul_eret
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
