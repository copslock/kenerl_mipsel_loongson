Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2016 18:45:49 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:55716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027974AbcEDQpqn5rbx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 May 2016 18:45:46 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 700B57AE82;
        Wed,  4 May 2016 16:45:39 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u44GjY8x023876;
        Wed, 4 May 2016 12:45:34 -0400
Received: by potion (sSMTP sendmail emulation); Wed, 04 May 2016 18:45:34 +0200
Date:   Wed, 4 May 2016 18:45:34 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v5 2/2] kvm: introduce KVM_MAX_VCPU_ID
Message-ID: <20160504164533.GB27590@potion>
References: <146221092579.32310.10051562885606992534.stgit@bahia.huguette.org>
 <146221113787.32310.7342723782230547207.stgit@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146221113787.32310.7342723782230547207.stgit@bahia.huguette.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-05-03 06:52+0200, Greg Kurz:
> The KVM_MAX_VCPUS define provides the maximum number of vCPUs per guest, and
> also the upper limit for vCPU ids. This is okay for all archs except PowerPC
> which can have higher ids, depending on the cpu/core/thread topology. In the
> worst case (single threaded guest, host with 8 threads per core), it limits
> the maximum number of vCPUS to KVM_MAX_VCPUS / 8.
> 
> This patch separates the vCPU numbering from the total number of vCPUs, with
> the introduction of KVM_MAX_VCPU_ID, as the maximal valid value for vCPU ids
> plus one.
> 
> The corresponding KVM_CAP_MAX_VCPU_ID allows userspace to validate vCPU ids
> before passing them to KVM_CREATE_VCPU.
> 
> Only PowerPC gets unlimited vCPU ids for the moment. This patch doesn't
> change anything for other archs.
> 
> Suggested-by: Radim Krcmar <rkrcmar@redhat.com>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> @@ -2272,7 +2272,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
>  	int r;
>  	struct kvm_vcpu *vcpu;
>  
> -	if (id >= KVM_MAX_VCPUS)
> +	if (id >= KVM_MAX_VCPU_ID)
>  		return -EINVAL;

book3s_hv will currently fail with vcpu_id above threads_per_subcore *
KVM_MAX_VCORES, so userspace cannot use KVM_CAP_MAX_VCPU_ID to limit
vcpu_id ... I thought the check for vcpu_id would move to arch-specific
code, like the previous version did, to simplify implementation of a
dynamic limit.

The dynamic limit was too complicated to be worth it?
(This version is ok too.)
