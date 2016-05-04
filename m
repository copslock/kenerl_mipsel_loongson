Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2016 19:50:47 +0200 (CEST)
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:53953 "EHLO
        e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025904AbcEDRuoYF0jj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 May 2016 19:50:44 +0200
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Wed, 4 May 2016 18:50:38 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 4 May 2016 18:50:36 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 333D61B08061
        for <linux-mips@linux-mips.org>; Wed,  4 May 2016 18:51:26 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u44HoZTn3670338
        for <linux-mips@linux-mips.org>; Wed, 4 May 2016 17:50:35 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u44HoZ05015117
        for <linux-mips@linux-mips.org>; Wed, 4 May 2016 11:50:35 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u44HoYp3015106;
        Wed, 4 May 2016 11:50:34 -0600
Received: from bahia.huguette.org (sig-9-83-105-189.evts.uk.ibm.com [9.83.105.189])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id E883B220520;
        Wed,  4 May 2016 19:50:32 +0200 (CEST)
Date:   Wed, 4 May 2016 19:50:30 +0200
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v5 2/2] kvm: introduce KVM_MAX_VCPU_ID
Message-ID: <20160504195030.4125b1ce@bahia.huguette.org>
In-Reply-To: <20160504164533.GB27590@potion>
References: <146221092579.32310.10051562885606992534.stgit@bahia.huguette.org>
        <146221113787.32310.7342723782230547207.stgit@bahia.huguette.org>
        <20160504164533.GB27590@potion>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16050417-0041-0000-0000-000017452C43
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkurz@linux.vnet.ibm.com
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

On Wed, 4 May 2016 18:45:34 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> 2016-05-03 06:52+0200, Greg Kurz:
> > The KVM_MAX_VCPUS define provides the maximum number of vCPUs per guest, and
> > also the upper limit for vCPU ids. This is okay for all archs except PowerPC
> > which can have higher ids, depending on the cpu/core/thread topology. In the
> > worst case (single threaded guest, host with 8 threads per core), it limits
> > the maximum number of vCPUS to KVM_MAX_VCPUS / 8.
> > 
> > This patch separates the vCPU numbering from the total number of vCPUs, with
> > the introduction of KVM_MAX_VCPU_ID, as the maximal valid value for vCPU ids
> > plus one.
> > 
> > The corresponding KVM_CAP_MAX_VCPU_ID allows userspace to validate vCPU ids
> > before passing them to KVM_CREATE_VCPU.
> > 
> > Only PowerPC gets unlimited vCPU ids for the moment. This patch doesn't
> > change anything for other archs.
> > 
> > Suggested-by: Radim Krcmar <rkrcmar@redhat.com>
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > @@ -2272,7 +2272,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
> >  	int r;
> >  	struct kvm_vcpu *vcpu;
> >  
> > -	if (id >= KVM_MAX_VCPUS)
> > +	if (id >= KVM_MAX_VCPU_ID)
> >  		return -EINVAL;  
> 
> book3s_hv will currently fail with vcpu_id above threads_per_subcore *
> KVM_MAX_VCORES, so userspace cannot use KVM_CAP_MAX_VCPU_ID to limit
> vcpu_id ... 

You're right, I guess powerpc should return threads_per_subcore * KVM_MAX_VCORES
instead of INT_MAX then.

> I thought the check for vcpu_id would move to arch-specific
> code, like the previous version did, to simplify implementation of a
> dynamic limit.
> 
> The dynamic limit was too complicated to be worth it?
> (This version is ok too.)
> 

Actually no, it can be as simple as this in arch/powerpc/include/asm/kvm_host.h:

#include <asm/cputhreads.h>
#define KVM_MAX_VCPU_ID		(threads_per_subcore * KVM_MAX_VCORES)

Thanks !

--
Greg
