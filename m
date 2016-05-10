Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 19:17:43 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:34566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028712AbcEJRRcgNHFO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 19:17:32 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 835913B725;
        Tue, 10 May 2016 17:17:29 +0000 (UTC)
Received: from [10.36.112.32] (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4AHHNqQ006742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 10 May 2016 13:17:25 -0400
Subject: Re: [PATCH v6 2/2] kvm: introduce KVM_MAX_VCPU_ID
To:     Cornelia Huck <cornelia.huck@de.ibm.com>,
        Greg Kurz <gkurz@linux.vnet.ibm.com>
References: <146281031018.17210.8148336192033754193.stgit@bahia.huguette.org>
 <146281032358.17210.17266631315196879115.stgit@bahia.huguette.org>
 <20160509182339.04fe7ef2.cornelia.huck@de.ibm.com>
Cc:     james.hogan@imgtec.com, mingo@redhat.com,
        linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <573217A2.6080709@redhat.com>
Date:   Tue, 10 May 2016 19:17:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <20160509182339.04fe7ef2.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 10 May 2016 17:17:29 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 09/05/2016 18:23, Cornelia Huck wrote:
> On Mon, 09 May 2016 18:13:37 +0200
> Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
> 
>> The KVM_MAX_VCPUS define provides the maximum number of vCPUs per guest, and
>> also the upper limit for vCPU ids. This is okay for all archs except PowerPC
>> which can have higher ids, depending on the cpu/core/thread topology. In the
>> worst case (single threaded guest, host with 8 threads per core), it limits
>> the maximum number of vCPUS to KVM_MAX_VCPUS / 8.
>>
>> This patch separates the vCPU numbering from the total number of vCPUs, with
>> the introduction of KVM_MAX_VCPU_ID, as the maximal valid value for vCPU ids
>> plus one.
>>
>> The corresponding KVM_CAP_MAX_VCPU_ID allows userspace to validate vCPU ids
>> before passing them to KVM_CREATE_VCPU.
>>
>> This patch only implements KVM_MAX_VCPU_ID with a specific value for PowerPC.
>> Other archs continue to return KVM_MAX_VCPUS instead.
>>
>> Suggested-by: Radim Krcmar <rkrcmar@redhat.com>
>> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
>> ---
>> v6: - provide cap in generic code (Cornelia)
>>     - change PowerPC limit to threads_per_subcore * KVM_MAX_VCORES (Radim)
>> ---
>>  Documentation/virtual/kvm/api.txt   |   10 ++++++++--
>>  arch/powerpc/include/asm/kvm_host.h |    3 +++
>>  include/linux/kvm_host.h            |    4 ++++
>>  include/uapi/linux/kvm.h            |    1 +
>>  virt/kvm/kvm_main.c                 |    4 +++-
>>  5 files changed, 19 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 

Series pushed to kvm/queue, thanks.

Paolo
