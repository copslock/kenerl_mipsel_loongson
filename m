Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 21:12:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12638 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860036AbaFZTMVhkyWe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 21:12:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 13F09EA235AA3;
        Thu, 26 Jun 2014 20:12:10 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.10.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 26 Jun
 2014 20:12:13 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.10.222) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 26 Jun
 2014 20:12:13 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 26 Jun 2014 20:12:13 +0100
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 26 Jun
 2014 12:12:04 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <james.hogan@imgtec.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 2/7] MIPS: KVM: Use KVM internal logger
Date:   Thu, 26 Jun 2014 12:11:35 -0700
Message-ID: <1403809900-17454-3-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Replace printks with kvm_[err|info|debug].

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
Changes:
v4 - v3:
o Use kvm_debug instead of kvm_err in kvm_mips_check_privilege().
v3 - v2:
o Change the use of kvm_[err|info|debug].

 arch/mips/kvm/kvm_mips.c       |  23 ++++-----
 arch/mips/kvm/kvm_mips_emul.c  | 107 ++++++++++++++++++++---------------------
 arch/mips/kvm/kvm_mips_stats.c |   6 +--
 arch/mips/kvm/kvm_tlb.c        |  60 +++++++++++------------
 arch/mips/kvm/kvm_trap_emul.c  |  31 +++++-------
 5 files changed, 110 insertions(+), 117 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 52be52a..330b3af 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -817,8 +817,8 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 		ga = memslot->base_gfn << PAGE_SHIFT;
 		ga_end = ga + (memslot->npages << PAGE_SHIFT);
 
-		printk("%s: dirty, ga: %#lx, ga_end %#lx\n", __func__, ga,
-		       ga_end);
+		kvm_info("%s: dirty, ga: %#lx, ga_end %#lx\n", __func__, ga,
+			 ga_end);
 
 		n = kvm_dirty_bitmap_bytes(memslot);
 		memset(memslot->dirty_bitmap, 0, n);
@@ -925,24 +925,25 @@ int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
 	if (!vcpu)
 		return -1;
 
-	printk("VCPU Register Dump:\n");
-	printk("\tpc = 0x%08lx\n", vcpu->arch.pc);
-	printk("\texceptions: %08lx\n", vcpu->arch.pending_exceptions);
+	kvm_debug("VCPU Register Dump:\n");
+	kvm_debug("\tpc = 0x%08lx\n", vcpu->arch.pc);
+	kvm_debug("\texceptions: %08lx\n", vcpu->arch.pending_exceptions);
 
 	for (i = 0; i < 32; i += 4) {
-		printk("\tgpr%02d: %08lx %08lx %08lx %08lx\n", i,
+		kvm_debug("\tgpr%02d: %08lx %08lx %08lx %08lx\n", i,
 		       vcpu->arch.gprs[i],
 		       vcpu->arch.gprs[i + 1],
 		       vcpu->arch.gprs[i + 2], vcpu->arch.gprs[i + 3]);
 	}
-	printk("\thi: 0x%08lx\n", vcpu->arch.hi);
-	printk("\tlo: 0x%08lx\n", vcpu->arch.lo);
+	kvm_debug("\thi: 0x%08lx\n", vcpu->arch.hi);
+	kvm_debug("\tlo: 0x%08lx\n", vcpu->arch.lo);
 
 	cop0 = vcpu->arch.cop0;
-	printk("\tStatus: 0x%08lx, Cause: 0x%08lx\n",
-	       kvm_read_c0_guest_status(cop0), kvm_read_c0_guest_cause(cop0));
+	kvm_debug("\tStatus: 0x%08lx, Cause: 0x%08lx\n",
+		  kvm_read_c0_guest_status(cop0),
+		  kvm_read_c0_guest_cause(cop0));
 
-	printk("\tEPC: 0x%08lx\n", kvm_read_c0_guest_epc(cop0));
+	kvm_debug("\tEPC: 0x%08lx\n", kvm_read_c0_guest_epc(cop0));
 
 	return 0;
 }
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 9ec9f1d..bdd1421 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -183,18 +183,18 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 
 		/* And now the FPA/cp1 branch instructions. */
 	case cop1_op:
-		printk("%s: unsupported cop1_op\n", __func__);
+		kvm_err("%s: unsupported cop1_op\n", __func__);
 		break;
 	}
 
 	return nextpc;
 
 unaligned:
-	printk("%s: unaligned epc\n", __func__);
+	kvm_err("%s: unaligned epc\n", __func__);
 	return nextpc;
 
 sigill:
-	printk("%s: DSP branch but not DSP ASE\n", __func__);
+	kvm_err("%s: DSP branch but not DSP ASE\n", __func__);
 	return nextpc;
 }
 
@@ -751,8 +751,8 @@ enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
 		kvm_clear_c0_guest_status(cop0, ST0_ERL);
 		vcpu->arch.pc = kvm_read_c0_guest_errorepc(cop0);
 	} else {
-		printk("[%#lx] ERET when MIPS_SR_EXL|MIPS_SR_ERL == 0\n",
-		       vcpu->arch.pc);
+		kvm_err("[%#lx] ERET when MIPS_SR_EXL|MIPS_SR_ERL == 0\n",
+			vcpu->arch.pc);
 		er = EMULATE_FAIL;
 	}
 
@@ -795,7 +795,7 @@ enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 	enum emulation_result er = EMULATE_FAIL;
 	uint32_t pc = vcpu->arch.pc;
 
-	printk("[%#x] COP0_TLBR [%ld]\n", pc, kvm_read_c0_guest_index(cop0));
+	kvm_err("[%#x] COP0_TLBR [%ld]\n", pc, kvm_read_c0_guest_index(cop0));
 	return er;
 }
 
@@ -809,13 +809,12 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 	uint32_t pc = vcpu->arch.pc;
 
 	if (index < 0 || index >= KVM_MIPS_GUEST_TLB_SIZE) {
-		printk("%s: illegal index: %d\n", __func__, index);
-		printk
-		    ("[%#x] COP0_TLBWI [%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx, mask: %#lx)\n",
-		     pc, index, kvm_read_c0_guest_entryhi(cop0),
-		     kvm_read_c0_guest_entrylo0(cop0),
-		     kvm_read_c0_guest_entrylo1(cop0),
-		     kvm_read_c0_guest_pagemask(cop0));
+		kvm_debug("%s: illegal index: %d\n", __func__, index);
+		kvm_debug("[%#x] COP0_TLBWI [%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx, mask: %#lx)\n",
+			  pc, index, kvm_read_c0_guest_entryhi(cop0),
+			  kvm_read_c0_guest_entrylo0(cop0),
+			  kvm_read_c0_guest_entrylo1(cop0),
+			  kvm_read_c0_guest_pagemask(cop0));
 		index = (index & ~0x80000000) % KVM_MIPS_GUEST_TLB_SIZE;
 	}
 
@@ -853,7 +852,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 	index &= (KVM_MIPS_GUEST_TLB_SIZE - 1);
 
 	if (index < 0 || index >= KVM_MIPS_GUEST_TLB_SIZE) {
-		printk("%s: illegal index: %d\n", __func__, index);
+		kvm_err("%s: illegal index: %d\n", __func__, index);
 		return EMULATE_FAIL;
 	}
 
@@ -938,7 +937,7 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 			er = kvm_mips_emul_tlbp(vcpu);
 			break;
 		case rfe_op:
-			printk("!!!COP0_RFE!!!\n");
+			kvm_err("!!!COP0_RFE!!!\n");
 			break;
 		case eret_op:
 			er = kvm_mips_emul_eret(vcpu);
@@ -987,8 +986,8 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 			if ((rd == MIPS_CP0_TLB_INDEX)
 			    && (vcpu->arch.gprs[rt] >=
 				KVM_MIPS_GUEST_TLB_SIZE)) {
-				printk("Invalid TLB Index: %ld",
-				       vcpu->arch.gprs[rt]);
+				kvm_err("Invalid TLB Index: %ld",
+					vcpu->arch.gprs[rt]);
 				er = EMULATE_FAIL;
 				break;
 			}
@@ -998,8 +997,8 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 				kvm_change_c0_guest_ebase(cop0,
 							  ~(C0_EBASE_CORE_MASK),
 							  vcpu->arch.gprs[rt]);
-				printk("MTCz, cop0->reg[EBASE]: %#lx\n",
-				       kvm_read_c0_guest_ebase(cop0));
+				kvm_err("MTCz, cop0->reg[EBASE]: %#lx\n",
+					kvm_read_c0_guest_ebase(cop0));
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
 				uint32_t nasid =
 					vcpu->arch.gprs[rt] & ASID_MASK;
@@ -1072,9 +1071,8 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 			break;
 
 		case dmtc_op:
-			printk
-			    ("!!!!!!![%#lx]dmtc_op: rt: %d, rd: %d, sel: %d!!!!!!\n",
-			     vcpu->arch.pc, rt, rd, sel);
+			kvm_err("!!!!!!![%#lx]dmtc_op: rt: %d, rd: %d, sel: %d!!!!!!\n",
+				vcpu->arch.pc, rt, rd, sel);
 			er = EMULATE_FAIL;
 			break;
 
@@ -1119,9 +1117,8 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 			}
 			break;
 		default:
-			printk
-			    ("[%#lx]MachEmulateCP0: unsupported COP0, copz: 0x%x\n",
-			     vcpu->arch.pc, copz);
+			kvm_err("[%#lx]MachEmulateCP0: unsupported COP0, copz: 0x%x\n",
+				vcpu->arch.pc, copz);
 			er = EMULATE_FAIL;
 			break;
 		}
@@ -1242,7 +1239,7 @@ enum emulation_result kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 		break;
 
 	default:
-		printk("Store not yet supported");
+		kvm_err("Store not yet supported");
 		er = EMULATE_FAIL;
 		break;
 	}
@@ -1351,7 +1348,7 @@ enum emulation_result kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 		break;
 
 	default:
-		printk("Load not yet supported");
+		kvm_err("Load not yet supported");
 		er = EMULATE_FAIL;
 		break;
 	}
@@ -1370,7 +1367,7 @@ int kvm_mips_sync_icache(unsigned long va, struct kvm_vcpu *vcpu)
 	gfn = va >> PAGE_SHIFT;
 
 	if (gfn >= kvm->arch.guest_pmap_npages) {
-		printk("%s: Invalid gfn: %#llx\n", __func__, gfn);
+		kvm_err("%s: Invalid gfn: %#llx\n", __func__, gfn);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
 		return -1;
@@ -1378,7 +1375,8 @@ int kvm_mips_sync_icache(unsigned long va, struct kvm_vcpu *vcpu)
 	pfn = kvm->arch.guest_pmap[gfn];
 	pa = (pfn << PAGE_SHIFT) | offset;
 
-	printk("%s: va: %#lx, unmapped: %#x\n", __func__, va, CKSEG0ADDR(pa));
+	kvm_debug("%s: va: %#lx, unmapped: %#x\n", __func__, va,
+		  CKSEG0ADDR(pa));
 
 	local_flush_icache_range(CKSEG0ADDR(pa), 32);
 	return 0;
@@ -1444,8 +1442,8 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 		else if (cache == MIPS_CACHE_ICACHE)
 			r4k_blast_icache();
 		else {
-			printk("%s: unsupported CACHE INDEX operation\n",
-			       __func__);
+			kvm_err("%s: unsupported CACHE INDEX operation\n",
+				__func__);
 			return EMULATE_FAIL;
 		}
 
@@ -1504,9 +1502,8 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 			}
 		}
 	} else {
-		printk
-		    ("INVALID CACHE INDEX/ADDRESS (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
-		     cache, op, base, arch->gprs[base], offset);
+		kvm_err("INVALID CACHE INDEX/ADDRESS (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
+			cache, op, base, arch->gprs[base], offset);
 		er = EMULATE_FAIL;
 		preempt_enable();
 		goto dont_update_pc;
@@ -1536,9 +1533,8 @@ skip_fault:
 		kvm_mips_trans_cache_va(inst, opc, vcpu);
 #endif
 	} else {
-		printk
-		    ("NO-OP CACHE (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
-		     cache, op, base, arch->gprs[base], offset);
+		kvm_err("NO-OP CACHE (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
+			cache, op, base, arch->gprs[base], offset);
 		er = EMULATE_FAIL;
 		preempt_enable();
 		goto dont_update_pc;
@@ -1590,8 +1586,8 @@ enum emulation_result kvm_mips_emulate_inst(unsigned long cause, uint32_t *opc,
 		break;
 
 	default:
-		printk("Instruction emulation not supported (%p/%#x)\n", opc,
-		       inst);
+		kvm_err("Instruction emulation not supported (%p/%#x)\n", opc,
+			inst);
 		kvm_arch_vcpu_dump_regs(vcpu);
 		er = EMULATE_FAIL;
 		break;
@@ -1628,7 +1624,7 @@ enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
 
 	} else {
-		printk("Trying to deliver SYSCALL when EXL is already set\n");
+		kvm_err("Trying to deliver SYSCALL when EXL is already set\n");
 		er = EMULATE_FAIL;
 	}
 
@@ -1984,7 +1980,7 @@ enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
 
 	} else {
-		printk("Trying to deliver BP when EXL is already set\n");
+		kvm_err("Trying to deliver BP when EXL is already set\n");
 		er = EMULATE_FAIL;
 	}
 
@@ -2032,7 +2028,7 @@ enum emulation_result kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 	inst = kvm_get_inst(opc, vcpu);
 
 	if (inst == KVM_INVALID_INST) {
-		printk("%s: Cannot get inst @ %p\n", __func__, opc);
+		kvm_err("%s: Cannot get inst @ %p\n", __func__, opc);
 		return EMULATE_FAIL;
 	}
 
@@ -2099,7 +2095,7 @@ enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 	unsigned long curr_pc;
 
 	if (run->mmio.len > sizeof(*gpr)) {
-		printk("Bad MMIO length: %d", run->mmio.len);
+		kvm_err("Bad MMIO length: %d", run->mmio.len);
 		er = EMULATE_FAIL;
 		goto done;
 	}
@@ -2173,7 +2169,7 @@ static enum emulation_result kvm_mips_emulate_exc(unsigned long cause,
 			  exccode, kvm_read_c0_guest_epc(cop0),
 			  kvm_read_c0_guest_badvaddr(cop0));
 	} else {
-		printk("Trying to deliver EXC when EXL is already set\n");
+		kvm_err("Trying to deliver EXC when EXL is already set\n");
 		er = EMULATE_FAIL;
 	}
 
@@ -2213,8 +2209,8 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 			 * address error exception to the guest
 			 */
 			if (badvaddr >= (unsigned long) KVM_GUEST_KSEG0) {
-				printk("%s: LD MISS @ %#lx\n", __func__,
-				       badvaddr);
+				kvm_debug("%s: LD MISS @ %#lx\n", __func__,
+					  badvaddr);
 				cause &= ~0xff;
 				cause |= (T_ADDR_ERR_LD << CAUSEB_EXCCODE);
 				er = EMULATE_PRIV_FAIL;
@@ -2227,8 +2223,8 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 			 * address error exception to the guest
 			 */
 			if (badvaddr >= (unsigned long) KVM_GUEST_KSEG0) {
-				printk("%s: ST MISS @ %#lx\n", __func__,
-				       badvaddr);
+				kvm_debug("%s: ST MISS @ %#lx\n", __func__,
+					  badvaddr);
 				cause &= ~0xff;
 				cause |= (T_ADDR_ERR_ST << CAUSEB_EXCCODE);
 				er = EMULATE_PRIV_FAIL;
@@ -2236,8 +2232,8 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 			break;
 
 		case T_ADDR_ERR_ST:
-			printk("%s: address error ST @ %#lx\n", __func__,
-			       badvaddr);
+			kvm_debug("%s: address error ST @ %#lx\n", __func__,
+				  badvaddr);
 			if ((badvaddr & PAGE_MASK) == KVM_GUEST_COMMPAGE_ADDR) {
 				cause &= ~0xff;
 				cause |= (T_TLB_ST_MISS << CAUSEB_EXCCODE);
@@ -2245,8 +2241,8 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 			er = EMULATE_PRIV_FAIL;
 			break;
 		case T_ADDR_ERR_LD:
-			printk("%s: address error LD @ %#lx\n", __func__,
-			       badvaddr);
+			kvm_debug("%s: address error LD @ %#lx\n", __func__,
+				  badvaddr);
 			if ((badvaddr & PAGE_MASK) == KVM_GUEST_COMMPAGE_ADDR) {
 				cause &= ~0xff;
 				cause |= (T_TLB_LD_MISS << CAUSEB_EXCCODE);
@@ -2301,7 +2297,8 @@ enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
 		} else if (exccode == T_TLB_ST_MISS) {
 			er = kvm_mips_emulate_tlbmiss_st(cause, opc, run, vcpu);
 		} else {
-			printk("%s: invalid exc code: %d\n", __func__, exccode);
+			kvm_err("%s: invalid exc code: %d\n", __func__,
+				exccode);
 			er = EMULATE_FAIL;
 		}
 	} else {
@@ -2319,8 +2316,8 @@ enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
 				er = kvm_mips_emulate_tlbinv_st(cause, opc, run,
 								vcpu);
 			} else {
-				printk("%s: invalid exc code: %d\n", __func__,
-				       exccode);
+				kvm_err("%s: invalid exc code: %d\n", __func__,
+					exccode);
 				er = EMULATE_FAIL;
 			}
 		} else {
diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/kvm_mips_stats.c
index 6efef38..1ae9f88 100644
--- a/arch/mips/kvm/kvm_mips_stats.c
+++ b/arch/mips/kvm/kvm_mips_stats.c
@@ -68,12 +68,12 @@ int kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
 	int i, j;
 
-	printk("\nKVM VCPU[%d] COP0 Access Profile:\n", vcpu->vcpu_id);
+	kvm_info("\nKVM VCPU[%d] COP0 Access Profile:\n", vcpu->vcpu_id);
 	for (i = 0; i < N_MIPS_COPROC_REGS; i++) {
 		for (j = 0; j < N_MIPS_COPROC_SEL; j++) {
 			if (vcpu->arch.cop0->stat[i][j])
-				printk("%s[%d]: %lu\n", kvm_cop0_str[i], j,
-				       vcpu->arch.cop0->stat[i][j]);
+				kvm_info("%s[%d]: %lu\n", kvm_cop0_str[i], j,
+					 vcpu->arch.cop0->stat[i][j]);
 		}
 	}
 #endif
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index bb7418b..29a5bdb 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -77,8 +77,8 @@ void kvm_mips_dump_host_tlbs(void)
 	old_entryhi = read_c0_entryhi();
 	old_pagemask = read_c0_pagemask();
 
-	printk("HOST TLBs:\n");
-	printk("ASID: %#lx\n", read_c0_entryhi() & ASID_MASK);
+	kvm_info("HOST TLBs:\n");
+	kvm_info("ASID: %#lx\n", read_c0_entryhi() & ASID_MASK);
 
 	for (i = 0; i < current_cpu_data.tlbsize; i++) {
 		write_c0_index(i);
@@ -92,19 +92,19 @@ void kvm_mips_dump_host_tlbs(void)
 		tlb.tlb_lo1 = read_c0_entrylo1();
 		tlb.tlb_mask = read_c0_pagemask();
 
-		printk("TLB%c%3d Hi 0x%08lx ",
-		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
-		       i, tlb.tlb_hi);
-		printk("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
-		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
-		       (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
-		       (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
-		       (tlb.tlb_lo0 >> 3) & 7);
-		printk("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
-		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
-		       (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
-		       (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
-		       (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
+		kvm_info("TLB%c%3d Hi 0x%08lx ",
+			 (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
+			 i, tlb.tlb_hi);
+		kvm_info("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
+			 (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
+			 (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
+			 (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
+			 (tlb.tlb_lo0 >> 3) & 7);
+		kvm_info("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
+			 (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
+			 (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
+			 (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
+			 (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
 	}
 	write_c0_entryhi(old_entryhi);
 	write_c0_pagemask(old_pagemask);
@@ -119,24 +119,24 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 	struct kvm_mips_tlb tlb;
 	int i;
 
-	printk("Guest TLBs:\n");
-	printk("Guest EntryHi: %#lx\n", kvm_read_c0_guest_entryhi(cop0));
+	kvm_info("Guest TLBs:\n");
+	kvm_info("Guest EntryHi: %#lx\n", kvm_read_c0_guest_entryhi(cop0));
 
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
 		tlb = vcpu->arch.guest_tlb[i];
-		printk("TLB%c%3d Hi 0x%08lx ",
-		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
-		       i, tlb.tlb_hi);
-		printk("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
-		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
-		       (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
-		       (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
-		       (tlb.tlb_lo0 >> 3) & 7);
-		printk("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
-		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
-		       (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
-		       (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
-		       (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
+		kvm_info("TLB%c%3d Hi 0x%08lx ",
+			 (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
+			 i, tlb.tlb_hi);
+		kvm_info("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
+			 (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
+			 (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
+			 (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
+			 (tlb.tlb_lo0 >> 3) & 7);
+		kvm_info("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
+			 (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
+			 (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
+			 (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
+			 (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
 	}
 }
 EXPORT_SYMBOL(kvm_mips_dump_guest_tlbs);
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 106335b..bd2f6bc 100644
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
@@ -98,17 +98,15 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 		 * when we are not using HIGHMEM. Need to address this in a
 		 * HIGHMEM kernel
 		 */
-		printk
-		    ("TLB MOD fault not handled, cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_err("TLB MOD fault not handled, cause %#lx, PC: %p, BadVaddr: %#lx\n",
+			cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 	} else {
-		printk
-		    ("Illegal TLB Mod fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_err("Illegal TLB Mod fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
+			cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
@@ -208,9 +206,8 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		printk
-		    ("Illegal TLB ST fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_err("Illegal TLB ST fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
+			cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
@@ -233,7 +230,7 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 		kvm_debug("Emulate Store to MMIO space\n");
 		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
 		if (er == EMULATE_FAIL) {
-			printk("Emulate Store to MMIO space failed\n");
+			kvm_err("Emulate Store to MMIO space failed\n");
 			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 			ret = RESUME_HOST;
 		} else {
@@ -241,9 +238,8 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		printk
-		    ("Address Error (STORE): cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_err("Address Error (STORE): cause %#lx, PC: %p, BadVaddr: %#lx\n",
+			cause, opc, badvaddr);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 	}
@@ -263,7 +259,7 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 		kvm_debug("Emulate Load from MMIO space @ %#lx\n", badvaddr);
 		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
 		if (er == EMULATE_FAIL) {
-			printk("Emulate Load from MMIO space failed\n");
+			kvm_err("Emulate Load from MMIO space failed\n");
 			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 			ret = RESUME_HOST;
 		} else {
@@ -271,9 +267,8 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		printk
-		    ("Address Error (LOAD): cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_err("Address Error (LOAD): cause %#lx, PC: %p, BadVaddr: %#lx\n",
+			cause, opc, badvaddr);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 		er = EMULATE_FAIL;
-- 
1.8.5.3
