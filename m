Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 10:07:50 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:60694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992864AbdHQIHfMbQhO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 10:07:35 +0200
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B65B8C053FAC;
        Thu, 17 Aug 2017 08:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com B65B8C053FAC
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=cohuck@redhat.com
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D85915C899;
        Thu, 17 Aug 2017 08:07:23 +0000 (UTC)
Date:   Thu, 17 Aug 2017 10:07:21 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH RFC 2/2] KVM: RCU protected dynamic vcpus array
Message-ID: <20170817100721.3d92f236.cohuck@redhat.com>
In-Reply-To: <20170816194037.9460-3-rkrcmar@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
        <20170816194037.9460-3-rkrcmar@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 17 Aug 2017 08:07:29 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cohuck@redhat.com
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

On Wed, 16 Aug 2017 21:40:37 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> This is a prototype with many TODO comments to give a better idea of
> what would be needed.

Just a very superficial reading...

> 
> The main missing piece a rework of every kvm_for_each_vcpu() into a less
> inefficient loop, but RCU readers cannot block, so the rewrite cannot be
> scripted.   Is there a more suitable protection scheme?
> 
> I didn't test it much ... I am still leaning towards the internally
> simpler version, (1), even if it requires userspace changes.
> ---
>  arch/mips/kvm/mips.c       |  8 +++---
>  arch/powerpc/kvm/powerpc.c |  6 +++--
>  arch/s390/kvm/kvm-s390.c   | 27 ++++++++++++++------
>  arch/x86/kvm/hyperv.c      |  3 +--
>  arch/x86/kvm/vmx.c         |  3 ++-
>  arch/x86/kvm/x86.c         |  5 ++--
>  include/linux/kvm_host.h   | 61 ++++++++++++++++++++++++++++++++++------------
>  virt/kvm/arm/arm.c         | 10 +++-----
>  virt/kvm/kvm_main.c        | 58 +++++++++++++++++++++++++++++++++++--------
>  9 files changed, 132 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index bce2a6431430..4c9d383babe7 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -164,6 +164,7 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
>  {
>  	unsigned int i;
>  	struct kvm_vcpu *vcpu;
> +	struct kvm_vcpus *vcpus;
>  
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		kvm_arch_vcpu_free(vcpu);
> @@ -171,8 +172,9 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
>  
>  	mutex_lock(&kvm->lock);
>  
> -	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
> -		kvm->vcpus[i] = NULL;
> +	// TODO: resetting online vcpus shouldn't be needed
> +	vcpus = rcu_dereference_protected(kvm->vcpus, lockdep_is_held(&kvm->lock));
> +	vcpus->online = 0;

This seems to be a pattern used on nearly all architectures, so maybe
it was simply copied?

Iff we really need it (probably not), it seems like something that can
be done by common code.

>  
>  	atomic_set(&kvm->online_vcpus, 0);
>  
(...)
> @@ -3422,12 +3424,16 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
>  	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
>  	/* Only one cpu at a time may enter/leave the STOPPED state. */
>  	spin_lock(&vcpu->kvm->arch.start_stop_lock);
> -	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
>  
> -	for (i = 0; i < online_vcpus; i++) {
> -		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i]))
> +	rcu_read_lock();
> +	vcpus = rcu_dereference(vcpu->kvm->vcpus);
> +	// TODO: this pattern is kvm_for_each_vcpu
> +	for (i = 0; i < vcpus->online; i++) {
> +		if (!is_vcpu_stopped(vcpus->array[i]))
>  			started_vcpus++;
> +		// TODO: if (started_vcpus > 1) break;
>  	}
> +	rcu_read_unlock();
>  
>  	if (started_vcpus == 0) {
>  		/* we're the only active VCPU -> speed it up */
> @@ -3455,6 +3461,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>  {
>  	int i, online_vcpus, started_vcpus = 0;
>  	struct kvm_vcpu *started_vcpu = NULL;
> +	struct kvm_vcpus *vcpus;
>  
>  	if (is_vcpu_stopped(vcpu))
>  		return;
> @@ -3470,12 +3477,16 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>  	atomic_or(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
>  	__disable_ibs_on_vcpu(vcpu);
>  
> +	rcu_read_lock();
> +	vcpus = rcu_dereference(vcpu->kvm->vcpus);
> +	// TODO: use kvm_for_each_vcpu
>  	for (i = 0; i < online_vcpus; i++) {
> -		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i])) {
> +		if (!is_vcpu_stopped(vcpus->array[i])) {
>  			started_vcpus++;
> -			started_vcpu = vcpu->kvm->vcpus[i];
> +			started_vcpu = vcpus->array[i];
>  		}
>  	}
> +	rcu_read_unlock();

These two only care for two cases: 0 started cpus <-> 1 started cpu and
1 started cpu <-> 2 started cpus. Maybe it is more reasonable to track
that in the arch code instead of walking the array.

>  
>  	if (started_vcpus == 1) {
>  		/*
(...)
> @@ -2518,20 +2552,24 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
>  		goto unlock_vcpu_destroy;
>  	}
>  
> -	kvm->vcpus[atomic_read(&kvm->online_vcpus)] = vcpu;
> -
> -	/*
> -	 * Pairs with smp_rmb() in kvm_get_vcpu.  Write kvm->vcpus
> -	 * before kvm->online_vcpu's incremented value.
> -	 */
> -	smp_wmb();
> -	atomic_inc(&kvm->online_vcpus);
> +	new->array[old->online] = vcpu;
> +	rcu_assign_pointer(kvm->vcpus, new);
>  
>  	mutex_unlock(&kvm->lock);
> +
> +	// we could schedule a callback instead
> +	synchronize_rcu();
> +	kfree(old);
> +
> +	// TODO: No longer synchronizes anything in the common code.
> +	// Remove if the arch-specific uses were mostly hacks.
> +	atomic_inc(&kvm->online_vcpus);

Much of the arch code seems to care about one of two things:
- What is the upper limit for cpu searches?
- Has at least one cpu been created?

> +
>  	kvm_arch_vcpu_postcreate(vcpu);
>  	return r;
>  
>  unlock_vcpu_destroy:
> +	kvfree(new);
>  	mutex_unlock(&kvm->lock);
>  	debugfs_remove_recursive(vcpu->debugfs_dentry);
>  vcpu_destroy:
