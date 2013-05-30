Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 20:35:25 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:35469 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6824780Ab3E3SfUzYd0p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 20:35:20 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Thu, 30 May 2013 11:35:09 -0700
Subject: Re: [PATCH 06/18] KVM/MIPS32-VZ: VZ-ASE related callbacks to handle guest exceptions that trap to the Root context.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <51A4C776.8070002@redhat.com>
Date:   Thu, 30 May 2013 11:35:09 -0700
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D2B59A2E-6802-43BB-887C-A021507C21BB@kymasys.com>
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-7-git-send-email-sanjayl@kymasys.com> <51A4C776.8070002@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36651
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


On May 28, 2013, at 8:04 AM, Paolo Bonzini wrote:

> Il 19/05/2013 07:47, Sanjay Lal ha scritto:
>> +static int kvm_vz_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>> +{
>> +	struct mips_coproc *cop0 = vcpu->arch.cop0;
>> +
>> +	/* some registers are not restored
>> +	 * random, count        : read-only
>> +	 * userlocal            : not implemented in qemu
>> +	 * config6              : not implemented in processor variant
>> +	 * compare, cause       : defer to kvm_vz_restore_guest_timer_int
>> +	 */
>> +
>> +	kvm_write_c0_guest_index(cop0, regs->cp0reg[MIPS_CP0_TLB_INDEX][0]);
>> +	kvm_write_c0_guest_entrylo0(cop0, regs->cp0reg[MIPS_CP0_TLB_LO0][0]);
>> +	kvm_write_c0_guest_entrylo1(cop0, regs->cp0reg[MIPS_CP0_TLB_LO1][0]);
>> +	kvm_write_c0_guest_context(cop0, regs->cp0reg[MIPS_CP0_TLB_CONTEXT][0]);
>> +	kvm_write_c0_guest_pagemask(cop0,
>> +				    regs->cp0reg[MIPS_CP0_TLB_PG_MASK][0]);
>> +	kvm_write_c0_guest_pagegrain(cop0,
>> +				     regs->cp0reg[MIPS_CP0_TLB_PG_MASK][1]);
>> +	kvm_write_c0_guest_wired(cop0, regs->cp0reg[MIPS_CP0_TLB_WIRED][0]);
>> +	kvm_write_c0_guest_hwrena(cop0, regs->cp0reg[MIPS_CP0_HWRENA][0]);
>> +	kvm_write_c0_guest_badvaddr(cop0, regs->cp0reg[MIPS_CP0_BAD_VADDR][0]);
>> +	/* skip kvm_write_c0_guest_count */
>> +	kvm_write_c0_guest_entryhi(cop0, regs->cp0reg[MIPS_CP0_TLB_HI][0]);
>> +	/* defer kvm_write_c0_guest_compare */
>> +	kvm_write_c0_guest_status(cop0, regs->cp0reg[MIPS_CP0_STATUS][0]);
>> +	kvm_write_c0_guest_intctl(cop0, regs->cp0reg[MIPS_CP0_STATUS][1]);
>> +	/* defer kvm_write_c0_guest_cause */
>> +	kvm_write_c0_guest_epc(cop0, regs->cp0reg[MIPS_CP0_EXC_PC][0]);
>> +	kvm_write_c0_guest_prid(cop0, regs->cp0reg[MIPS_CP0_PRID][0]);
>> +	kvm_write_c0_guest_ebase(cop0, regs->cp0reg[MIPS_CP0_PRID][1]);
>> +
>> +	/* only restore implemented config registers */
>> +	kvm_write_c0_guest_config(cop0, regs->cp0reg[MIPS_CP0_CONFIG][0]);
>> +
>> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][0] & MIPS_CONF_M) &
>> +			cpu_vz_has_config1)
>> +		kvm_write_c0_guest_config1(cop0,
>> +				regs->cp0reg[MIPS_CP0_CONFIG][1]);
>> +
>> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][1] & MIPS_CONF_M) &
>> +			cpu_vz_has_config2)
>> +		kvm_write_c0_guest_config2(cop0,
>> +				regs->cp0reg[MIPS_CP0_CONFIG][2]);
>> +
>> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][2] & MIPS_CONF_M) &
>> +			cpu_vz_has_config3)
>> +		kvm_write_c0_guest_config3(cop0,
>> +				regs->cp0reg[MIPS_CP0_CONFIG][3]);
>> +
>> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][3] & MIPS_CONF_M) &
>> +			cpu_vz_has_config4)
>> +		kvm_write_c0_guest_config4(cop0,
>> +				regs->cp0reg[MIPS_CP0_CONFIG][4]);
>> +
>> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][4] & MIPS_CONF_M) &
>> +			cpu_vz_has_config5)
>> +		kvm_write_c0_guest_config5(cop0,
>> +				regs->cp0reg[MIPS_CP0_CONFIG][5]);
>> +
>> +	if (cpu_vz_has_config6)
>> +		kvm_write_c0_guest_config6(cop0,
>> +				regs->cp0reg[MIPS_CP0_CONFIG][6]);
>> +	if (cpu_vz_has_config7)
>> +		kvm_write_c0_guest_config7(cop0,
>> +				regs->cp0reg[MIPS_CP0_CONFIG][7]);
>> +
>> +	kvm_write_c0_guest_errorepc(cop0, regs->cp0reg[MIPS_CP0_ERROR_PC][0]);
>> +
>> +	/* call after setting MIPS_CP0_CAUSE to avoid having it overwritten
>> +	 * this will set guest compare and cause.TI if necessary
>> +	 */
>> +	kvm_vz_restore_guest_timer_int(vcpu, regs);
>> +
>> +	return 0;
>> +}
> 
> All this is now obsolete after David's patches (reusing kvm_regs looked
> a bit strange in fact).
> 
> Paolo
> 

These patched were against 3.10-rc2, now that David's patches have been accepted, I'll migrate to the new ABI for v2 of the patch set.

Regards
Sanjay
