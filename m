Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 19:19:37 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:53172 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6827653Ab3BOSTgeqCMI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Feb 2013 19:19:36 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Fri, 15 Feb 2013 10:19:27 -0800
Subject: Re: [PATCH v2 07/18] KVM/MIPS32: MMU/TLB operations for the Guest.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1255
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <20130206120820.GN23213@redhat.com>
Date:   Fri, 15 Feb 2013 13:19:29 -0500
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <69F3ED2A-A9B3-4046-9B40-98125ED5A8FB@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com> <1353551656-23579-8-git-send-email-sanjayl@kymasys.com> <20130206120820.GN23213@redhat.com>
To:     Gleb Natapov <gleb@redhat.com>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 35774
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
Return-Path: <linux-mips-bounce@linux-mips.org>


On Feb 6, 2013, at 7:08 AM, Gleb Natapov wrote:

>> 
>> +static void kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
>> +{
>> +	pfn_t pfn;
>> +
>> +	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
>> +		return;
>> +
>> +	pfn =kvm_mips_gfn_to_pfn(kvm, gfn);
> This call should be in srcu read section since it access memory slots which
> are srcu protected. You should test with RCU debug enabled.

kvm_mips_gfn_to_pfn just maps to gfn_to_pfn. I don't see an instance where gfn_to_pfn is in a scru read section?

> 
>> 
>> +
>> +uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
>> +{
>> +	uint32_t inst;
>> +	struct mips_coproc *cop0 __unused = vcpu->arch.cop0;
>> +	int index;
>> +	ulong paddr, flags;
>> +
>> +	if (KVM_GUEST_KSEGX((ulong) opc) < KVM_GUEST_KSEG0 ||
>> +	    KVM_GUEST_KSEGX((ulong) opc) == KVM_GUEST_KSEG23) {
>> +		local_irq_save(flags);
>> +		index = kvm_mips_host_tlb_lookup(vcpu, (ulong) opc);
>> +		if (index >= 0) {
>> +			inst = *(opc);
> Here and in some more places below you access __user memory. Shouldn't you
> use get_user() to access it? What prevents the kernel crash by access fault here
> if userspace remaps the memory to be non-readable? Hmm, may be it uses
> guest translation here so it cannot happen, but still, sparse will not
> be happy and kvm_mips_translate_guest_kseg0_to_hpa() case below uses
> host translation anyway.
> 
Actually, I don't need the __user declaration in most cases, since KVM/MIPS handles mapping the page (if needed) and does not rely on the usual kernel mechanisms.
