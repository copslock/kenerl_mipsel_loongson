Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 09:36:37 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:51836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992456AbdHQHg0lKIOO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 09:36:26 +0200
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 064FCD7159;
        Thu, 17 Aug 2017 07:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 064FCD7159
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=cohuck@redhat.com
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51437600CA;
        Thu, 17 Aug 2017 07:36:14 +0000 (UTC)
Date:   Thu, 17 Aug 2017 09:36:12 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alexander Graf <agraf@suse.de>
Cc:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Christoffer Dall <cdall@linaro.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Message-ID: <20170817093612.024cc4bc.cohuck@redhat.com>
In-Reply-To: <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
        <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Aug 2017 07:36:19 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59607
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

On Thu, 17 Aug 2017 09:04:14 +0200
Alexander Graf <agraf@suse.de> wrote:

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
> Creating/Destroying vcpus is not something I consider a fast path, so 
> why should we optimize for it? The case that needs to be fast is execution.
> 
> What if we just sent a "vcpu move" request to all vcpus with the new 
> pointer after it moved? That way the vcpu thread itself would be 
> responsible for the migration to the new memory region. Only if all 
> vcpus successfully moved, keep rolling (and allow foreign get_vcpu again).
> 
> That way we should be basically lock-less and scale well. For additional 
> icing, feel free to increase the vcpu array x2 every time it grows to 
> not run into the slow path too often.

I'd prefer the rcu approach: This is a mechanism already understood
well, no need to come up with a new one that will likely have its own
share of problems.
