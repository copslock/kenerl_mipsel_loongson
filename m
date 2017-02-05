Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Feb 2017 20:24:32 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:27863 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992121AbdBETYZru-42 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Feb 2017 20:24:25 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v15JLAr5008019;
        Sun, 5 Feb 2017 20:21:10 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 026/319] KVM: MIPS: Make ERET handle ERL before EXL
Date:   Sun,  5 Feb 2017 20:21:04 +0100
Message-Id: <1486322467-7968-4-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1486322467-7968-1-git-send-email-w@1wt.eu>
References: <1486322467-7968-1-git-send-email-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=latin1
Content-Transfer-Encoding: 8bit
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kvm/kvm_mips_emul.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 4cfb5bd..7162854 100644
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
2.8.0.rc2.1.gbe9624a
