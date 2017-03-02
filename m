Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:47:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46371 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993895AbdCBJhoA0mbt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:44 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id BF9E7D594D798;
        Thu,  2 Mar 2017 09:37:32 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:34 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 22/32] KVM: MIPS: Update exit handler for VZ
Date:   Thu, 2 Mar 2017 09:36:49 +0000
Message-ID: <128e5ec64384890c18af3c7f37f49a20212bdb29.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56983
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

The general guest exit handler needs a few tweaks for VZ compared to
trap & emulate, which for now are made directly depending on
CONFIG_KVM_MIPS_VZ:

- There is no need to re-enable the hardware page table walker (HTW), as
  it can be left enabled during guest mode operation with VZ.

- There is no need to perform a privilege check, as any guest privilege
  violations should have already been detected by the hardware and
  triggered the appropriate guest exception.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index efb406455229..3eff6a6c82b6 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1232,7 +1232,8 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	vcpu->mode = OUTSIDE_GUEST_MODE;
 
 	/* re-enable HTW before enabling interrupts */
-	htw_start();
+	if (!IS_ENABLED(CONFIG_KVM_MIPS_VZ))
+		htw_start();
 
 	/* Set a default exit reason */
 	run->exit_reason = KVM_EXIT_UNKNOWN;
@@ -1250,17 +1251,20 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			cause, opc, run, vcpu);
 	trace_kvm_exit(vcpu, exccode);
 
-	/*
-	 * Do a privilege check, if in UM most of these exit conditions end up
-	 * causing an exception to be delivered to the Guest Kernel
-	 */
-	er = kvm_mips_check_privilege(cause, opc, run, vcpu);
-	if (er == EMULATE_PRIV_FAIL) {
-		goto skip_emul;
-	} else if (er == EMULATE_FAIL) {
-		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		ret = RESUME_HOST;
-		goto skip_emul;
+	if (!IS_ENABLED(CONFIG_KVM_MIPS_VZ)) {
+		/*
+		 * Do a privilege check, if in UM most of these exit conditions
+		 * end up causing an exception to be delivered to the Guest
+		 * Kernel
+		 */
+		er = kvm_mips_check_privilege(cause, opc, run, vcpu);
+		if (er == EMULATE_PRIV_FAIL) {
+			goto skip_emul;
+		} else if (er == EMULATE_FAIL) {
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			ret = RESUME_HOST;
+			goto skip_emul;
+		}
 	}
 
 	switch (exccode) {
@@ -1420,7 +1424,8 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 
 	/* Disable HTW before returning to guest or host */
-	htw_stop();
+	if (!IS_ENABLED(CONFIG_KVM_MIPS_VZ))
+		htw_stop();
 
 	return ret;
 }
-- 
git-series 0.8.10
