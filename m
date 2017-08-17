Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 09:30:15 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:52076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992126AbdHQHaCoFDHO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Aug 2017 09:30:02 +0200
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAB356A6D1;
        Thu, 17 Aug 2017 07:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com EAB356A6D1
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=david@redhat.com
Received: from [10.36.117.43] (ovpn-117-43.ams2.redhat.com [10.36.117.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 525176BF9D;
        Thu, 17 Aug 2017 07:29:52 +0000 (UTC)
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
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
References: <20170816194037.9460-1-rkrcmar@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <db11c343-d5f7-97cd-47df-ed801bad5947@redhat.com>
Date:   Thu, 17 Aug 2017 09:29:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170816194037.9460-1-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 17 Aug 2017 07:29:56 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59606
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

On 16.08.2017 21:40, Radim Krčmář wrote:
> The goal is to increase KVM_MAX_VCPUS without worrying about memory
> impact of many small guests.
> 
> This is a second out of three major "dynamic" options:
>  1) size vcpu array at VM creation time
>  2) resize vcpu array when new VCPUs are created
>  3) use a lockless list/tree for VCPUs
> 
> The disadvantage of (1) is its requirement on userspace changes and
> limited flexibility because userspace must provide the maximal count on
> start.  The main advantage is that kvm->vcpus will work like it does
> now.  It has been posted as "[PATCH 0/4] KVM: add KVM_CREATE_VM2 to
> allow dynamic kvm->vcpus array",
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1377285.html
> 
> The main problem of (2), this series, is that we cannot extend the array
> in place and therefore require some kind of protection when moving it.
> RCU seems best, but it makes the code slower and harder to deal with.
> The main advantage is that we do not need userspace changes.
> 
> The third option wasn't explored yet.  It would solve the ugly
> kvm_for_each_vcpu() of (2), but kvm_get_vcpu() would become linear.
> (We could mitigate it by having list of vcpu arrays and A lockless
>  sequentially growing "tree" would be logarithmic and not that much more
>  complicated to implement.)

That sounds interesting but also too complicated.

> 
> Which option do you think is the best?

I actually think the RCU variant doesn't look bad at all. Execution time
should be ok.

As Alex said, doubling the size every time we run out of space could be
done.

I clearly favor a solution that doesn't require user space changes.

-- 

Thanks,

David
