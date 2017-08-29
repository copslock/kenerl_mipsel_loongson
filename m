Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 15:01:18 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:40042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994946AbdH2NBEF5NMl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 15:01:04 +0200
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5345E80F9C;
        Tue, 29 Aug 2017 13:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 5345E80F9C
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=cohuck@redhat.com
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73CE077EF9;
        Tue, 29 Aug 2017 13:00:46 +0000 (UTC)
Date:   Tue, 29 Aug 2017 15:00:44 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH RFC v3 7/9] KVM: add kvm_free_vcpus and
 kvm_arch_free_vcpus
Message-ID: <20170829150044.554b5288.cohuck@redhat.com>
In-Reply-To: <45e07499-e60c-5289-f439-9c51f59866ec@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
        <20170821203530.9266-8-rkrcmar@redhat.com>
        <45e07499-e60c-5289-f439-9c51f59866ec@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 29 Aug 2017 13:00:57 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59864
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

On Tue, 22 Aug 2017 16:18:59 +0200
David Hildenbrand <david@redhat.com> wrote:

> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 33a15e176927..0d2d8b0c785c 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -750,6 +750,23 @@ static void kvm_destroy_devices(struct kvm *kvm)
> >  	}
> >  }
> >  
> > +void kvm_free_vcpus(struct kvm *kvm)
> > +{
> > +	int i;
> > +
> > +	kvm_arch_free_vcpus(kvm);  
> 
> I wonder if it would be possible to get rid of kvm_arch_free_vcpus(kvm)
> completely and simply call
> 
> kvm_for_each_vcpu(i, vcpu, kvm)
> 	kvm_arch_vcpu_free(vcpu);
> 
> at that point.
> 
> Would certainly require some refactoring, and I am not sure if we could
> modify the special mmu handling for x86 ("Unpin any mmu pages first.").
> But if in doubt, that part could be moved to kvm_arch_destroy_vm(), just
> before calling kvm_free_vcpus().

Nod, that crossed my mind as well. Would avoid adding lots of
kvm_arch_free_vcpus() that do the same thing for many archs.
