Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 11:28:52 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:47644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994839AbdHQJ2mr6o-g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Aug 2017 11:28:42 +0200
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D10C9D714B;
        Thu, 17 Aug 2017 09:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com D10C9D714B
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=cohuck@redhat.com
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 834FE6FB6E;
        Thu, 17 Aug 2017 09:28:31 +0000 (UTC)
Date:   Thu, 17 Aug 2017 11:28:29 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Alexander Graf <agraf@suse.de>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Christoffer Dall <cdall@linaro.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Message-ID: <20170817112829.7795820a.cohuck@redhat.com>
In-Reply-To: <b69bc1e0-9d7b-5412-ba56-a5261d539a5b@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
        <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
        <20170817093612.024cc4bc.cohuck@redhat.com>
        <b69bc1e0-9d7b-5412-ba56-a5261d539a5b@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Aug 2017 09:28:36 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59612
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

On Thu, 17 Aug 2017 11:16:59 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 17/08/2017 09:36, Cornelia Huck wrote:
> >> What if we just sent a "vcpu move" request to all vcpus with the new 
> >> pointer after it moved? That way the vcpu thread itself would be 
> >> responsible for the migration to the new memory region. Only if all 
> >> vcpus successfully moved, keep rolling (and allow foreign get_vcpu again).
> >>
> >> That way we should be basically lock-less and scale well. For additional 
> >> icing, feel free to increase the vcpu array x2 every time it grows to 
> >> not run into the slow path too often.  
> > 
> > I'd prefer the rcu approach: This is a mechanism already understood
> > well, no need to come up with a new one that will likely have its own
> > share of problems.  
> 
> What Alex is proposing _is_ RCU, except with a homegrown
> synchronize_rcu.  Using kvm->srcu seems to be the best of both worlds.

I'm worried a bit about the 'homegrown' part, though.

I also may be misunderstanding what Alex means with "vcpu move"...
