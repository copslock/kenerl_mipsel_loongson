Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:54:05 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:42405 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835053Ab3ESFt0K0wl4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:49:26 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:49:19 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 55C3E630067; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 15/18] KVM/MIPS32: Add dummy trap handler to catch unexpected exceptions and dump out useful info
Date:   Sat, 18 May 2013 22:47:37 -0700
Message-Id: <1368942460-15577-16-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_trap_emul.c | 68 ++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 466aeef..19b32a1 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -27,7 +27,7 @@ static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 	if ((kseg == CKSEG0) || (kseg == CKSEG1))
 		gpa = CPHYSADDR(gva);
 	else {
-		printk("%s: cannot find GPA for GVA: %#lx\n", __func__, gva);
+		kvm_err("%s: cannot find GPA for GVA: %#lx\n", __func__, gva);
 		kvm_mips_dump_host_tlbs();
 		gpa = KVM_INVALID_ADDR;
 	}
@@ -39,12 +39,29 @@ static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 	return gpa;
 }
 
+#ifdef CONFIG_KVM_MIPS_VZ
+static int kvm_trap_emul_no_handler(struct kvm_vcpu *vcpu)
+{
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
+
+	printk
+	    ("Exception Code: %d, not handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
+	     exccode, opc, kvm_get_inst(opc, vcpu), badvaddr,
+	     kvm_read_c0_guest_status(vcpu->arch.cop0));
+	kvm_arch_vcpu_dump_regs(vcpu);
+	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	return RESUME_HOST;
+}
+#endif
 
 static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -77,9 +94,9 @@ static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -124,9 +141,9 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -174,9 +191,9 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -228,9 +245,9 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -261,9 +278,9 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -294,8 +311,8 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_syscall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -312,8 +329,8 @@ static int kvm_trap_emul_handle_syscall(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_res_inst(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -330,8 +347,8 @@ static int kvm_trap_emul_handle_res_inst(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -460,6 +477,9 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_syscall = kvm_trap_emul_handle_syscall,
 	.handle_res_inst = kvm_trap_emul_handle_res_inst,
 	.handle_break = kvm_trap_emul_handle_break,
+#ifdef CONFIG_KVM_MIPS_VZ
+	.handle_guest_exit = kvm_trap_emul_no_handler,
+#endif
 
 	.vm_init = kvm_trap_emul_vm_init,
 	.vcpu_init = kvm_trap_emul_vcpu_init,
-- 
1.7.11.3
