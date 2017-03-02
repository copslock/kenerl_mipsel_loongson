Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:41:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21170 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993882AbdCBJhaasWEt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:30 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4BFDE9F1952F1;
        Thu,  2 Mar 2017 09:37:27 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:29 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 15/32] KVM: MIPS: Add hardware_{enable,disable} callback
Date:   Thu, 2 Mar 2017 09:36:42 +0000
Message-ID: <b630eb25c30b0dc3ef6be765cf72e312dce3812f.1488447004.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56969
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

Add an implementation callback for the kvm_arch_hardware_enable() and
kvm_arch_hardware_disable() architecture functions, with simple stubs
for trap & emulate. This is in preparation for VZ which will make use of
them.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  3 ++-
 arch/mips/kvm/mips.c             |  7 ++++++-
 arch/mips/kvm/trap_emul.c        | 11 +++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index e9248da4e9ed..8572f024f728 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -545,6 +545,8 @@ struct kvm_mips_callbacks {
 	int (*handle_msa_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
+	int (*hardware_enable)(void);
+	void (*hardware_disable)(void);
 	int (*check_extension)(struct kvm *kvm, long ext);
 	int (*vcpu_init)(struct kvm_vcpu *vcpu);
 	void (*vcpu_uninit)(struct kvm_vcpu *vcpu);
@@ -868,7 +870,6 @@ extern int kvm_mips_trans_mtc0(union mips_instruction inst, u32 *opc,
 extern void kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
 extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 472cea5efd3a..59e79ca76720 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -90,7 +90,12 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 
 int kvm_arch_hardware_enable(void)
 {
-	return 0;
+	return kvm_mips_callbacks->hardware_enable();
+}
+
+void kvm_arch_hardware_disable(void)
+{
+	kvm_mips_callbacks->hardware_disable();
 }
 
 int kvm_arch_hardware_setup(void)
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 254a641ff913..c8a0e927220b 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -488,6 +488,15 @@ static int kvm_trap_emul_handle_msa_disabled(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_trap_emul_hardware_enable(void)
+{
+	return 0;
+}
+
+static void kvm_trap_emul_hardware_disable(void)
+{
+}
+
 static int kvm_trap_emul_check_extension(struct kvm *kvm, long ext)
 {
 	return 0;
@@ -1243,6 +1252,8 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_fpe = kvm_trap_emul_handle_fpe,
 	.handle_msa_disabled = kvm_trap_emul_handle_msa_disabled,
 
+	.hardware_enable = kvm_trap_emul_hardware_enable,
+	.hardware_disable = kvm_trap_emul_hardware_disable,
 	.check_extension = kvm_trap_emul_check_extension,
 	.vcpu_init = kvm_trap_emul_vcpu_init,
 	.vcpu_uninit = kvm_trap_emul_vcpu_uninit,
-- 
git-series 0.8.10
