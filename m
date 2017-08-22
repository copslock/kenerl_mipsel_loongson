Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2017 13:43:25 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:59322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990557AbdHVLnRfXV6t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Aug 2017 13:43:17 +0200
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D058E83F42;
        Tue, 22 Aug 2017 11:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com D058E83F42
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=david@redhat.com
Received: from [10.36.117.62] (ovpn-117-62.ams2.redhat.com [10.36.117.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E650760C21;
        Tue, 22 Aug 2017 11:43:07 +0000 (UTC)
Subject: Re: [PATCH RFC v3 2/9] KVM: arm/arm64: fix vcpu self-detection in
 vgic_v3_dispatch_sgi()
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-3-rkrcmar@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a6c6b3e0-ded0-f81b-7b14-c85a12e513b5@redhat.com>
Date:   Tue, 22 Aug 2017 13:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170821203530.9266-3-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 22 Aug 2017 11:43:11 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@redhat.com
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

On 21.08.2017 22:35, Radim Krčmář wrote:
> The index in kvm->vcpus array and vcpu->vcpu_id are very different
> things.  Comparing struct kvm_vcpu pointers is a sure way to know.
> 
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index 408ef06638fc..9d4b69b766ec 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -797,7 +797,6 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
>  	u16 target_cpus;
>  	u64 mpidr;
>  	int sgi, c;
> -	int vcpu_id = vcpu->vcpu_id;
>  	bool broadcast;
>  
>  	sgi = (reg & ICC_SGI1R_SGI_ID_MASK) >> ICC_SGI1R_SGI_ID_SHIFT;
> @@ -821,7 +820,7 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
>  			break;
>  
>  		/* Don't signal the calling VCPU */
> -		if (broadcast && c == vcpu_id)
> +		if (broadcast && c_vcpu == vcpu)
>  			continue;
>  
>  		if (!broadcast) {
> 

Yes, this looks correct to me.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
