Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 19:42:05 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:37251 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827660Ab3BOSmEq0bf8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 19:42:04 +0100
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r1FIg1eN029458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 15 Feb 2013 13:42:01 -0500
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r1FIfx3A024722;
        Fri, 15 Feb 2013 13:42:00 -0500
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 58B8D18D479; Fri, 15 Feb 2013 20:41:59 +0200 (IST)
Date:   Fri, 15 Feb 2013 20:41:59 +0200
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 07/18] KVM/MIPS32: MMU/TLB operations for the Guest.
Message-ID: <20130215184159.GA16755@redhat.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
 <1353551656-23579-8-git-send-email-sanjayl@kymasys.com>
 <20130206120820.GN23213@redhat.com>
 <69F3ED2A-A9B3-4046-9B40-98125ED5A8FB@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69F3ED2A-A9B3-4046-9B40-98125ED5A8FB@kymasys.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
X-archive-position: 35776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Fri, Feb 15, 2013 at 01:19:29PM -0500, Sanjay Lal wrote:
> 
> On Feb 6, 2013, at 7:08 AM, Gleb Natapov wrote:
> 
> >> 
> >> +static void kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
> >> +{
> >> +	pfn_t pfn;
> >> +
> >> +	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
> >> +		return;
> >> +
> >> +	pfn =kvm_mips_gfn_to_pfn(kvm, gfn);
> > This call should be in srcu read section since it access memory slots which
> > are srcu protected. You should test with RCU debug enabled.
> 
> kvm_mips_gfn_to_pfn just maps to gfn_to_pfn. I don't see an instance where gfn_to_pfn is in a scru read section?
> 
Where are you looking?  On x86 if vcpu is not in a guest mode it is in
srcu read section. The lock is taken immediately after exit and released
before entry. This is because x86 access memory slots a lot. Other
arches, that do not access memory slots as much, take the lock around
each individual access. As far as I see this is the only place in MIPS
kvm where this is needed.

> > 
> >> 
> >> +
> >> +uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
> >> +{
> >> +	uint32_t inst;
> >> +	struct mips_coproc *cop0 __unused = vcpu->arch.cop0;
> >> +	int index;
> >> +	ulong paddr, flags;
> >> +
> >> +	if (KVM_GUEST_KSEGX((ulong) opc) < KVM_GUEST_KSEG0 ||
> >> +	    KVM_GUEST_KSEGX((ulong) opc) == KVM_GUEST_KSEG23) {
> >> +		local_irq_save(flags);
> >> +		index = kvm_mips_host_tlb_lookup(vcpu, (ulong) opc);
> >> +		if (index >= 0) {
> >> +			inst = *(opc);
> > Here and in some more places below you access __user memory. Shouldn't you
> > use get_user() to access it? What prevents the kernel crash by access fault here
> > if userspace remaps the memory to be non-readable? Hmm, may be it uses
> > guest translation here so it cannot happen, but still, sparse will not
> > be happy and kvm_mips_translate_guest_kseg0_to_hpa() case below uses
> > host translation anyway.
> > 
> Actually, I don't need the __user declaration in most cases, since KVM/MIPS handles mapping the page (if needed) and does not rely on the usual kernel mechanisms.
Yes I see that you check/populate tlb for non KVM_GUEST_KSEG0 access,
for kvm_mips_translate_guest_kseg0_to_hpa() you do not, but now I notice
that you are not using the address directly but uses CKSEG0ADDR() on it,
which, as far as I can tell, gives you kernel mapping for the page,
correct? Why this is better than using get_user()? To save tlb entries?

--
			Gleb.
