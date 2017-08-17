Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 16:54:37 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:47144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994877AbdHQOyZxGSkI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Aug 2017 16:54:25 +0200
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F169356DA;
        Thu, 17 Aug 2017 14:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 7F169356DA
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=rkrcmar@redhat.com
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id C62F7614D0;
        Thu, 17 Aug 2017 14:54:12 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 17 Aug 2017 16:54:12 +0200
Date:   Thu, 17 Aug 2017 16:54:12 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Alexander Graf <agraf@suse.de>
Cc:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Christoffer Dall <cdall@linaro.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Message-ID: <20170817145411.GE2566@flask>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 17 Aug 2017 14:54:19 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59622
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

2017-08-17 09:04+0200, Alexander Graf:
> On 16.08.17 21:40, Radim Krčmář  wrote:
> > The goal is to increase KVM_MAX_VCPUS without worrying about memory
> > impact of many small guests.
> > 
> > This is a second out of three major "dynamic" options:
> >   1) size vcpu array at VM creation time
> >   2) resize vcpu array when new VCPUs are created
> >   3) use a lockless list/tree for VCPUs
> > 
> > The disadvantage of (1) is its requirement on userspace changes and
> > limited flexibility because userspace must provide the maximal count on
> > start.  The main advantage is that kvm->vcpus will work like it does
> > now.  It has been posted as "[PATCH 0/4] KVM: add KVM_CREATE_VM2 to
> > allow dynamic kvm->vcpus array",
> > http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1377285.html
> > 
> > The main problem of (2), this series, is that we cannot extend the array
> > in place and therefore require some kind of protection when moving it.
> > RCU seems best, but it makes the code slower and harder to deal with.
> > The main advantage is that we do not need userspace changes.
> 
> Creating/Destroying vcpus is not something I consider a fast path, so why
> should we optimize for it? The case that needs to be fast is execution.

Right, the creation is not important.  I was concerned about the use of
lock() and unlock() needed for every access -- both in performance and
code, because the common case where hotplug doesn't happen and all VCPUs
are created upfront doesn't even need any runtime protection.

> What if we just sent a "vcpu move" request to all vcpus with the new pointer
> after it moved? That way the vcpu thread itself would be responsible for the
> migration to the new memory region. Only if all vcpus successfully moved,
> keep rolling (and allow foreign get_vcpu again).

I'm not sure if I understood this.  You propose to cache kvm->vcpus in
vcpu->vcpus and do an extensions of this,

  int vcpu_create(...) {
    if (resize_needed(kvm->vcpus)) {
      old_vcpus = kvm->vcpus
      kvm->vcpus = make_bigger(kvm->vcpus)
      kvm_make_all_cpus_request(kvm, KVM_REQ_UPDATE_VCPUS)
      free(old_vcpus)
    }
    vcpu->vcpus = kvm->vcpus
  }

with added extra locking, (S)RCU, on accesses that do not come from
VCPUs (irqfd and VM ioctl)?

> That way we should be basically lock-less and scale well. For additional
> icing, feel free to increase the vcpu array x2 every time it grows to not
> run into the slow path too often.

Yeah, I skipped the growing as it was not necessary for the
illustration.
